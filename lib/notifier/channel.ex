defmodule Shield.Notifier.Channel do
  @moduledoc """
  Behaviour module for Shield.Notifier channel implementation modules.
  """

  @callback deliver(recipients :: list, template :: atom, data :: any) :: any
end
