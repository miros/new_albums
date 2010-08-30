require 'lib/last_fm'
require 'pp'
last_fm = LastFm.new('dfcca69a7d9650f940cb7983835caa4b', 'http://127.0.0.1:8118')
pp last_fm.artists(:user => 'miros', :limit => 200)