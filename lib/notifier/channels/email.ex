defmodule Shield.Notifier.Channel.Email do
  @moduledoc """
  Email module that implements Shield.Notifier.Channel behaviour.
  """
  import Bamboo.Email

  @behaviour Shield.Notifier.Channel

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

  defp generate(recipient, :confirmation, data) do
    base_email()
    |> to({recipient, recipient})
    |> subject("Email Confirmation")
    |> text_body(replace(confirmation_template(), data))
  end
  defp generate(recipient, :recover_password, data) do
    base_email()
    |> to({recipient, recipient})
    |> subject("Password Recovery")
    |> text_body(replace(recover_password_template(), data))
  end

  defp confirmation_template() do
    "Welcome {{identity}}!

You can confirm your account through the link below:

[Confirm my account]({{confirmation_url}})"
  end

  defp recover_password_template() do
    "Hello {{identity}}!

Someone has requested a link to change your password, and you can do this through the link below.

[Change my password]({{recover_password_url}})

If you didn't request this, please ignore this email.
Your password won't change until you access the link above and create a new one."
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
