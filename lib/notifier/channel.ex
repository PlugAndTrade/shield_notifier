defmodule Shield.Notifier.Channel do
  @moduledoc """
  Behaviour module for Shield.Notifier channel implementation modules.
  """
  use Behaviour

  @callback deliver(recipients :: list, template :: atom, data :: any) :: any
end
