module Miniaudio
  @[Link("miniaudio", ldflags: "-L#{__DIR__}/../../ext/miniaudio")]
  lib LibMiniaudio
    alias MaResult = Int32
    alias MaUint32 = UInt32
    alias MaUint64 = UInt64
    alias MaBool32 = UInt32
    alias MaHandle = Pointer(Void)
    alias SizeT = LibC::SizeT

    type MaEngine = Void
    type MaSound = Void
    type MaSoundGroup = Void
    type MaResourceManager = Void
    type MaContext = Void
    type MaDevice = Void
    type MaDeviceNotification = Void
    type MaDeviceID = Void
    type MaNodeGraph = Void
    type MaNode = Void
    type MaLog = Void
    type MaVFS = Void

    struct MaVec3f
      x : Float32
      y : Float32
      z : Float32
    end

    enum MaMonoExpansionMode : Int32
      Duplicate  = 0
      Average    = 1
      StereoOnly = 2
      Default    = 0
    end

    alias MaDeviceDataProc = Proc(Pointer(MaDevice), MaHandle, MaHandle, MaUint32, Nil)
    alias MaDeviceNotificationProc = Proc(Pointer(MaDeviceNotification), Nil)
    alias MaEngineProcessProc = Proc(MaHandle, Pointer(Float32), MaUint64, Nil)

    alias MaAllocationOnMalloc = Proc(SizeT, MaHandle, MaHandle)
    alias MaAllocationOnRealloc = Proc(MaHandle, SizeT, MaHandle, MaHandle)
    alias MaAllocationOnFree = Proc(MaHandle, MaHandle, Nil)

    struct MaAllocationCallbacks
      pUserData : MaHandle
      onMalloc : MaAllocationOnMalloc
      onRealloc : MaAllocationOnRealloc
      onFree : MaAllocationOnFree
    end

    struct MaEngineConfig
      pResourceManager : Pointer(MaResourceManager)
      pContext : Pointer(MaContext)
      pDevice : Pointer(MaDevice)
      pPlaybackDeviceID : Pointer(MaDeviceID)
      dataCallback : MaDeviceDataProc
      notificationCallback : MaDeviceNotificationProc
      pLog : Pointer(MaLog)
      listenerCount : MaUint32
      channels : MaUint32
      sampleRate : MaUint32
      periodSizeInFrames : MaUint32
      periodSizeInMilliseconds : MaUint32
      gainSmoothTimeInFrames : MaUint32
      gainSmoothTimeInMilliseconds : MaUint32
      defaultVolumeSmoothTimeInPCMFrames : MaUint32
      allocationCallbacks : MaAllocationCallbacks
      noAutoStart : MaBool32
      noDevice : MaBool32
      monoExpansionMode : MaMonoExpansionMode
      pResourceManagerVFS : Pointer(MaVFS)
      onProcess : MaEngineProcessProc
      pProcessUserData : MaHandle
    end

    fun ma_engine_config_init : MaEngineConfig

    fun ma_engine_init(config : Pointer(MaEngineConfig), engine : Pointer(MaEngine)) : MaResult
    fun ma_engine_uninit(engine : Pointer(MaEngine)) : Void
    fun ma_engine_read_pcm_frames(engine : Pointer(MaEngine), frames_out : MaHandle, frame_count : MaUint64, frames_read : Pointer(MaUint64)) : MaResult
    fun ma_engine_get_node_graph(engine : Pointer(MaEngine)) : Pointer(MaNodeGraph)
    fun ma_engine_get_device(engine : Pointer(MaEngine)) : Pointer(MaDevice)
    fun ma_engine_get_log(engine : Pointer(MaEngine)) : Pointer(MaLog)
    fun ma_engine_get_time_in_pcm_frames(engine : Pointer(MaEngine)) : MaUint64
    fun ma_engine_get_time_in_milliseconds(engine : Pointer(MaEngine)) : MaUint64
    fun ma_engine_set_time_in_pcm_frames(engine : Pointer(MaEngine), global_time : MaUint64) : MaResult
    fun ma_engine_set_time_in_milliseconds(engine : Pointer(MaEngine), global_time : MaUint64) : MaResult
    fun ma_engine_get_channels(engine : Pointer(MaEngine)) : MaUint32
    fun ma_engine_get_sample_rate(engine : Pointer(MaEngine)) : MaUint32
    fun ma_engine_start(engine : Pointer(MaEngine)) : MaResult
    fun ma_engine_stop(engine : Pointer(MaEngine)) : MaResult
    fun ma_engine_set_volume(engine : Pointer(MaEngine), volume : Float32) : MaResult
    fun ma_engine_get_volume(engine : Pointer(MaEngine)) : Float32
    fun ma_engine_set_gain_db(engine : Pointer(MaEngine), gain_db : Float32) : MaResult
    fun ma_engine_get_gain_db(engine : Pointer(MaEngine)) : Float32
    fun ma_engine_get_listener_count(engine : Pointer(MaEngine)) : MaUint32
    fun ma_engine_find_closest_listener(engine : Pointer(MaEngine), x : Float32, y : Float32, z : Float32) : MaUint32
    fun ma_engine_listener_set_position(engine : Pointer(MaEngine), listener_index : MaUint32, x : Float32, y : Float32, z : Float32) : Void
    fun ma_engine_listener_get_position(engine : Pointer(MaEngine), listener_index : MaUint32) : MaVec3f
    fun ma_engine_listener_set_direction(engine : Pointer(MaEngine), listener_index : MaUint32, x : Float32, y : Float32, z : Float32) : Void
    fun ma_engine_listener_get_direction(engine : Pointer(MaEngine), listener_index : MaUint32) : MaVec3f
    fun ma_engine_listener_set_velocity(engine : Pointer(MaEngine), listener_index : MaUint32, x : Float32, y : Float32, z : Float32) : Void
    fun ma_engine_listener_get_velocity(engine : Pointer(MaEngine), listener_index : MaUint32) : MaVec3f
    fun ma_engine_listener_set_cone(engine : Pointer(MaEngine), listener_index : MaUint32, inner_angle : Float32, outer_angle : Float32, outer_gain : Float32) : Void
    fun ma_engine_listener_get_cone(engine : Pointer(MaEngine), listener_index : MaUint32, inner_angle : Pointer(Float32), outer_angle : Pointer(Float32), outer_gain : Pointer(Float32)) : Void
    fun ma_engine_listener_set_world_up(engine : Pointer(MaEngine), listener_index : MaUint32, x : Float32, y : Float32, z : Float32) : Void
    fun ma_engine_listener_get_world_up(engine : Pointer(MaEngine), listener_index : MaUint32) : MaVec3f
    fun ma_engine_listener_set_enabled(engine : Pointer(MaEngine), listener_index : MaUint32, enabled : MaBool32) : Void
    fun ma_engine_listener_is_enabled(engine : Pointer(MaEngine), listener_index : MaUint32) : MaBool32

    fun ma_engine_play_sound(engine : Pointer(MaEngine), file_path : LibC::Char*, group : Pointer(MaSoundGroup)) : MaResult

    fun ma_version(major : Pointer(MaUint32), minor : Pointer(MaUint32), revision : Pointer(MaUint32)) : Void
    fun ma_version_string : LibC::Char*
  end
end
