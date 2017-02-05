# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :shield_notifier,
  channels: %{
    email: %{
      from: %{
        name: {:system, "APP_NAME", "Shield Notifier"},
        email: {:system, "APP_FROM_EMAIL", "no-reply@localhost"}
      }
    }
  }

import_config "#{Mix.env}.exs"
