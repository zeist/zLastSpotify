#!/usr/bin/env ruby
require 'zSpotifySearch'

# Gets the recommended artists for inUsername from last.fm
def getRecommendations(inUsername)
      outstring = open('http://ws.audioscrobbler.com/1.0/user/'+inUsername+'/systemrecs.rss', 'User-Agent' => 'Ruby-Wget').read

      outarray = outstring.split("<title>")

      outartists = Array.new

      outarray.each { |title| outartists.push(title.split("</title>")[0])}

      outartists.delete_at(0)
      outartists.delete_at(0)
      return outartists
end

# Gets the spotify links (if present) for the inArtists
def getSpotifyLinks(inArtists)
      spotifySearch = ZSpotifySearch.new

      outresults = Array.new
      inArtists.each { |artist| 
                        tempresult = spotifySearch.searchSpotify(artist)
                        if tempresult.to_s.length() > 1
                              outresults.push(tempresult);
                        end
                      }
      return outresults;
end

def buildPage(inLinks)
      outFile = File.new("outfile.html","w+")
      outFile.puts "<html>"
      outFile.puts "<head>"
      outFile.puts "<title>Last.fm recommendations -> Spotify Links</title>"
      outFile.puts "</head>"
      outFile.puts "<body>"
      inLinks.each { |result|
                        result = result.split(':')[2].delete("\"");
                        result = "<a href=\"http://open.spotify.com/artist/"+result+"\">"+result+"</a><br>"
                        outFile.puts result                  
                      }
      outFile.puts "</body>"
      outFile.puts "</html>"
end

outartists = getRecommendations("<username>")
outresults = getSpotifyLinks(outartists)
buildPage(outresults)

