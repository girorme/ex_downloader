defmodule ExDownloader do
  alias ExDownloader.HttpHandler

  def download(url) do
    HttpHandler.download(url)
  end

  def start_progress(total) do
    ProgressBar.render(0, total, format_pbar())
  end

  def update_progress(current, total) do
    ProgressBar.render(current, total, format_pbar())
  end

  defp format_pbar() do
    [
      bar_color: [IO.ANSI.magenta()],
      blank_color: [IO.ANSI.magenta()],
      bar: "█",
      blank: "░",
      suffix: :bytes
    ]
  end
end
