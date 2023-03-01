import Config

config :logger, level: :info
config :ex_unit, capture_log: true

config :rivet,
  repo: Rivet.Auth.Repo,
  table_prefix: "",
  test: true


config :rivet_auth,
  ecto_repos: [Rivet.Auth.Repo]

config :rivet_auth, Rivet.Auth.Repo,
  migration_repo: Rivet.Auth.Repo,
  pool_size: 20,
  username: "postgres",
  password: "",
  database: "rivet_data_ident_#{config_env()}",
  hostname: "localhost",
  log: false,
  pool: Ecto.Adapters.SQL.Sandbox

config :rivet, Rivet.Data.Ident, table_prefix: "ident_"
# first_user_admin: false,
# reset_code_expire_mins: 1440,
# notify_templates: [
#   failed_change: Rivet.Data.Ident.User.Notify.FailedChange,
#   verification: Rivet.Data.Ident.User.Notify.Verification,
#   password_reset: Rivet.Data.Ident.User.Notify.PasswordReset,
#   password_changed: Rivet.Data.Ident.User.Notify.PasswordChanged
# ],
# table_prefix: "ident_",
# table_names: [
#   accesses: "accesses",
#   actions: "actions",
#   emails: "emails",
#   factors: "factors",
#   handles: "handles",
#   phones: "phones",
#   roles: "roles",
#   role_maps: "role_maps",
#   users: "users",
#   user_codes: "user_codes",
#   user_datas: "user_datas"
# ]
