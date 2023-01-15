defmodule ExDownloader do
  alias ExDownloader.HttpHandler

  def download(url) do
    HttpHandler.download(url)
  end
end
