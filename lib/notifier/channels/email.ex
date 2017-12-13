defmodule Shield.Notifier.Channel.Email do
  @moduledoc """
  Email module that implements Shield.Notifier.Channel behaviour.
  """
  import Bamboo.Email

  @behaviour Shield.Notifier.Channel

  @default_templates %{
    confirmation: %{
      subject: "Email Confirmation",
      body: Path.join(Application.app_dir(:shield_notifier), "priv/templates/confirmation_template.txt")
    },
    recover_password: %{
      subject: "Password Recovery",
      body: Path.join(Application.app_dir(:shield_notifier), "priv/templates/recover_password_template.txt")
    }
  }
  @email_templates Map.merge(@default_templates, Application.get_env(:shield_notifier, :templates, %{}))
    |> Enum.map(fn {type, template} -> {type, Map.update!(template, :body, &File.read!/1)} end)
    |> Map.new

  @doc """
  Delivers email asyncronusly to receipents using template and template data.

  ### Examples
      Shield.Notifier.Channel.Email.deliver(
        ["recipient@example.com"],
        :confirmation,
        %{identity: "Recipient", confirmation_url: "https://xyz.com/con?t=1234"}
      )

      Shield.Notifier.Channel.Email.deliver(
        ["recipient@example.com"],
        :recover_password,
        %{identity: "Recipient", recover_password_url: "https://x.co/rt?t=1opx"}
      )
  """
  def deliver(recipients, template, data) do
    Enum.map(recipients,
      fn recipient -> send_later(recipient, template, data) end)
  end

  defp send_later(recipient, template, data) do
    email = generate(recipient, template, data)
    Shield.Notifier.Mailer.deliver_later(email)
  end

  defp generate(recipient, type, data) do
    base_email()
    |> to({recipient, recipient})
    |> subject(@email_templates[type][:subject])
    |> text_body(replace(@email_templates[type][:body], data))
  end

  defp replace(template, data) do
    {_data, template} = Enum.map_reduce(data, template, fn({k, v}, template) ->
      {{k, v}, String.replace(template, "{{#{k}}}", v)} end)
    template
  end

  defp base_email() do
    from(new_email(), Shield.Notifier.Config.email())
  end
end
