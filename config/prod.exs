use Mix.Config

config :ex_aws,
  debug_requests: false,
  access_key_id: [{:system, "AWS_ACCESS_KEY_ID"}, :instance_role],
  secret_access_key: [{:system, "AWS_SECRET_ACCESS_KEY"}, :instance_role],
  region: System.get_env("AWS_REGION")

config :ex_aws, :hackney_opts,
  follow_redirect: true,
  recv_timeout: 30_000
