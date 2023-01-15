defmodule ExDownloader do
  alias ExDownloader.HttpHandler

  def main(args) do
    {parsed, _argv, _} =
      args
      |> OptionParser.parse(strict: [url: :string])

    unless Keyword.has_key?(parsed, :url) do
      System.halt("usage: ex_download --url \"https://link-to-file\"")
    end

    download(parsed[:url])
    :timer.sleep(:infinity)
  end

  def download(url) do
    HttpHandler.download(url)
  end
end
