defmodule CCCEDICT.EntryStreamConsumer do
  def take_one(entries_stream) do
    [entry] = Enum.take entries_stream, 1
    entry
  end
end

defmodule CCCEDICT.EntriesMixTaskTest do
  use ExUnit.Case, async: true

  test "module receives entries stream" do
    consumer = "CCCEDICT.EntryStreamConsumer.take_one"
    entry = Mix.Tasks.CCCEDICT.Entries.run([consumer])
    assert entry.trad == "%"
  end
end
