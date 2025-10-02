require "./miniaudio/lib_miniaudio"

module Miniaudio
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}
end
