defmodule CCCEDICT do
  defmodule Entry do
    defstruct num: nil,
      trad:    "",
      simp:    "",
      read:    "",
      glosses: []
  end

  defp entry_line_re,
    do: ~r{([^\s]+)\s+([^\s]+)\s+\[(.+)\]\s+/(.+)/}
    #      trad       simp         read      glosses
  def line_to_entry(line_str) do
    [_, t, s, r, g] = Regex.run entry_line_re, line_str
    glosses = String.split g, "/"
    %Entry{trad: t, simp: s, read: r, glosses: glosses}
  end

  def entries_stream do
    file_stream
    |> Stream.reject(& String.starts_with? &1, "#")
    |> Stream.map(&CCCEDICT.line_to_entry/1)
  end

  defp file_stream do
    filepath = "/tmp/cedict_ts.u8"
    # filepath = "cedict_ts.u8"

    unless File.exists? filepath do
      get_cc_cedict_file!
    end

    File.stream! filepath
  end

  defp url do
    "http://www.mdbg.net/chindict/export/cedict/cedict_1_0_ts_utf-8_mdbg.zip"
  end

  defp get_cc_cedict_file! do
    filename = Path.basename url
    filepath = "/tmp/#{filename}"

    unless String.ends_with? filename, ".zip" do
      raise "#{filename} is not a .zip file"
    end

    unless File.exists?(filepath) do
      IO.puts "fetching CC-CEDICT... this could take a while"
      File.write! filepath, get_body(url)
    end

    System.cmd "unzip", [filepath, "-d", "/tmp"]
  end

  defp get_body(url) do
    HTTPoison.start
    %{body: body} = HTTPoison.get! url
    body
  end
end
