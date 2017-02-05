defmodule Shield.Notifier.Config do
  @moduledoc """
  Shield.Notifier configuration reader
  """

  @doc """
  Reads email configuration
  """
  def email do
    {from_name(), from_email()}
  end

  defp from_name do
    email_conf()
    |> Map.get(:name)
    |> get_env_var()
  end

  defp from_email do
    email_conf()
    |> Map.get(:email)
    |> get_env_var()
  end

  def email_conf do
    :shield_notifier
    |> Application.get_env(:channels)
    |> Map.get(:email, %{})
    |> Map.get(:from, %{})
  end

  defp get_env_var({:system, name, default}) do
    System.get_env(name) || default
  end
  defp get_env_var(item), do: item
end
