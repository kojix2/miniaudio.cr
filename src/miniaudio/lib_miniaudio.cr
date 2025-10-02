module Miniaudio
  @[Link("miniaudio")]
  lib LibMiniaudio
    # Basic type aliases
    alias MaResult = Int32
    alias MaHandle = Pointer(Void)

    fun ma_engine_init(config : MaHandle, engine : MaHandle) : MaResult
    fun ma_engine_uninit(engine : MaHandle) : Void
    fun ma_engine_play_sound(engine : MaHandle, filename : LibC::Char*, pSoundGroup : MaHandle) : MaResult
    fun ma_engine_get_time_in_pcm_frames(engine : MaHandle) : UInt64
  end
end
