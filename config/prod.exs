use Mix.Config

config :shield_notifier, Shield.Notifier.Mailer,
  adapter: Bamboo.SendgridAdapter,
  api_key: SYSTEM.get_env("SENDGRID_API_KEY")
