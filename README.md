# ProcIndex
Simple ORM for your process lists. Currently only supported on OS X or Unix based systems (and even that could be limited).

### Basic Usage
Printing all processes:

	$> data = ProcIndex.ps
	...
	$> data.body
	=> [<Hashie::Mash command="/System/Library/CoreServices/Dock.app/Contents/MacOS/Dock" cpu="36.0" mem="0.4" pid="354" rss="35780" started="Sat01PM" stat="U" time="8:08.24" tt="??" user="alexmanelis" vsz="2789684">...]
	
Searching by command:

	$> results = ProcIndex.search('electron')
	...
	=> [#<Hashie::Mash command="/Users/alexmanelis/Development/tmp/node_modules/nightmare/node_modules/electron-prebuilt/dist/Electron.app/Contents/MacOS/Electron" cpu="0.1" mem="0.6" pid="44558" rss="49672" started="1:04PM" stat="S" time="0:00.42" tt="??" user="alexmanelis" vsz="3402532">
	
Kill all running processes from search results:

	$> ...
	$> ProcIndex.kill_by_results(results)
	=> [1, 1, 1]
	
More coming soon...
	