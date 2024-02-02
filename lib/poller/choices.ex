defmodule Poller.Choice do
  alias __MODULE__
  defstruct(
    id: nil,
    description: nil,
    nickname: nil
  )

  def new(id, description, nickname) do
    %Choice{
      id: id,
      description: description,
      nickname: nickname
    }
  end
end
