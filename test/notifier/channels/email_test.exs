defmodule Shield.Notifier.Channel.EmailTest do
  use ExUnit.Case
  use Bamboo.Test

  test "confirmation email" do
    to = "to@example.com"
    data = %{identity: to,
      confirmation_url: "https://example.com/confirm-email?token=12345"}
    email =
      [to]
      |> Shield.Notifier.Channel.Email.deliver(:confirmation, data)
      |> List.first

    assert email.to == [{to, to}]
    assert email.subject == "Email Confirmation"
    assert email.text_body =~ "Welcome to@example.com!\n\nYou can confirm your \
account through the link below:\n\n[Confirm my account]\
(https://example.com/confirm-email?token=12345)"
  end

  test "recover password email" do
    to = "to@example.com"
    data = %{identity: to,
      recover_password_url: "https://example.com/recover-password?token=12345"}
    email =
      [to]
      |> Shield.Notifier.Channel.Email.deliver(:recover_password, data)
      |> List.first

    assert email.to == [{to, to}]
    assert email.subject == "Password Recovery"
    assert email.text_body =~ "Hello to@example.com!\n\n\
Someone has requested a link to change your password, and you can do this \
through the link below.\n\n[Change my password](https://example.com/\
recover-password?token=12345)\n\nIf you didn't request this, please \
ignore this email.\nYour password won't change until you access the link \
above and create a new one."
  end
end
