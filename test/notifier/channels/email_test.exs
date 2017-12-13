defmodule Shield.Notifier.Channel.EmailTest do
  use ExUnit.Case
  use Bamboo.Test

  @confirmation_body [__DIR__, "files/confirmation_body.txt"] |> Path.join |> File.read!
  @confirmation_subject Application.get_env(:shield_notifier, :templates)[:confirmation][:subject]
  @recover_password_body [__DIR__, "files/recover_password_body.txt"] |> Path.join |> File.read!
  @recover_password_subject Application.get_env(:shield_notifier, :templates)[:recover_password][:subject]

  test "confirmation email" do
    to = "to@example.com"
    data = %{identity: to,
      confirmation_url: "https://example.com/confirm-email?token=12345"}
    email =
      [to]
      |> Shield.Notifier.Channel.Email.deliver(:confirmation, data)
      |> List.first

    assert email.to == [{to, to}]
    assert email.subject == @confirmation_subject
    assert email.text_body =~ @confirmation_body
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
    assert email.subject == @recover_password_subject
    assert email.text_body =~ @recover_password_body
  end
end
