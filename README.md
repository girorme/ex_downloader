# ExDownloader

Large files download using HTTPoison async/stream features, genserver and progressbar :star:

Usage
---
![usage](assets/usage.gif)

How this works
---
- Using :stream_to option from httpoision we can do a async downloads by chunks
- All the calls to the next chunks are made by our genserver (statefull process)
- Via chunk calls we can update the progress bar to stdout

Ref
---
- https://www.poeticoding.com/download-large-files-with-httpoison-async-requests/
- 