require 'lib/last_fm'
last_fm = LastFm.new('dfcca69a7d9650f940cb7983835caa4b', 'http://127.0.0.1:8118')
puts last_fm.top_artists(:user => 'miros').inspect