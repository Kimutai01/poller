defmodule Poller.PollServer do
  use GenServer
  alias Poller.Poll
  def start_link(category_id) do
    name = category_name(category_id)
    GenServer.start_link(__MODULE__, category_id, name: name)

  end

  def category_name(category_id), do: :"category:#{category_id}"

  def add_question(category_id, question) do
    name = category_name(category_id)
    GenServer.call(name,{:add_question, question})
  end

  def vote(category_id, choice_id) do
    name = category_name(category_id)
    GenServer.call(name,{:add_vote, choice_id})
  end

  def get_poll(category_id) do
    name = category_name(category_id)
    GenServer.call(name, :get)
  end

  #callbacks
  def init(category_id) do
    poll = Poll.new(category_id)
    {:ok, poll}
  end

  def handle_call({:add_question, question}, _from, poll) do
    poll = Poll.add_question(poll, question)
    {:reply, poll, poll}
  end

  def handle_call({:add_vote, choice_id}, _from, poll) do
    poll = Poll.vote(poll,choice_id)
    {:reply, poll, poll}
  end

  def handle_call(:get, _from, poll) do
    {:reply, poll, poll}
  end
end
