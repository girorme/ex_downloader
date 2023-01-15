defmodule ExDownloader.Application do
  @moduledoc false

  use Application

  alias ExDownloader.HttpHandler

  @impl true
  def start(_type, _args) do
    children = [
      HttpHandler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExDownloader.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
