defmodule Mix.Tasks.Egg.Release do
  use Mix.Task

  @shortdoc "Build Eggman Release Package"

  @moduledoc """
  Build Eggman release package.

  mix egg.release
  """
  alias Mix.Releases.{Release, Config, Assembler, Overlays, Shell, Utils, Errors}

  @doc false
  def run(args) do
    Mix.shell.info("--- start compile ---")

    opts = Mix.Tasks.Release.parse_args(args)
    #Mix.shell.info("opts:")
    #IO.inspect opts

    verbosity = Keyword.get(opts, :verbosity)
    #Mix.shell.info("verbosity:")
    #IO.inspect verbosity

    Shell.configure(verbosity)

    {:ok, config} = Config.get(opts)
    #Mix.shell.info("config:")
    #IO.inspect config

    Mix.Task.run("compile", [])
    Mix.shell.info("--- start loadpaths ---")
    Mix.Task.run("loadpaths", [])

    do_release(config)
  end

  @doc false
  defp do_release(config) do
    Mix.shell.info("--- start do_release ---")
    {:ok, release} = do_assemble(config)
    {:ok, release} = apply_overlays(release)
    {:ok, _release} = package(release)
    :ok
  end

  @doc false
  defp do_assemble(config) do
    Mix.shell.info("--- start do_assemble ---")
    Assembler.assemble(config)
  end

  @doc false
  defp apply_overlays(release) do
    Mix.shell.info("--- start apply_overlays ---")

    lambda_overlays = [{:template, template_path("bootstrap"), "bootstrap"}]
    overlays = lambda_overlays ++ release.profile.overlays
    output_dir = release.profile.output_dir
    overlay_vars = release.profile.overlay_vars

    with {:ok, _paths} <- Overlays.apply(output_dir, overlays, overlay_vars),
         # distillery overlays do not preserve files flags
         :ok <- make_executable(Path.join(output_dir, "bootstrap")),
    do: {:ok, release}
  end
  defp template_path(name), do: Path.join("priv/templates", name)
  defp make_executable(path) do
    case File.chmod(path, 0o755) do
      :ok ->
        :ok
      {:error, reason} ->
        {:error, {:chmod, path, reason}}
    end
  end

  @doc false
  defp package(release) do
    Mix.shell.info("--- start package ---")
    with {:ok, tmpdir} <- Utils.insecure_mkdir_temp(),
         tmp_package_path = package_path(release, tmpdir),
         Mix.shell.info("tmp_package_path:#{inspect tmp_package_path}"),
         :ok <- make_package(release, tmp_package_path),
         :ok <- file_cp(tmp_package_path, package_path(release)),
         Mix.shell.info("package_path:#{inspect package_path(release)}"),
         _ <- File.rm_rf(tmpdir),
    do: {:ok, release}
  end
  defp package_path(release), do: package_path(release, Release.version_path(release))
  defp package_path(release, base_dir), do: Path.join(base_dir, package_name(release))
  defp package_name(release), do: "#{release.name}.zip"
  defp file_cp(src, dst) do
    case File.cp(src, dst) do
      :ok ->
        :ok
      {:error, reason} ->
        {:error, {:file_copy, {src, dst}, reason}}
    end
  end

  defp make_package(release, zip_path) do
    Mix.shell.info("--- start make_package ---")
    release_dir = Path.expand(release.profile.output_dir)
    targets = targets(release)
    exclusions =
      archive_paths(release)
      |> Enum.map(&(Path.relative_to(&1, release_dir)))

    case make_zip(zip_path, release_dir, targets, exclusions) do
      :ok ->
        Mix.shell.info("Successfully built zip package: #{zip_path}")
      {:error, reason} ->
        {:error, {:make_zip, reason}}
    end
  end
  defp targets(release), do: [
    "erts-#{release.profile.erts_version}",
    "bin",
    "lib",
    "releases",
    "bootstrap"
  ]
  defp archive_paths(release), do: [
    Path.join(Release.version_path(release), "*.tar.gz"),
    Path.join(Release.version_path(release), "*.zip"),
    Path.join(Release.bin_path(release), "*.run")
  ]
  defp make_zip(zip_path, cwd, targets, exclusions) do
    args = ["-q", "-r", zip_path] ++ targets ++ ["-x" | exclusions]
    command = "zip #{args |> Enum.join(" ")}"
    Shell.debug("$ #{command}")
    case System.cmd("zip", args, cd: cwd) do
      {_output, 0} ->
        :ok
      {output, exit_code} ->
        {:error, {command, exit_code, output}}
    end
  end
end
