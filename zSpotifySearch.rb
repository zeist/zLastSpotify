#!/usr/bin/env ruby
require 'open-uri'
require 'cgi'

class ZSpotifySearch
      def initialize()
      end
      
      # Returns inArtist's spotify id if found, else returns 0
      def searchSpotify(inArtist)
            tArtist = CGI.escape(inArtist)
      
             outstring = open('http://ws.spotify.com/search/1/artist?q='+tArtist, 'User-Agent' => 'Ruby-Wget').read

            outdata = outstring.split("<opensearch:totalResults>")

            outdata.delete_at(0);

            if outdata[0].split("</opensearch:totalResults>")[0].to_i > 0
                  outinfo = outstring.split("<artist href=");
                  return outinfo[1].split(">")[0];
            else
                  return 0
            end
      end
end
