require 'lib/last_fm'
require 'ap'

last_fm = LastFm.new('dfcca69a7d9650f940cb7983835caa4b', 'http://127.0.0.1:8118')
ap last_fm.album_info(:artist => 'The Charlatans', :album => 'Who We Touch')


#gem 'activesupport', '= 1.5.0'

#require 'lib/i_tunes'
#ITunes.new.recent_releases

