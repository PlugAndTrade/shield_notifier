# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :shield_notifier,
  channels: %{
    email: %{
      from: {
        System.get_env("APP_NAME") || "Shield Notifier",
        System.get_env("APP_FROM_EMAIL") || "no-reply@localhost"}
    }
  }

import_config "#{Mix.env}.exs"
