defmodule ExDownloader.HttpHandler do
  use GenServer
  alias ExDownloader.Progress

  def start_link(_args) do
    GenServer.start_link(__MODULE__, initial_state(), name: __MODULE__)
  end

  def initial_state(), do: %{poison_client: nil, file_size: 0, downloaded: 0}

  @impl true
  def init(args) do
    {:ok, args}
  end

  def download(url) do
    GenServer.cast(__MODULE__, {:download, url})
  end

  @impl true
  def handle_cast({:download, url}, state) do
    client = HTTPoison.get! url, %{}, stream_to: self(), async: :once
    {:noreply, Map.put(state, :poison_client, client)}
  end

  @impl true
  def handle_info(%HTTPoison.AsyncHeaders{headers: headers}, %{poison_client: client} = state) do
    f_size =
      List.keyfind(headers, "content-length", 0)
      |> elem(1)
      |> String.to_integer()

    Progress.start_progress(f_size)
    HTTPoison.stream_next(client)

    {:noreply, Map.put(state, :file_size, f_size)}
  end

  @impl true
  def handle_info(%HTTPoison.AsyncChunk{chunk: c}, %{poison_client: client, file_size: f_size, downloaded: dowloaded} = state) do
    total_dowloaded = byte_size(c) + dowloaded
    Progress.update_progress(total_dowloaded, f_size)
    HTTPoison.stream_next(client)
    {:noreply, Map.put(state, :downloaded, total_dowloaded)}
  end

  @impl true
  def handle_info(%HTTPoison.AsyncStatus{code: status_code}, %{poison_client: client} = state) do
    case status_code do
      200 -> IO.puts("[200] File found... please wait!")
      _ -> System.halt("File not found, exiting...")
    end

    HTTPoison.stream_next(client)

    {:noreply, state}
  end

  @impl true
  def handle_info(%HTTPoison.AsyncEnd{} = _message, _state) do
    IO.puts ("[+] Download Finished")
    System.halt(0)
    {:noreply, initial_state()}
  end
end
