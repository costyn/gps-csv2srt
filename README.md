Simple script that converts GPS data in a CSV file to SRT subtitles for embedding flight data in video.

Use Virtual Dub or Vobsub to embed subtitles in video. Set offset to the time in the video where the GPS first has lock (and gets time updates from GPS).

TODO/future features:
* Offset as parameter
* Use less Perl modules
* Detect launch in data to make syncing video and subtitles easier. 
* Figure out YouTube subtitle format so they work there too.
