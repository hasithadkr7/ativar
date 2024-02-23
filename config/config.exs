import Config

config :ex_money,
  exchange_rates_retrieve_every: 3_000,
  api_module: Money.ExchangeRates.OpenExchangeRates,
  callback_module: Money.ExchangeRates.Callback,
  exchange_rates_cache_module: Money.ExchangeRates.Cache.Ets,
  preload_historic_rates: true,
  open_exchange_rates_app_id: "2c0f4cc37ac9437b8e273d639ac86c56",
  log_failure: :warning,
  log_info: :info,
  json_library: Jason,
  default_cldr_backend: Ativar.Locale,
  exclude_protocol_implementations: []

config :ativar,
  ecto_repos: [Ativar.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :ativar, AtivarWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: AtivarWeb.ErrorHTML],
    layout: false
  ],
  pubsub_server: Ativar.PubSub,
  live_view: [signing_salt: "ryZ6by1g"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  default: [
    args:
      ~w(css/app.css js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
