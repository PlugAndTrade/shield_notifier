use Mix.Config

config :shield_notifier, Shield.Notifier.Mailer,
  adapter: Bamboo.TestAdapter

config :shield_notifier,
  templates: %{
    confirmation: %{
      subject: "Test confirmation mail",
      body: Path.join(__DIR__, "../test/notifier/channels/files/confirmation_template.txt")
    },
    recover_password: %{
      subject: "Test recover password mail",
      body: Path.join(__DIR__, "../test/notifier/channels/files/recover_password_template.txt")
    }
  }
