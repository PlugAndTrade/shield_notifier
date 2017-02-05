# Shield.Notifier

Shield Notifier is an external package for Shield package notifications. Currently, it only supports email with text based confirmation and password recovery email templates using Bamboo.

## Installation

The package can be installed as:

  1. Add `shield_notifier` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:shield_notifier, "~> 0.2"}]
    end
    ```

  2. Ensure `shield_notifier` is started before your application:

    ```elixir
    def application do
      [applications: [:shield_notifier]]
    end
    ```

  3. Add the following lines to your config:

    ```elixir
    config :shield_notifier,
      channels: %{
        email: %{
          from: %{
            name: {:system, "APP_NAME", "Shield Notifier"},
            email: {:system, "APP_FROM_EMAIL", "no-reply@localhost"}
          }
        }
      }
    ```
  4. Add your favorite Bamboo adapter config for prod env as below

    ```elixir
    config :shield_notifier, Shield.Notifier.Mailer,
      adapter: Bamboo.SendgridAdapter,
      api_key: SYSTEM.get_env("SENDGRID_API_KEY")
    ```

## Usage

### Email Channel

To send confirmation email:

```elixir
Shield.Notifier.Channel.Email.deliver(
  ["recipient@example.com"],
  :confirmation,
  %{identity: "Recipient", confirmation_url: "https://xyz.com/con?t=1234"}
)
```

To send password recovery email:

```elixir
Shield.Notifier.Channel.Email.deliver(
  ["recipient@example.com"],
  :recover_password,
  %{identity: "Recipient", recover_password_url: "https://xyz.com/rec?t=1op2"}
)
```

### Channel Implementation

If you need to create your own channels, you can create channels by using `Shield.Notifier.Channel` behaviour. All you need to implement a `deliver` function.

```elixir
deliver(recipients :: list, template :: atom, data :: any) :: any
```

## Contributing

### Issues, Bugs, Documentation, Enhancements

  1. Fork the project

  2. Make your improvements and write your tests.

  3. Document what you did/change.

  4. Make a pull request.


## Todo

  - [ ] HTML email templates.
