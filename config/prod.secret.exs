use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :phoenix_commerce, PhoenixCommerce.Endpoint,
  secret_key_base: "u73wDnMM9i5mb5f5beiOHWNv4Urp6UojhgLCYij3aQrLQ51ohL0Qy/JwLJqQdpOS"

# Configure your database
config :phoenix_commerce, PhoenixCommerce.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "phoenix_commerce_prod",
  pool_size: 20
