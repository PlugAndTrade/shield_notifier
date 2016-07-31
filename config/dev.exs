use Mix.Config

config :shield_notifier, Shield.Notifier.Mailer,
  adapter: Bamboo.LocalAdapter
