# ExDownloader

Large files download using HTTPoison async/stream features, genserver and progressbar :star:

Usage
---
![usage](assets/usage.gif)

How this works
---
- Using :stream_to option from httpoision we can do a async download by chunks
- All the calls to the next chunks are handled by our genserver (statefull process)
- To each chunk received we can update our progressbar (directly to stdout)

Ref
---
- https://www.poeticoding.com/download-large-files-with-httpoison-async-requests/
- https://hexdocs.pm/httpoison/readme.html