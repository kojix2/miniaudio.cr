require "./miniaudio/lib_miniaudio"

module Miniaudio
  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  def self.version
    LibMiniaudio.ma_version(out major, out minor, out revision)
    {major, minor, revision}
  end

  def self.version_string
    String.new(LibMiniaudio.ma_version_string)
  end
end
