~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Core.eval_file(&1))

use Mix.Releases.Config,
  default_release: :default,
  default_environment: Mix.env()

environment :dev0 do
  set dev_mode: true
  set include_erts: true
  set cookie: :dev0cookie
end

environment :dev do
  set include_erts: true
  set include_src: false
  set cookie: :devcookie
  set vm_args: "rel/vm.args"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :prodcookie
  set vm_args: "rel/vm.args"
end

release :eggman do
  set version: current_version(:eggman)
  set applications: [
    :runtime_tools
  ]
end
