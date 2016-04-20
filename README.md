# CCCEDICT

Fetch and parse [CC-CEDICT](https://www.mdbg.net/chindict/chindict.php?page=cedict) in Elixir

> CC-CEDICT is a continuation of the CEDICT project started by Paul Denisowski in 1997 with the aim to provide a complete downloadable Chinese to English dictionary with pronunciation in pinyin for the Chinese characters.

## Usage

Use the entries stream in your code:

```elixir
Enum.each CCCEDICT.entries_stream, fn entry ->
  entry.trad    # traditional chars # String
  entry.simp    # simplified chars  # String
  entry.read    # pinyin reading    # String
  entry.glosses # glosses           # List[String]
end
```

Or create a seeder function, and call it with Mix:

```elixir
defmodule MyApp.CCCEDICT do
 def seed_entries(entries) do
  Enum.each entries, fn entry ->
    # seed the DB
  end
end
```

```
$ mix cc_cedict:entries MyApp.CCCEDICT.seed_entries
```
