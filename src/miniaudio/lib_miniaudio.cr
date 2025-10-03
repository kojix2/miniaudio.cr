module Miniaudio
  {% if flag?(:msvc) %}
    @[Link("miniaudio", ldflags: "/LIBPATH:#{__DIR__}\\..\\..\\ext\\miniaudio")]
  {% else %}
    @[Link("miniaudio", ldflags: "-L#{__DIR__}/../../ext/miniaudio")]
  {% end %}
  lib LibMiniaudio
    struct Context
      callbacks : Void
      backend : Void
      p_log : Pointer(Void)
      log : Void
      thread_priority : Void
      thread_stack_size : Void
      p_user_data : Pointer(Void)
      allocation_callbacks : Void
      device_enum_lock : Void
      device_info_lock : Void
      device_info_capacity : Void
      playback_device_info_count : Void
      capture_device_info_count : Void
      p_device_infos : Pointer(Void)
    end

    struct Device
      p_context : Pointer(Void)
      type : Void
      sample_rate : Void
      state : Void
      on_data : Void
      on_notification : Void
      on_stop : Void
      p_user_data : Pointer(Void)
      start_stop_lock : Void
      wakeup_event : Void
      start_event : Void
      stop_event : Void
      thread : Void
      work_result : Void
      is_owner_of_context : Void
      no_pre_silenced_output_buffer : Void
      no_clip : Void
      no_disable_denormals : Void
      no_fixed_sized_callback : Void
      master_volume_factor : Void
      duplex_rb : Void
      resampling : DeviceResampling
      playback : DevicePlayback
      capture : DeviceCapture
    end

    struct DeviceResampling
      algorithm : Void
      p_backend_v_table : Pointer(Void)
      p_backend_user_data : Pointer(Void)
      linear : DeviceResamplingLinear
    end

    struct DeviceResamplingLinear
      lpf_order : Void
    end

    struct DevicePlayback
      p_id : Pointer(Void)
      id : Void
      name : StaticArray(LibC::Char, 256)
      share_mode : Void
      format : Void
      channels : Void
      channel_map : StaticArray(Void, 254)
      internal_format : Void
      internal_channels : Void
      internal_sample_rate : Void
      internal_channel_map : StaticArray(Void, 254)
      internal_period_size_in_frames : Void
      internal_periods : Void
      channel_mix_mode : Void
      calculate_lfe_from_spatial_channels : Void
      converter : Void
      p_intermediary_buffer : Pointer(Void)
      intermediary_buffer_cap : Void
      intermediary_buffer_len : Void
      p_input_cache : Pointer(Void)
      input_cache_cap : Void
      input_cache_consumed : Void
      input_cache_remaining : Void
    end

    struct DeviceCapture
      p_id : Pointer(Void)
      id : Void
      name : StaticArray(LibC::Char, 256)
      share_mode : Void
      format : Void
      channels : Void
      channel_map : StaticArray(Void, 254)
      internal_format : Void
      internal_channels : Void
      internal_sample_rate : Void
      internal_channel_map : StaticArray(Void, 254)
      internal_period_size_in_frames : Void
      internal_periods : Void
      channel_mix_mode : Void
      calculate_lfe_from_spatial_channels : Void
      converter : Void
      p_intermediary_buffer : Pointer(Void)
      intermediary_buffer_cap : Void
      intermediary_buffer_len : Void
    end

    struct AllocationCallbacks
      p_user_data : Pointer(Void)
      on_malloc : (Void, Pointer(Void) -> Pointer(Void))
      on_realloc : (Pointer(Void), Void, Pointer(Void) -> Pointer(Void))
      on_free : (Pointer(Void), Pointer(Void) -> Void)
    end

    struct Lcg
      state : Void
    end

    struct AtomicUint32
      value : Void
    end

    struct AtomicInt32
      value : Void
    end

    struct AtomicUint64
      value : Void
    end

    struct AtomicFloat
      value : Void
    end

    struct AtomicBool32
      value : Void
    end

    struct Event
      value : Void
      lock : Void
      cond : Void
    end

    struct Semaphore
      value : LibC::Int
      lock : Void
      cond : Void
    end

    fun version = ma_version(p_major : Pointer(Void), p_minor : Pointer(Void), p_revision : Pointer(Void))
    fun version_string = ma_version_string : Pointer(LibC::Char)

    struct LogCallback
      on_log : Void
      p_user_data : Pointer(Void)
    end

    fun log_callback_init = ma_log_callback_init(on_log : Void, p_user_data : Pointer(Void))

    struct Log
      callbacks : StaticArray(Void, 4)
      callback_count : Void
      allocation_callbacks : Void
      lock : Void
    end

    fun log_init = ma_log_init(p_allocation_callbacks : Pointer(Void), p_log : Pointer(Void))
    fun log_uninit = ma_log_uninit(p_log : Pointer(Void))
    fun log_register_callback = ma_log_register_callback(p_log : Pointer(Void), callback : Void)
    fun log_unregister_callback = ma_log_unregister_callback(p_log : Pointer(Void), callback : Void)
    fun log_post = ma_log_post(p_log : Pointer(Void), level : Void, p_message : Pointer(LibC::Char))
    fun log_postv = ma_log_postv(p_log : Pointer(Void), level : Void, p_format : Pointer(LibC::Char), args : Void)
    fun log_postf = ma_log_postf(p_log : Pointer(Void), level : Void, p_format : Pointer(LibC::Char), ...)

    union BiquadCoefficient
      f32 : LibC::Float
      s32 : Void
    end

    struct BiquadConfig
      format : Void
      channels : Void
      b0 : LibC::Double
      b1 : LibC::Double
      b2 : LibC::Double
      a0 : LibC::Double
      a1 : LibC::Double
      a2 : LibC::Double
    end

    fun biquad_config_init = ma_biquad_config_init(format : Void, channels : Void, b0 : LibC::Double, b1 : LibC::Double, b2 : LibC::Double, a0 : LibC::Double, a1 : LibC::Double, a2 : LibC::Double)

    struct Biquad
      format : Void
      channels : Void
      b0 : Void
      b1 : Void
      b2 : Void
      a1 : Void
      a2 : Void
      p_r1 : Pointer(Void)
      p_r2 : Pointer(Void)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun biquad_get_heap_size = ma_biquad_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun biquad_init_preallocated = ma_biquad_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_bq : Pointer(Void))
    fun biquad_init = ma_biquad_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_bq : Pointer(Void))
    fun biquad_uninit = ma_biquad_uninit(p_bq : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun biquad_reinit = ma_biquad_reinit(p_config : Pointer(Void), p_bq : Pointer(Void))
    fun biquad_clear_cache = ma_biquad_clear_cache(p_bq : Pointer(Void))
    fun biquad_process_pcm_frames = ma_biquad_process_pcm_frames(p_bq : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun biquad_get_latency = ma_biquad_get_latency(p_bq : Pointer(Void))

    struct Lpf1Config
      format : Void
      channels : Void
      sample_rate : Void
      cutoff_frequency : LibC::Double
      q : LibC::Double
    end

    fun lpf1_config_init = ma_lpf1_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double)
    fun lpf2_config_init = ma_lpf2_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, q : LibC::Double)

    struct Lpf1
      format : Void
      channels : Void
      a : Void
      p_r1 : Pointer(Void)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun lpf1_get_heap_size = ma_lpf1_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun lpf1_init_preallocated = ma_lpf1_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf1_init = ma_lpf1_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf1_uninit = ma_lpf1_uninit(p_lpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun lpf1_reinit = ma_lpf1_reinit(p_config : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf1_clear_cache = ma_lpf1_clear_cache(p_lpf : Pointer(Void))
    fun lpf1_process_pcm_frames = ma_lpf1_process_pcm_frames(p_lpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun lpf1_get_latency = ma_lpf1_get_latency(p_lpf : Pointer(Void))

    struct Lpf2
      bq : Void
    end

    fun lpf2_get_heap_size = ma_lpf2_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun lpf2_init_preallocated = ma_lpf2_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_hpf : Pointer(Void))
    fun lpf2_init = ma_lpf2_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf2_uninit = ma_lpf2_uninit(p_lpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun lpf2_reinit = ma_lpf2_reinit(p_config : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf2_clear_cache = ma_lpf2_clear_cache(p_lpf : Pointer(Void))
    fun lpf2_process_pcm_frames = ma_lpf2_process_pcm_frames(p_lpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun lpf2_get_latency = ma_lpf2_get_latency(p_lpf : Pointer(Void))

    struct LpfConfig
      format : Void
      channels : Void
      sample_rate : Void
      cutoff_frequency : LibC::Double
      order : Void
    end

    fun lpf_config_init = ma_lpf_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, order : Void)

    struct Lpf
      format : Void
      channels : Void
      sample_rate : Void
      lpf1_count : Void
      lpf2_count : Void
      p_lpf1 : Pointer(Void)
      p_lpf2 : Pointer(Void)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun lpf_get_heap_size = ma_lpf_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun lpf_init_preallocated = ma_lpf_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf_init = ma_lpf_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf_uninit = ma_lpf_uninit(p_lpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun lpf_reinit = ma_lpf_reinit(p_config : Pointer(Void), p_lpf : Pointer(Void))
    fun lpf_clear_cache = ma_lpf_clear_cache(p_lpf : Pointer(Void))
    fun lpf_process_pcm_frames = ma_lpf_process_pcm_frames(p_lpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun lpf_get_latency = ma_lpf_get_latency(p_lpf : Pointer(Void))

    struct Hpf1Config
      format : Void
      channels : Void
      sample_rate : Void
      cutoff_frequency : LibC::Double
      q : LibC::Double
    end

    fun hpf1_config_init = ma_hpf1_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double)
    fun hpf2_config_init = ma_hpf2_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, q : LibC::Double)

    struct Hpf1
      format : Void
      channels : Void
      a : Void
      p_r1 : Pointer(Void)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun hpf1_get_heap_size = ma_hpf1_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun hpf1_init_preallocated = ma_hpf1_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_lpf : Pointer(Void))
    fun hpf1_init = ma_hpf1_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_hpf : Pointer(Void))
    fun hpf1_uninit = ma_hpf1_uninit(p_hpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun hpf1_reinit = ma_hpf1_reinit(p_config : Pointer(Void), p_hpf : Pointer(Void))
    fun hpf1_process_pcm_frames = ma_hpf1_process_pcm_frames(p_hpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun hpf1_get_latency = ma_hpf1_get_latency(p_hpf : Pointer(Void))

    struct Hpf2
      bq : Void
    end

    fun hpf2_get_heap_size = ma_hpf2_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun hpf2_init_preallocated = ma_hpf2_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_hpf : Pointer(Void))
    fun hpf2_init = ma_hpf2_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_hpf : Pointer(Void))
    fun hpf2_uninit = ma_hpf2_uninit(p_hpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun hpf2_reinit = ma_hpf2_reinit(p_config : Pointer(Void), p_hpf : Pointer(Void))
    fun hpf2_process_pcm_frames = ma_hpf2_process_pcm_frames(p_hpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun hpf2_get_latency = ma_hpf2_get_latency(p_hpf : Pointer(Void))

    struct HpfConfig
      format : Void
      channels : Void
      sample_rate : Void
      cutoff_frequency : LibC::Double
      order : Void
    end

    fun hpf_config_init = ma_hpf_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, order : Void)

    struct Hpf
      format : Void
      channels : Void
      sample_rate : Void
      hpf1_count : Void
      hpf2_count : Void
      p_hpf1 : Pointer(Void)
      p_hpf2 : Pointer(Void)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun hpf_get_heap_size = ma_hpf_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun hpf_init_preallocated = ma_hpf_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_lpf : Pointer(Void))
    fun hpf_init = ma_hpf_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_hpf : Pointer(Void))
    fun hpf_uninit = ma_hpf_uninit(p_hpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun hpf_reinit = ma_hpf_reinit(p_config : Pointer(Void), p_hpf : Pointer(Void))
    fun hpf_process_pcm_frames = ma_hpf_process_pcm_frames(p_hpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun hpf_get_latency = ma_hpf_get_latency(p_hpf : Pointer(Void))

    struct Bpf2Config
      format : Void
      channels : Void
      sample_rate : Void
      cutoff_frequency : LibC::Double
      q : LibC::Double
    end

    fun bpf2_config_init = ma_bpf2_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, q : LibC::Double)

    struct Bpf2
      bq : Void
    end

    fun bpf2_get_heap_size = ma_bpf2_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun bpf2_init_preallocated = ma_bpf2_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_bpf : Pointer(Void))
    fun bpf2_init = ma_bpf2_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_bpf : Pointer(Void))
    fun bpf2_uninit = ma_bpf2_uninit(p_bpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun bpf2_reinit = ma_bpf2_reinit(p_config : Pointer(Void), p_bpf : Pointer(Void))
    fun bpf2_process_pcm_frames = ma_bpf2_process_pcm_frames(p_bpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun bpf2_get_latency = ma_bpf2_get_latency(p_bpf : Pointer(Void))

    struct BpfConfig
      format : Void
      channels : Void
      sample_rate : Void
      cutoff_frequency : LibC::Double
      order : Void
    end

    fun bpf_config_init = ma_bpf_config_init(format : Void, channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, order : Void)

    struct Bpf
      format : Void
      channels : Void
      bpf2_count : Void
      p_bpf2 : Pointer(Void)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun bpf_get_heap_size = ma_bpf_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun bpf_init_preallocated = ma_bpf_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_bpf : Pointer(Void))
    fun bpf_init = ma_bpf_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_bpf : Pointer(Void))
    fun bpf_uninit = ma_bpf_uninit(p_bpf : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun bpf_reinit = ma_bpf_reinit(p_config : Pointer(Void), p_bpf : Pointer(Void))
    fun bpf_process_pcm_frames = ma_bpf_process_pcm_frames(p_bpf : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun bpf_get_latency = ma_bpf_get_latency(p_bpf : Pointer(Void))

    struct Notch2Config
      format : Void
      channels : Void
      sample_rate : Void
      q : LibC::Double
      frequency : LibC::Double
    end

    fun notch2_config_init = ma_notch2_config_init(format : Void, channels : Void, sample_rate : Void, q : LibC::Double, frequency : LibC::Double)

    struct Notch2
      bq : Void
    end

    fun notch2_get_heap_size = ma_notch2_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun notch2_init_preallocated = ma_notch2_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_filter : Pointer(Void))
    fun notch2_init = ma_notch2_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_filter : Pointer(Void))
    fun notch2_uninit = ma_notch2_uninit(p_filter : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun notch2_reinit = ma_notch2_reinit(p_config : Pointer(Void), p_filter : Pointer(Void))
    fun notch2_process_pcm_frames = ma_notch2_process_pcm_frames(p_filter : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun notch2_get_latency = ma_notch2_get_latency(p_filter : Pointer(Void))

    struct Peak2Config
      format : Void
      channels : Void
      sample_rate : Void
      gain_db : LibC::Double
      q : LibC::Double
      frequency : LibC::Double
    end

    fun peak2_config_init = ma_peak2_config_init(format : Void, channels : Void, sample_rate : Void, gain_db : LibC::Double, q : LibC::Double, frequency : LibC::Double)

    struct Peak2
      bq : Void
    end

    fun peak2_get_heap_size = ma_peak2_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun peak2_init_preallocated = ma_peak2_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_filter : Pointer(Void))
    fun peak2_init = ma_peak2_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_filter : Pointer(Void))
    fun peak2_uninit = ma_peak2_uninit(p_filter : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun peak2_reinit = ma_peak2_reinit(p_config : Pointer(Void), p_filter : Pointer(Void))
    fun peak2_process_pcm_frames = ma_peak2_process_pcm_frames(p_filter : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun peak2_get_latency = ma_peak2_get_latency(p_filter : Pointer(Void))

    struct Loshelf2Config
      format : Void
      channels : Void
      sample_rate : Void
      gain_db : LibC::Double
      shelf_slope : LibC::Double
      frequency : LibC::Double
    end

    fun loshelf2_config_init = ma_loshelf2_config_init(format : Void, channels : Void, sample_rate : Void, gain_db : LibC::Double, shelf_slope : LibC::Double, frequency : LibC::Double)

    struct Loshelf2
      bq : Void
    end

    fun loshelf2_get_heap_size = ma_loshelf2_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun loshelf2_init_preallocated = ma_loshelf2_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_filter : Pointer(Void))
    fun loshelf2_init = ma_loshelf2_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_filter : Pointer(Void))
    fun loshelf2_uninit = ma_loshelf2_uninit(p_filter : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun loshelf2_reinit = ma_loshelf2_reinit(p_config : Pointer(Void), p_filter : Pointer(Void))
    fun loshelf2_process_pcm_frames = ma_loshelf2_process_pcm_frames(p_filter : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun loshelf2_get_latency = ma_loshelf2_get_latency(p_filter : Pointer(Void))

    struct Hishelf2Config
      format : Void
      channels : Void
      sample_rate : Void
      gain_db : LibC::Double
      shelf_slope : LibC::Double
      frequency : LibC::Double
    end

    fun hishelf2_config_init = ma_hishelf2_config_init(format : Void, channels : Void, sample_rate : Void, gain_db : LibC::Double, shelf_slope : LibC::Double, frequency : LibC::Double)

    struct Hishelf2
      bq : Void
    end

    fun hishelf2_get_heap_size = ma_hishelf2_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun hishelf2_init_preallocated = ma_hishelf2_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_filter : Pointer(Void))
    fun hishelf2_init = ma_hishelf2_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_filter : Pointer(Void))
    fun hishelf2_uninit = ma_hishelf2_uninit(p_filter : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun hishelf2_reinit = ma_hishelf2_reinit(p_config : Pointer(Void), p_filter : Pointer(Void))
    fun hishelf2_process_pcm_frames = ma_hishelf2_process_pcm_frames(p_filter : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun hishelf2_get_latency = ma_hishelf2_get_latency(p_filter : Pointer(Void))

    struct DelayConfig
      channels : Void
      sample_rate : Void
      delay_in_frames : Void
      delay_start : Void
      wet : LibC::Float
      dry : LibC::Float
      decay : LibC::Float
    end

    fun delay_config_init = ma_delay_config_init(channels : Void, sample_rate : Void, delay_in_frames : Void, decay : LibC::Float)

    struct Delay
      config : Void
      cursor : Void
      buffer_size_in_frames : Void
      p_buffer : Pointer(LibC::Float)
    end

    fun delay_init = ma_delay_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_delay : Pointer(Void))
    fun delay_uninit = ma_delay_uninit(p_delay : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun delay_process_pcm_frames = ma_delay_process_pcm_frames(p_delay : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun delay_set_wet = ma_delay_set_wet(p_delay : Pointer(Void), value : LibC::Float)
    fun delay_get_wet = ma_delay_get_wet(p_delay : Pointer(Void)) : LibC::Float
    fun delay_set_dry = ma_delay_set_dry(p_delay : Pointer(Void), value : LibC::Float)
    fun delay_get_dry = ma_delay_get_dry(p_delay : Pointer(Void)) : LibC::Float
    fun delay_set_decay = ma_delay_set_decay(p_delay : Pointer(Void), value : LibC::Float)
    fun delay_get_decay = ma_delay_get_decay(p_delay : Pointer(Void)) : LibC::Float

    struct GainerConfig
      channels : Void
      smooth_time_in_frames : Void
    end

    fun gainer_config_init = ma_gainer_config_init(channels : Void, smooth_time_in_frames : Void)

    struct Gainer
      config : Void
      t : Void
      master_volume : LibC::Float
      p_old_gains : Pointer(LibC::Float)
      p_new_gains : Pointer(LibC::Float)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun gainer_get_heap_size = ma_gainer_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun gainer_init_preallocated = ma_gainer_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_gainer : Pointer(Void))
    fun gainer_init = ma_gainer_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_gainer : Pointer(Void))
    fun gainer_uninit = ma_gainer_uninit(p_gainer : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun gainer_process_pcm_frames = ma_gainer_process_pcm_frames(p_gainer : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun gainer_set_gain = ma_gainer_set_gain(p_gainer : Pointer(Void), new_gain : LibC::Float)
    fun gainer_set_gains = ma_gainer_set_gains(p_gainer : Pointer(Void), p_new_gains : Pointer(LibC::Float))
    fun gainer_set_master_volume = ma_gainer_set_master_volume(p_gainer : Pointer(Void), volume : LibC::Float)
    fun gainer_get_master_volume = ma_gainer_get_master_volume(p_gainer : Pointer(Void), p_volume : Pointer(LibC::Float))

    struct PannerConfig
      format : Void
      channels : Void
      mode : Void
      pan : LibC::Float
    end

    fun panner_config_init = ma_panner_config_init(format : Void, channels : Void)

    struct Panner
      format : Void
      channels : Void
      mode : Void
      pan : LibC::Float
    end

    fun panner_init = ma_panner_init(p_config : Pointer(Void), p_panner : Pointer(Void))
    fun panner_process_pcm_frames = ma_panner_process_pcm_frames(p_panner : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun panner_set_mode = ma_panner_set_mode(p_panner : Pointer(Void), mode : Void)
    fun panner_get_mode = ma_panner_get_mode(p_panner : Pointer(Void))
    fun panner_set_pan = ma_panner_set_pan(p_panner : Pointer(Void), pan : LibC::Float)
    fun panner_get_pan = ma_panner_get_pan(p_panner : Pointer(Void)) : LibC::Float

    struct FaderConfig
      format : Void
      channels : Void
      sample_rate : Void
    end

    fun fader_config_init = ma_fader_config_init(format : Void, channels : Void, sample_rate : Void)

    struct Fader
      config : Void
      volume_beg : LibC::Float
      volume_end : LibC::Float
      length_in_frames : Void
      cursor_in_frames : Void
    end

    fun fader_init = ma_fader_init(p_config : Pointer(Void), p_fader : Pointer(Void))
    fun fader_process_pcm_frames = ma_fader_process_pcm_frames(p_fader : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun fader_get_data_format = ma_fader_get_data_format(p_fader : Pointer(Void), p_format : Pointer(Void), p_channels : Pointer(Void), p_sample_rate : Pointer(Void))
    fun fader_set_fade = ma_fader_set_fade(p_fader : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, length_in_frames : Void)
    fun fader_set_fade_ex = ma_fader_set_fade_ex(p_fader : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, length_in_frames : Void, start_offset_in_frames : Void)
    fun fader_get_current_volume = ma_fader_get_current_volume(p_fader : Pointer(Void)) : LibC::Float

    struct Vec3f
      x : LibC::Float
      y : LibC::Float
      z : LibC::Float
    end

    struct AtomicVec3f
      v : Void
      lock : Void
    end

    struct SpatializerListenerConfig
      channels_out : Void
      p_channel_map_out : Pointer(Void)
      handedness : Void
      cone_inner_angle_in_radians : LibC::Float
      cone_outer_angle_in_radians : LibC::Float
      cone_outer_gain : LibC::Float
      speed_of_sound : LibC::Float
      world_up : Void
    end

    fun spatializer_listener_config_init = ma_spatializer_listener_config_init(channels_out : Void)

    struct SpatializerListener
      config : Void
      position : Void
      direction : Void
      velocity : Void
      is_enabled : Void
      _owns_heap : Void
      _p_heap : Pointer(Void)
    end

    fun spatializer_listener_get_heap_size = ma_spatializer_listener_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun spatializer_listener_init_preallocated = ma_spatializer_listener_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_listener : Pointer(Void))
    fun spatializer_listener_init = ma_spatializer_listener_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_listener : Pointer(Void))
    fun spatializer_listener_uninit = ma_spatializer_listener_uninit(p_listener : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun spatializer_listener_get_channel_map = ma_spatializer_listener_get_channel_map(p_listener : Pointer(Void)) : Pointer(Void)
    fun spatializer_listener_set_cone = ma_spatializer_listener_set_cone(p_listener : Pointer(Void), inner_angle_in_radians : LibC::Float, outer_angle_in_radians : LibC::Float, outer_gain : LibC::Float)
    fun spatializer_listener_get_cone = ma_spatializer_listener_get_cone(p_listener : Pointer(Void), p_inner_angle_in_radians : Pointer(LibC::Float), p_outer_angle_in_radians : Pointer(LibC::Float), p_outer_gain : Pointer(LibC::Float))
    fun spatializer_listener_set_position = ma_spatializer_listener_set_position(p_listener : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun spatializer_listener_get_position = ma_spatializer_listener_get_position(p_listener : Pointer(Void))
    fun spatializer_listener_set_direction = ma_spatializer_listener_set_direction(p_listener : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun spatializer_listener_get_direction = ma_spatializer_listener_get_direction(p_listener : Pointer(Void))
    fun spatializer_listener_set_velocity = ma_spatializer_listener_set_velocity(p_listener : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun spatializer_listener_get_velocity = ma_spatializer_listener_get_velocity(p_listener : Pointer(Void))
    fun spatializer_listener_set_speed_of_sound = ma_spatializer_listener_set_speed_of_sound(p_listener : Pointer(Void), speed_of_sound : LibC::Float)
    fun spatializer_listener_get_speed_of_sound = ma_spatializer_listener_get_speed_of_sound(p_listener : Pointer(Void)) : LibC::Float
    fun spatializer_listener_set_world_up = ma_spatializer_listener_set_world_up(p_listener : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun spatializer_listener_get_world_up = ma_spatializer_listener_get_world_up(p_listener : Pointer(Void))
    fun spatializer_listener_set_enabled = ma_spatializer_listener_set_enabled(p_listener : Pointer(Void), is_enabled : Void)
    fun spatializer_listener_is_enabled = ma_spatializer_listener_is_enabled(p_listener : Pointer(Void))

    struct SpatializerConfig
      channels_in : Void
      channels_out : Void
      p_channel_map_in : Pointer(Void)
      attenuation_model : Void
      positioning : Void
      handedness : Void
      min_gain : LibC::Float
      max_gain : LibC::Float
      min_distance : LibC::Float
      max_distance : LibC::Float
      rolloff : LibC::Float
      cone_inner_angle_in_radians : LibC::Float
      cone_outer_angle_in_radians : LibC::Float
      cone_outer_gain : LibC::Float
      doppler_factor : LibC::Float
      directional_attenuation_factor : LibC::Float
      min_spatialization_channel_gain : LibC::Float
      gain_smooth_time_in_frames : Void
    end

    fun spatializer_config_init = ma_spatializer_config_init(channels_in : Void, channels_out : Void)

    struct Spatializer
      channels_in : Void
      channels_out : Void
      p_channel_map_in : Pointer(Void)
      attenuation_model : Void
      positioning : Void
      handedness : Void
      min_gain : LibC::Float
      max_gain : LibC::Float
      min_distance : LibC::Float
      max_distance : LibC::Float
      rolloff : LibC::Float
      cone_inner_angle_in_radians : LibC::Float
      cone_outer_angle_in_radians : LibC::Float
      cone_outer_gain : LibC::Float
      doppler_factor : LibC::Float
      directional_attenuation_factor : LibC::Float
      gain_smooth_time_in_frames : Void
      position : Void
      direction : Void
      velocity : Void
      doppler_pitch : LibC::Float
      min_spatialization_channel_gain : LibC::Float
      gainer : Void
      p_new_channel_gains_out : Pointer(LibC::Float)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun spatializer_get_heap_size = ma_spatializer_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun spatializer_init_preallocated = ma_spatializer_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_spatializer : Pointer(Void))
    fun spatializer_init = ma_spatializer_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_spatializer : Pointer(Void))
    fun spatializer_uninit = ma_spatializer_uninit(p_spatializer : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun spatializer_process_pcm_frames = ma_spatializer_process_pcm_frames(p_spatializer : Pointer(Void), p_listener : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun spatializer_set_master_volume = ma_spatializer_set_master_volume(p_spatializer : Pointer(Void), volume : LibC::Float)
    fun spatializer_get_master_volume = ma_spatializer_get_master_volume(p_spatializer : Pointer(Void), p_volume : Pointer(LibC::Float))
    fun spatializer_get_input_channels = ma_spatializer_get_input_channels(p_spatializer : Pointer(Void))
    fun spatializer_get_output_channels = ma_spatializer_get_output_channels(p_spatializer : Pointer(Void))
    fun spatializer_set_attenuation_model = ma_spatializer_set_attenuation_model(p_spatializer : Pointer(Void), attenuation_model : Void)
    fun spatializer_get_attenuation_model = ma_spatializer_get_attenuation_model(p_spatializer : Pointer(Void))
    fun spatializer_set_positioning = ma_spatializer_set_positioning(p_spatializer : Pointer(Void), positioning : Void)
    fun spatializer_get_positioning = ma_spatializer_get_positioning(p_spatializer : Pointer(Void))
    fun spatializer_set_rolloff = ma_spatializer_set_rolloff(p_spatializer : Pointer(Void), rolloff : LibC::Float)
    fun spatializer_get_rolloff = ma_spatializer_get_rolloff(p_spatializer : Pointer(Void)) : LibC::Float
    fun spatializer_set_min_gain = ma_spatializer_set_min_gain(p_spatializer : Pointer(Void), min_gain : LibC::Float)
    fun spatializer_get_min_gain = ma_spatializer_get_min_gain(p_spatializer : Pointer(Void)) : LibC::Float
    fun spatializer_set_max_gain = ma_spatializer_set_max_gain(p_spatializer : Pointer(Void), max_gain : LibC::Float)
    fun spatializer_get_max_gain = ma_spatializer_get_max_gain(p_spatializer : Pointer(Void)) : LibC::Float
    fun spatializer_set_min_distance = ma_spatializer_set_min_distance(p_spatializer : Pointer(Void), min_distance : LibC::Float)
    fun spatializer_get_min_distance = ma_spatializer_get_min_distance(p_spatializer : Pointer(Void)) : LibC::Float
    fun spatializer_set_max_distance = ma_spatializer_set_max_distance(p_spatializer : Pointer(Void), max_distance : LibC::Float)
    fun spatializer_get_max_distance = ma_spatializer_get_max_distance(p_spatializer : Pointer(Void)) : LibC::Float
    fun spatializer_set_cone = ma_spatializer_set_cone(p_spatializer : Pointer(Void), inner_angle_in_radians : LibC::Float, outer_angle_in_radians : LibC::Float, outer_gain : LibC::Float)
    fun spatializer_get_cone = ma_spatializer_get_cone(p_spatializer : Pointer(Void), p_inner_angle_in_radians : Pointer(LibC::Float), p_outer_angle_in_radians : Pointer(LibC::Float), p_outer_gain : Pointer(LibC::Float))
    fun spatializer_set_doppler_factor = ma_spatializer_set_doppler_factor(p_spatializer : Pointer(Void), doppler_factor : LibC::Float)
    fun spatializer_get_doppler_factor = ma_spatializer_get_doppler_factor(p_spatializer : Pointer(Void)) : LibC::Float
    fun spatializer_set_directional_attenuation_factor = ma_spatializer_set_directional_attenuation_factor(p_spatializer : Pointer(Void), directional_attenuation_factor : LibC::Float)
    fun spatializer_get_directional_attenuation_factor = ma_spatializer_get_directional_attenuation_factor(p_spatializer : Pointer(Void)) : LibC::Float
    fun spatializer_set_position = ma_spatializer_set_position(p_spatializer : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun spatializer_get_position = ma_spatializer_get_position(p_spatializer : Pointer(Void))
    fun spatializer_set_direction = ma_spatializer_set_direction(p_spatializer : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun spatializer_get_direction = ma_spatializer_get_direction(p_spatializer : Pointer(Void))
    fun spatializer_set_velocity = ma_spatializer_set_velocity(p_spatializer : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun spatializer_get_velocity = ma_spatializer_get_velocity(p_spatializer : Pointer(Void))
    fun spatializer_get_relative_position_and_direction = ma_spatializer_get_relative_position_and_direction(p_spatializer : Pointer(Void), p_listener : Pointer(Void), p_relative_pos : Pointer(Void), p_relative_dir : Pointer(Void))

    struct LinearResamplerConfig
      format : Void
      channels : Void
      sample_rate_in : Void
      sample_rate_out : Void
      lpf_order : Void
      lpf_nyquist_factor : LibC::Double
    end

    fun linear_resampler_config_init = ma_linear_resampler_config_init(format : Void, channels : Void, sample_rate_in : Void, sample_rate_out : Void)

    struct LinearResampler
      config : Void
      in_advance_int : Void
      in_advance_frac : Void
      in_time_int : Void
      in_time_frac : Void
      x0 : LinearResamplerX0
      x1 : LinearResamplerX1
      lpf : Void
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    union LinearResamplerX0
      f32 : Pointer(LibC::Float)
      s16 : Pointer(Void)
    end

    union LinearResamplerX1
      f32 : Pointer(LibC::Float)
      s16 : Pointer(Void)
    end

    fun linear_resampler_get_heap_size = ma_linear_resampler_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun linear_resampler_init_preallocated = ma_linear_resampler_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_resampler : Pointer(Void))
    fun linear_resampler_init = ma_linear_resampler_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_resampler : Pointer(Void))
    fun linear_resampler_uninit = ma_linear_resampler_uninit(p_resampler : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun linear_resampler_process_pcm_frames = ma_linear_resampler_process_pcm_frames(p_resampler : Pointer(Void), p_frames_in : Pointer(Void), p_frame_count_in : Pointer(Void), p_frames_out : Pointer(Void), p_frame_count_out : Pointer(Void))
    fun linear_resampler_set_rate = ma_linear_resampler_set_rate(p_resampler : Pointer(Void), sample_rate_in : Void, sample_rate_out : Void)
    fun linear_resampler_set_rate_ratio = ma_linear_resampler_set_rate_ratio(p_resampler : Pointer(Void), ratio_in_out : LibC::Float)
    fun linear_resampler_get_input_latency = ma_linear_resampler_get_input_latency(p_resampler : Pointer(Void))
    fun linear_resampler_get_output_latency = ma_linear_resampler_get_output_latency(p_resampler : Pointer(Void))
    fun linear_resampler_get_required_input_frame_count = ma_linear_resampler_get_required_input_frame_count(p_resampler : Pointer(Void), output_frame_count : Void, p_input_frame_count : Pointer(Void))
    fun linear_resampler_get_expected_output_frame_count = ma_linear_resampler_get_expected_output_frame_count(p_resampler : Pointer(Void), input_frame_count : Void, p_output_frame_count : Pointer(Void))
    fun linear_resampler_reset = ma_linear_resampler_reset(p_resampler : Pointer(Void))

    struct ResamplerConfig
      format : Void
      channels : Void
      sample_rate_in : Void
      sample_rate_out : Void
      algorithm : Void
      p_backend_v_table : Pointer(Void)
      p_backend_user_data : Pointer(Void)
      linear : ResamplerConfigLinear
    end

    struct ResamplerConfigLinear
      lpf_order : Void
    end

    struct ResamplingBackendVtable
      on_get_heap_size : (Pointer(Void), Pointer(Void), Pointer(Void) -> Void)
      on_init : (Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Pointer(Void)) -> Void)
      on_uninit : (Pointer(Void), Pointer(Void), Pointer(Void) -> Void)
      on_process : (Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Void) -> Void)
      on_set_rate : (Pointer(Void), Pointer(Void), Void, Void -> Void)
      on_get_input_latency : (Pointer(Void), Pointer(Void) -> Void)
      on_get_output_latency : (Pointer(Void), Pointer(Void) -> Void)
      on_get_required_input_frame_count : (Pointer(Void), Pointer(Void), Void, Pointer(Void) -> Void)
      on_get_expected_output_frame_count : (Pointer(Void), Pointer(Void), Void, Pointer(Void) -> Void)
      on_reset : (Pointer(Void), Pointer(Void) -> Void)
    end

    fun resampler_config_init = ma_resampler_config_init(format : Void, channels : Void, sample_rate_in : Void, sample_rate_out : Void, algorithm : Void)

    struct Resampler
      p_backend : Pointer(Void)
      p_backend_v_table : Pointer(Void)
      p_backend_user_data : Pointer(Void)
      format : Void
      channels : Void
      sample_rate_in : Void
      sample_rate_out : Void
      state : ResamplerState
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    union ResamplerState
      linear : Void
    end

    fun resampler_get_heap_size = ma_resampler_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun resampler_init_preallocated = ma_resampler_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_resampler : Pointer(Void))
    fun resampler_init = ma_resampler_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_resampler : Pointer(Void))
    fun resampler_uninit = ma_resampler_uninit(p_resampler : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun resampler_process_pcm_frames = ma_resampler_process_pcm_frames(p_resampler : Pointer(Void), p_frames_in : Pointer(Void), p_frame_count_in : Pointer(Void), p_frames_out : Pointer(Void), p_frame_count_out : Pointer(Void))
    fun resampler_set_rate = ma_resampler_set_rate(p_resampler : Pointer(Void), sample_rate_in : Void, sample_rate_out : Void)
    fun resampler_set_rate_ratio = ma_resampler_set_rate_ratio(p_resampler : Pointer(Void), ratio : LibC::Float)
    fun resampler_get_input_latency = ma_resampler_get_input_latency(p_resampler : Pointer(Void))
    fun resampler_get_output_latency = ma_resampler_get_output_latency(p_resampler : Pointer(Void))
    fun resampler_get_required_input_frame_count = ma_resampler_get_required_input_frame_count(p_resampler : Pointer(Void), output_frame_count : Void, p_input_frame_count : Pointer(Void))
    fun resampler_get_expected_output_frame_count = ma_resampler_get_expected_output_frame_count(p_resampler : Pointer(Void), input_frame_count : Void, p_output_frame_count : Pointer(Void))
    fun resampler_reset = ma_resampler_reset(p_resampler : Pointer(Void))

    struct ChannelConverterConfig
      format : Void
      channels_in : Void
      channels_out : Void
      p_channel_map_in : Pointer(Void)
      p_channel_map_out : Pointer(Void)
      mixing_mode : Void
      calculate_lfe_from_spatial_channels : Void
      pp_weights : Pointer(Pointer(LibC::Float))
    end

    fun channel_converter_config_init = ma_channel_converter_config_init(format : Void, channels_in : Void, p_channel_map_in : Pointer(Void), channels_out : Void, p_channel_map_out : Pointer(Void), mixing_mode : Void)

    struct ChannelConverter
      format : Void
      channels_in : Void
      channels_out : Void
      mixing_mode : Void
      conversion_path : Void
      p_channel_map_in : Pointer(Void)
      p_channel_map_out : Pointer(Void)
      p_shuffle_table : Pointer(Void)
      weights : ChannelConverterWeights
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    union ChannelConverterWeights
      f32 : Pointer(Pointer(LibC::Float))
      s16 : Pointer(Pointer(Void))
    end

    fun channel_converter_get_heap_size = ma_channel_converter_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun channel_converter_init_preallocated = ma_channel_converter_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_converter : Pointer(Void))
    fun channel_converter_init = ma_channel_converter_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_converter : Pointer(Void))
    fun channel_converter_uninit = ma_channel_converter_uninit(p_converter : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun channel_converter_process_pcm_frames = ma_channel_converter_process_pcm_frames(p_converter : Pointer(Void), p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void)
    fun channel_converter_get_input_channel_map = ma_channel_converter_get_input_channel_map(p_converter : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun channel_converter_get_output_channel_map = ma_channel_converter_get_output_channel_map(p_converter : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)

    struct DataConverterConfig
      format_in : Void
      format_out : Void
      channels_in : Void
      channels_out : Void
      sample_rate_in : Void
      sample_rate_out : Void
      p_channel_map_in : Pointer(Void)
      p_channel_map_out : Pointer(Void)
      dither_mode : Void
      channel_mix_mode : Void
      calculate_lfe_from_spatial_channels : Void
      pp_channel_weights : Pointer(Pointer(LibC::Float))
      allow_dynamic_sample_rate : Void
      resampling : Void
    end

    fun data_converter_config_init_default = ma_data_converter_config_init_default
    fun data_converter_config_init = ma_data_converter_config_init(format_in : Void, format_out : Void, channels_in : Void, channels_out : Void, sample_rate_in : Void, sample_rate_out : Void)

    struct DataConverter
      format_in : Void
      format_out : Void
      channels_in : Void
      channels_out : Void
      sample_rate_in : Void
      sample_rate_out : Void
      dither_mode : Void
      execution_path : Void
      channel_converter : Void
      resampler : Void
      has_pre_format_conversion : Void
      has_post_format_conversion : Void
      has_channel_converter : Void
      has_resampler : Void
      is_passthrough : Void
      _owns_heap : Void
      _p_heap : Pointer(Void)
    end

    fun data_converter_get_heap_size = ma_data_converter_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun data_converter_init_preallocated = ma_data_converter_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_converter : Pointer(Void))
    fun data_converter_init = ma_data_converter_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_converter : Pointer(Void))
    fun data_converter_uninit = ma_data_converter_uninit(p_converter : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun data_converter_process_pcm_frames = ma_data_converter_process_pcm_frames(p_converter : Pointer(Void), p_frames_in : Pointer(Void), p_frame_count_in : Pointer(Void), p_frames_out : Pointer(Void), p_frame_count_out : Pointer(Void))
    fun data_converter_set_rate = ma_data_converter_set_rate(p_converter : Pointer(Void), sample_rate_in : Void, sample_rate_out : Void)
    fun data_converter_set_rate_ratio = ma_data_converter_set_rate_ratio(p_converter : Pointer(Void), ratio_in_out : LibC::Float)
    fun data_converter_get_input_latency = ma_data_converter_get_input_latency(p_converter : Pointer(Void))
    fun data_converter_get_output_latency = ma_data_converter_get_output_latency(p_converter : Pointer(Void))
    fun data_converter_get_required_input_frame_count = ma_data_converter_get_required_input_frame_count(p_converter : Pointer(Void), output_frame_count : Void, p_input_frame_count : Pointer(Void))
    fun data_converter_get_expected_output_frame_count = ma_data_converter_get_expected_output_frame_count(p_converter : Pointer(Void), input_frame_count : Void, p_output_frame_count : Pointer(Void))
    fun data_converter_get_input_channel_map = ma_data_converter_get_input_channel_map(p_converter : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun data_converter_get_output_channel_map = ma_data_converter_get_output_channel_map(p_converter : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun data_converter_reset = ma_data_converter_reset(p_converter : Pointer(Void))
    fun pcm_u8_to_s16 = ma_pcm_u8_to_s16(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_u8_to_s24 = ma_pcm_u8_to_s24(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_u8_to_s32 = ma_pcm_u8_to_s32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_u8_to_f32 = ma_pcm_u8_to_f32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s16_to_u8 = ma_pcm_s16_to_u8(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s16_to_s24 = ma_pcm_s16_to_s24(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s16_to_s32 = ma_pcm_s16_to_s32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s16_to_f32 = ma_pcm_s16_to_f32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s24_to_u8 = ma_pcm_s24_to_u8(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s24_to_s16 = ma_pcm_s24_to_s16(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s24_to_s32 = ma_pcm_s24_to_s32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s24_to_f32 = ma_pcm_s24_to_f32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s32_to_u8 = ma_pcm_s32_to_u8(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s32_to_s16 = ma_pcm_s32_to_s16(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s32_to_s24 = ma_pcm_s32_to_s24(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_s32_to_f32 = ma_pcm_s32_to_f32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_f32_to_u8 = ma_pcm_f32_to_u8(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_f32_to_s16 = ma_pcm_f32_to_s16(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_f32_to_s24 = ma_pcm_f32_to_s24(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_f32_to_s32 = ma_pcm_f32_to_s32(p_out : Pointer(Void), p_in : Pointer(Void), count : Void, dither_mode : Void)
    fun pcm_convert = ma_pcm_convert(p_out : Pointer(Void), format_out : Void, p_in : Pointer(Void), format_in : Void, sample_count : Void, dither_mode : Void)
    fun convert_pcm_frames_format = ma_convert_pcm_frames_format(p_out : Pointer(Void), format_out : Void, p_in : Pointer(Void), format_in : Void, frame_count : Void, channels : Void, dither_mode : Void)
    fun deinterleave_pcm_frames = ma_deinterleave_pcm_frames(format : Void, channels : Void, frame_count : Void, p_interleaved_pcm_frames : Pointer(Void), pp_deinterleaved_pcm_frames : Pointer(Pointer(Void)))
    fun interleave_pcm_frames = ma_interleave_pcm_frames(format : Void, channels : Void, frame_count : Void, pp_deinterleaved_pcm_frames : Pointer(Pointer(Void)), p_interleaved_pcm_frames : Pointer(Void))
    fun channel_map_get_channel = ma_channel_map_get_channel(p_channel_map : Pointer(Void), channel_count : Void, channel_index : Void)
    fun channel_map_init_blank = ma_channel_map_init_blank(p_channel_map : Pointer(Void), channels : Void)
    fun channel_map_init_standard = ma_channel_map_init_standard(standard_channel_map : Void, p_channel_map : Pointer(Void), channel_map_cap : Void, channels : Void)
    fun channel_map_copy = ma_channel_map_copy(p_out : Pointer(Void), p_in : Pointer(Void), channels : Void)
    fun channel_map_copy_or_default = ma_channel_map_copy_or_default(p_out : Pointer(Void), channel_map_cap_out : Void, p_in : Pointer(Void), channels : Void)
    fun channel_map_is_valid = ma_channel_map_is_valid(p_channel_map : Pointer(Void), channels : Void)
    fun channel_map_is_equal = ma_channel_map_is_equal(p_channel_map_a : Pointer(Void), p_channel_map_b : Pointer(Void), channels : Void)
    fun channel_map_is_blank = ma_channel_map_is_blank(p_channel_map : Pointer(Void), channels : Void)
    fun channel_map_contains_channel_position = ma_channel_map_contains_channel_position(channels : Void, p_channel_map : Pointer(Void), channel_position : Void)
    fun channel_map_find_channel_position = ma_channel_map_find_channel_position(channels : Void, p_channel_map : Pointer(Void), channel_position : Void, p_channel_index : Pointer(Void))
    fun channel_map_to_string = ma_channel_map_to_string(p_channel_map : Pointer(Void), channels : Void, p_buffer_out : Pointer(LibC::Char), buffer_cap : Void)
    fun channel_position_to_string = ma_channel_position_to_string(channel : Void) : Pointer(LibC::Char)
    fun convert_frames = ma_convert_frames(p_out : Pointer(Void), frame_count_out : Void, format_out : Void, channels_out : Void, sample_rate_out : Void, p_in : Pointer(Void), frame_count_in : Void, format_in : Void, channels_in : Void, sample_rate_in : Void)
    fun convert_frames_ex = ma_convert_frames_ex(p_out : Pointer(Void), frame_count_out : Void, p_in : Pointer(Void), frame_count_in : Void, p_config : Pointer(Void))

    struct DataSourceVtable
      on_read : (Pointer(Void), Pointer(Void), Void, Pointer(Void) -> Void)
      on_seek : (Pointer(Void), Void -> Void)
      on_get_data_format : (Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Void), Void -> Void)
      on_get_cursor : (Pointer(Void), Void -> Void)
      on_get_length : (Pointer(Void), Void -> Void)
      on_set_looping : (Pointer(Void), Void -> Void)
      flags : Void
    end

    struct DataSourceConfig
      vtable : Pointer(Void)
    end

    fun data_source_config_init = ma_data_source_config_init

    struct DataSourceBase
      vtable : Pointer(Void)
      range_beg_in_frames : Void
      range_end_in_frames : Void
      loop_beg_in_frames : Void
      loop_end_in_frames : Void
      p_current : Pointer(Void)
      p_next : Pointer(Void)
      on_get_next : Void
      is_looping : Void
    end

    fun data_source_init = ma_data_source_init(p_config : Pointer(Void), p_data_source : Pointer(Void))
    fun data_source_uninit = ma_data_source_uninit(p_data_source : Pointer(Void))
    fun data_source_read_pcm_frames = ma_data_source_read_pcm_frames(p_data_source : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun data_source_seek_pcm_frames = ma_data_source_seek_pcm_frames(p_data_source : Pointer(Void), frame_count : Void, p_frames_seeked : Pointer(Void))
    fun data_source_seek_to_pcm_frame = ma_data_source_seek_to_pcm_frame(p_data_source : Pointer(Void), frame_index : Void)
    fun data_source_seek_seconds = ma_data_source_seek_seconds(p_data_source : Pointer(Void), second_count : LibC::Float, p_seconds_seeked : Pointer(LibC::Float))
    fun data_source_seek_to_second = ma_data_source_seek_to_second(p_data_source : Pointer(Void), seek_point_in_seconds : LibC::Float)
    fun data_source_get_data_format = ma_data_source_get_data_format(p_data_source : Pointer(Void), p_format : Pointer(Void), p_channels : Pointer(Void), p_sample_rate : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun data_source_get_cursor_in_pcm_frames = ma_data_source_get_cursor_in_pcm_frames(p_data_source : Pointer(Void), p_cursor : Pointer(Void))
    fun data_source_get_length_in_pcm_frames = ma_data_source_get_length_in_pcm_frames(p_data_source : Pointer(Void), p_length : Pointer(Void))
    fun data_source_get_cursor_in_seconds = ma_data_source_get_cursor_in_seconds(p_data_source : Pointer(Void), p_cursor : Pointer(LibC::Float))
    fun data_source_get_length_in_seconds = ma_data_source_get_length_in_seconds(p_data_source : Pointer(Void), p_length : Pointer(LibC::Float))
    fun data_source_set_looping = ma_data_source_set_looping(p_data_source : Pointer(Void), is_looping : Void)
    fun data_source_is_looping = ma_data_source_is_looping(p_data_source : Pointer(Void))
    fun data_source_set_range_in_pcm_frames = ma_data_source_set_range_in_pcm_frames(p_data_source : Pointer(Void), range_beg_in_frames : Void, range_end_in_frames : Void)
    fun data_source_get_range_in_pcm_frames = ma_data_source_get_range_in_pcm_frames(p_data_source : Pointer(Void), p_range_beg_in_frames : Pointer(Void), p_range_end_in_frames : Pointer(Void))
    fun data_source_set_loop_point_in_pcm_frames = ma_data_source_set_loop_point_in_pcm_frames(p_data_source : Pointer(Void), loop_beg_in_frames : Void, loop_end_in_frames : Void)
    fun data_source_get_loop_point_in_pcm_frames = ma_data_source_get_loop_point_in_pcm_frames(p_data_source : Pointer(Void), p_loop_beg_in_frames : Pointer(Void), p_loop_end_in_frames : Pointer(Void))
    fun data_source_set_current = ma_data_source_set_current(p_data_source : Pointer(Void), p_current_data_source : Pointer(Void))
    fun data_source_get_current = ma_data_source_get_current(p_data_source : Pointer(Void)) : Pointer(Void)
    fun data_source_set_next = ma_data_source_set_next(p_data_source : Pointer(Void), p_next_data_source : Pointer(Void))
    fun data_source_get_next = ma_data_source_get_next(p_data_source : Pointer(Void)) : Pointer(Void)
    fun data_source_set_next_callback = ma_data_source_set_next_callback(p_data_source : Pointer(Void), on_get_next : Void)
    fun data_source_get_next_callback = ma_data_source_get_next_callback(p_data_source : Pointer(Void))

    struct AudioBufferRef
      ds : Void
      format : Void
      channels : Void
      sample_rate : Void
      cursor : Void
      size_in_frames : Void
      p_data : Pointer(Void)
    end

    fun audio_buffer_ref_init = ma_audio_buffer_ref_init(format : Void, channels : Void, p_data : Pointer(Void), size_in_frames : Void, p_audio_buffer_ref : Pointer(Void))
    fun audio_buffer_ref_uninit = ma_audio_buffer_ref_uninit(p_audio_buffer_ref : Pointer(Void))
    fun audio_buffer_ref_set_data = ma_audio_buffer_ref_set_data(p_audio_buffer_ref : Pointer(Void), p_data : Pointer(Void), size_in_frames : Void)
    fun audio_buffer_ref_read_pcm_frames = ma_audio_buffer_ref_read_pcm_frames(p_audio_buffer_ref : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, loop : Void)
    fun audio_buffer_ref_seek_to_pcm_frame = ma_audio_buffer_ref_seek_to_pcm_frame(p_audio_buffer_ref : Pointer(Void), frame_index : Void)
    fun audio_buffer_ref_map = ma_audio_buffer_ref_map(p_audio_buffer_ref : Pointer(Void), pp_frames_out : Pointer(Pointer(Void)), p_frame_count : Pointer(Void))
    fun audio_buffer_ref_unmap = ma_audio_buffer_ref_unmap(p_audio_buffer_ref : Pointer(Void), frame_count : Void)
    fun audio_buffer_ref_at_end = ma_audio_buffer_ref_at_end(p_audio_buffer_ref : Pointer(Void))
    fun audio_buffer_ref_get_cursor_in_pcm_frames = ma_audio_buffer_ref_get_cursor_in_pcm_frames(p_audio_buffer_ref : Pointer(Void), p_cursor : Pointer(Void))
    fun audio_buffer_ref_get_length_in_pcm_frames = ma_audio_buffer_ref_get_length_in_pcm_frames(p_audio_buffer_ref : Pointer(Void), p_length : Pointer(Void))
    fun audio_buffer_ref_get_available_frames = ma_audio_buffer_ref_get_available_frames(p_audio_buffer_ref : Pointer(Void), p_available_frames : Pointer(Void))

    struct AudioBufferConfig
      format : Void
      channels : Void
      sample_rate : Void
      size_in_frames : Void
      p_data : Pointer(Void)
      allocation_callbacks : Void
    end

    fun audio_buffer_config_init = ma_audio_buffer_config_init(format : Void, channels : Void, size_in_frames : Void, p_data : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct AudioBuffer
      ref : Void
      allocation_callbacks : Void
      owns_data : Void
      _p_extra_data : StaticArray(Void, 1)
    end

    fun audio_buffer_init = ma_audio_buffer_init(p_config : Pointer(Void), p_audio_buffer : Pointer(Void))
    fun audio_buffer_init_copy = ma_audio_buffer_init_copy(p_config : Pointer(Void), p_audio_buffer : Pointer(Void))
    fun audio_buffer_alloc_and_init = ma_audio_buffer_alloc_and_init(p_config : Pointer(Void), pp_audio_buffer : Pointer(Pointer(Void)))
    fun audio_buffer_uninit = ma_audio_buffer_uninit(p_audio_buffer : Pointer(Void))
    fun audio_buffer_uninit_and_free = ma_audio_buffer_uninit_and_free(p_audio_buffer : Pointer(Void))
    fun audio_buffer_read_pcm_frames = ma_audio_buffer_read_pcm_frames(p_audio_buffer : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, loop : Void)
    fun audio_buffer_seek_to_pcm_frame = ma_audio_buffer_seek_to_pcm_frame(p_audio_buffer : Pointer(Void), frame_index : Void)
    fun audio_buffer_map = ma_audio_buffer_map(p_audio_buffer : Pointer(Void), pp_frames_out : Pointer(Pointer(Void)), p_frame_count : Pointer(Void))
    fun audio_buffer_unmap = ma_audio_buffer_unmap(p_audio_buffer : Pointer(Void), frame_count : Void)
    fun audio_buffer_at_end = ma_audio_buffer_at_end(p_audio_buffer : Pointer(Void))
    fun audio_buffer_get_cursor_in_pcm_frames = ma_audio_buffer_get_cursor_in_pcm_frames(p_audio_buffer : Pointer(Void), p_cursor : Pointer(Void))
    fun audio_buffer_get_length_in_pcm_frames = ma_audio_buffer_get_length_in_pcm_frames(p_audio_buffer : Pointer(Void), p_length : Pointer(Void))
    fun audio_buffer_get_available_frames = ma_audio_buffer_get_available_frames(p_audio_buffer : Pointer(Void), p_available_frames : Pointer(Void))

    struct PagedAudioBufferPage
      p_next : Pointer(Void)
      size_in_frames : Void
      p_audio_data : StaticArray(Void, 1)
    end

    struct PagedAudioBufferData
      format : Void
      channels : Void
      head : Void
      p_tail : Pointer(Void)
    end

    fun paged_audio_buffer_data_init = ma_paged_audio_buffer_data_init(format : Void, channels : Void, p_data : Pointer(Void))
    fun paged_audio_buffer_data_uninit = ma_paged_audio_buffer_data_uninit(p_data : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun paged_audio_buffer_data_get_head = ma_paged_audio_buffer_data_get_head(p_data : Pointer(Void)) : Pointer(Void)
    fun paged_audio_buffer_data_get_tail = ma_paged_audio_buffer_data_get_tail(p_data : Pointer(Void)) : Pointer(Void)
    fun paged_audio_buffer_data_get_length_in_pcm_frames = ma_paged_audio_buffer_data_get_length_in_pcm_frames(p_data : Pointer(Void), p_length : Pointer(Void))
    fun paged_audio_buffer_data_allocate_page = ma_paged_audio_buffer_data_allocate_page(p_data : Pointer(Void), page_size_in_frames : Void, p_initial_data : Pointer(Void), p_allocation_callbacks : Pointer(Void), pp_page : Pointer(Pointer(Void)))
    fun paged_audio_buffer_data_free_page = ma_paged_audio_buffer_data_free_page(p_data : Pointer(Void), p_page : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun paged_audio_buffer_data_append_page = ma_paged_audio_buffer_data_append_page(p_data : Pointer(Void), p_page : Pointer(Void))
    fun paged_audio_buffer_data_allocate_and_append_page = ma_paged_audio_buffer_data_allocate_and_append_page(p_data : Pointer(Void), page_size_in_frames : Void, p_initial_data : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct PagedAudioBufferConfig
      p_data : Pointer(Void)
    end

    fun paged_audio_buffer_config_init = ma_paged_audio_buffer_config_init(p_data : Pointer(Void))

    struct PagedAudioBuffer
      ds : Void
      p_data : Pointer(Void)
      p_current : Pointer(Void)
      relative_cursor : Void
      absolute_cursor : Void
    end

    fun paged_audio_buffer_init = ma_paged_audio_buffer_init(p_config : Pointer(Void), p_paged_audio_buffer : Pointer(Void))
    fun paged_audio_buffer_uninit = ma_paged_audio_buffer_uninit(p_paged_audio_buffer : Pointer(Void))
    fun paged_audio_buffer_read_pcm_frames = ma_paged_audio_buffer_read_pcm_frames(p_paged_audio_buffer : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun paged_audio_buffer_seek_to_pcm_frame = ma_paged_audio_buffer_seek_to_pcm_frame(p_paged_audio_buffer : Pointer(Void), frame_index : Void)
    fun paged_audio_buffer_get_cursor_in_pcm_frames = ma_paged_audio_buffer_get_cursor_in_pcm_frames(p_paged_audio_buffer : Pointer(Void), p_cursor : Pointer(Void))
    fun paged_audio_buffer_get_length_in_pcm_frames = ma_paged_audio_buffer_get_length_in_pcm_frames(p_paged_audio_buffer : Pointer(Void), p_length : Pointer(Void))

    struct Rb
      p_buffer : Pointer(Void)
      subbuffer_size_in_bytes : Void
      subbuffer_count : Void
      subbuffer_stride_in_bytes : Void
      encoded_read_offset : Void
      encoded_write_offset : Void
      owns_buffer : Void
      clear_on_write_acquire : Void
      allocation_callbacks : Void
    end

    fun rb_init_ex = ma_rb_init_ex(subbuffer_size_in_bytes : Void, subbuffer_count : Void, subbuffer_stride_in_bytes : Void, p_optional_preallocated_buffer : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_rb : Pointer(Void))
    fun rb_init = ma_rb_init(buffer_size_in_bytes : Void, p_optional_preallocated_buffer : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_rb : Pointer(Void))
    fun rb_uninit = ma_rb_uninit(p_rb : Pointer(Void))
    fun rb_reset = ma_rb_reset(p_rb : Pointer(Void))
    fun rb_acquire_read = ma_rb_acquire_read(p_rb : Pointer(Void), p_size_in_bytes : Pointer(Void), pp_buffer_out : Pointer(Pointer(Void)))
    fun rb_commit_read = ma_rb_commit_read(p_rb : Pointer(Void), size_in_bytes : Void)
    fun rb_acquire_write = ma_rb_acquire_write(p_rb : Pointer(Void), p_size_in_bytes : Pointer(Void), pp_buffer_out : Pointer(Pointer(Void)))
    fun rb_commit_write = ma_rb_commit_write(p_rb : Pointer(Void), size_in_bytes : Void)
    fun rb_seek_read = ma_rb_seek_read(p_rb : Pointer(Void), offset_in_bytes : Void)
    fun rb_seek_write = ma_rb_seek_write(p_rb : Pointer(Void), offset_in_bytes : Void)
    fun rb_pointer_distance = ma_rb_pointer_distance(p_rb : Pointer(Void))
    fun rb_available_read = ma_rb_available_read(p_rb : Pointer(Void))
    fun rb_available_write = ma_rb_available_write(p_rb : Pointer(Void))
    fun rb_get_subbuffer_size = ma_rb_get_subbuffer_size(p_rb : Pointer(Void))
    fun rb_get_subbuffer_stride = ma_rb_get_subbuffer_stride(p_rb : Pointer(Void))
    fun rb_get_subbuffer_offset = ma_rb_get_subbuffer_offset(p_rb : Pointer(Void), subbuffer_index : Void)
    fun rb_get_subbuffer_ptr = ma_rb_get_subbuffer_ptr(p_rb : Pointer(Void), subbuffer_index : Void, p_buffer : Pointer(Void)) : Pointer(Void)

    struct PcmRb
      ds : Void
      rb : Void
      format : Void
      channels : Void
      sample_rate : Void
    end

    fun pcm_rb_init_ex = ma_pcm_rb_init_ex(format : Void, channels : Void, subbuffer_size_in_frames : Void, subbuffer_count : Void, subbuffer_stride_in_frames : Void, p_optional_preallocated_buffer : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_rb : Pointer(Void))
    fun pcm_rb_init = ma_pcm_rb_init(format : Void, channels : Void, buffer_size_in_frames : Void, p_optional_preallocated_buffer : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_rb : Pointer(Void))
    fun pcm_rb_uninit = ma_pcm_rb_uninit(p_rb : Pointer(Void))
    fun pcm_rb_reset = ma_pcm_rb_reset(p_rb : Pointer(Void))
    fun pcm_rb_acquire_read = ma_pcm_rb_acquire_read(p_rb : Pointer(Void), p_size_in_frames : Pointer(Void), pp_buffer_out : Pointer(Pointer(Void)))
    fun pcm_rb_commit_read = ma_pcm_rb_commit_read(p_rb : Pointer(Void), size_in_frames : Void)
    fun pcm_rb_acquire_write = ma_pcm_rb_acquire_write(p_rb : Pointer(Void), p_size_in_frames : Pointer(Void), pp_buffer_out : Pointer(Pointer(Void)))
    fun pcm_rb_commit_write = ma_pcm_rb_commit_write(p_rb : Pointer(Void), size_in_frames : Void)
    fun pcm_rb_seek_read = ma_pcm_rb_seek_read(p_rb : Pointer(Void), offset_in_frames : Void)
    fun pcm_rb_seek_write = ma_pcm_rb_seek_write(p_rb : Pointer(Void), offset_in_frames : Void)
    fun pcm_rb_pointer_distance = ma_pcm_rb_pointer_distance(p_rb : Pointer(Void))
    fun pcm_rb_available_read = ma_pcm_rb_available_read(p_rb : Pointer(Void))
    fun pcm_rb_available_write = ma_pcm_rb_available_write(p_rb : Pointer(Void))
    fun pcm_rb_get_subbuffer_size = ma_pcm_rb_get_subbuffer_size(p_rb : Pointer(Void))
    fun pcm_rb_get_subbuffer_stride = ma_pcm_rb_get_subbuffer_stride(p_rb : Pointer(Void))
    fun pcm_rb_get_subbuffer_offset = ma_pcm_rb_get_subbuffer_offset(p_rb : Pointer(Void), subbuffer_index : Void)
    fun pcm_rb_get_subbuffer_ptr = ma_pcm_rb_get_subbuffer_ptr(p_rb : Pointer(Void), subbuffer_index : Void, p_buffer : Pointer(Void)) : Pointer(Void)
    fun pcm_rb_get_format = ma_pcm_rb_get_format(p_rb : Pointer(Void))
    fun pcm_rb_get_channels = ma_pcm_rb_get_channels(p_rb : Pointer(Void))
    fun pcm_rb_get_sample_rate = ma_pcm_rb_get_sample_rate(p_rb : Pointer(Void))
    fun pcm_rb_set_sample_rate = ma_pcm_rb_set_sample_rate(p_rb : Pointer(Void), sample_rate : Void)

    struct DuplexRb
      rb : Void
    end

    fun duplex_rb_init = ma_duplex_rb_init(capture_format : Void, capture_channels : Void, sample_rate : Void, capture_internal_sample_rate : Void, capture_internal_period_size_in_frames : Void, p_allocation_callbacks : Pointer(Void), p_rb : Pointer(Void))
    fun duplex_rb_uninit = ma_duplex_rb_uninit(p_rb : Pointer(Void))
    fun result_description = ma_result_description(result : Void) : Pointer(LibC::Char)
    fun malloc = ma_malloc(sz : Void, p_allocation_callbacks : Pointer(Void)) : Pointer(Void)
    fun calloc = ma_calloc(sz : Void, p_allocation_callbacks : Pointer(Void)) : Pointer(Void)
    fun realloc = ma_realloc(p : Pointer(Void), sz : Void, p_allocation_callbacks : Pointer(Void)) : Pointer(Void)
    fun free = ma_free(p : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun aligned_malloc = ma_aligned_malloc(sz : Void, alignment : Void, p_allocation_callbacks : Pointer(Void)) : Pointer(Void)
    fun aligned_free = ma_aligned_free(p : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun get_format_name = ma_get_format_name(format : Void) : Pointer(LibC::Char)
    fun blend_f32 = ma_blend_f32(p_out : Pointer(LibC::Float), p_in_a : Pointer(LibC::Float), p_in_b : Pointer(LibC::Float), factor : LibC::Float, channels : Void)
    fun get_bytes_per_sample = ma_get_bytes_per_sample(format : Void)
    fun get_bytes_per_frame = ma_get_bytes_per_frame(format : Void, channels : Void)
    fun log_level_to_string = ma_log_level_to_string(log_level : Void) : Pointer(LibC::Char)
    fun spinlock_lock = ma_spinlock_lock(p_spinlock : Pointer(Void))
    fun spinlock_lock_noyield = ma_spinlock_lock_noyield(p_spinlock : Pointer(Void))
    fun spinlock_unlock = ma_spinlock_unlock(p_spinlock : Pointer(Void))
    fun mutex_init = ma_mutex_init(p_mutex : Pointer(Void))
    fun mutex_uninit = ma_mutex_uninit(p_mutex : Pointer(Void))
    fun mutex_lock = ma_mutex_lock(p_mutex : Pointer(Void))
    fun mutex_unlock = ma_mutex_unlock(p_mutex : Pointer(Void))
    fun event_init = ma_event_init(p_event : Pointer(Void))
    fun event_uninit = ma_event_uninit(p_event : Pointer(Void))
    fun event_wait = ma_event_wait(p_event : Pointer(Void))
    fun event_signal = ma_event_signal(p_event : Pointer(Void))
    fun semaphore_init = ma_semaphore_init(initial_value : LibC::Int, p_semaphore : Pointer(Void))
    fun semaphore_uninit = ma_semaphore_uninit(p_semaphore : Pointer(Void))
    fun semaphore_wait = ma_semaphore_wait(p_semaphore : Pointer(Void))
    fun semaphore_release = ma_semaphore_release(p_semaphore : Pointer(Void))

    struct Fence
      e : Void
      counter : Void
    end

    fun fence_init = ma_fence_init(p_fence : Pointer(Void))
    fun fence_uninit = ma_fence_uninit(p_fence : Pointer(Void))
    fun fence_acquire = ma_fence_acquire(p_fence : Pointer(Void))
    fun fence_release = ma_fence_release(p_fence : Pointer(Void))
    fun fence_wait = ma_fence_wait(p_fence : Pointer(Void))

    struct AsyncNotificationCallbacks
      on_signal : (Pointer(Void) -> Void)
    end

    fun async_notification_signal = ma_async_notification_signal(p_notification : Pointer(Void))

    struct AsyncNotificationPoll
      cb : Void
      signalled : Void
    end

    fun async_notification_poll_init = ma_async_notification_poll_init(p_notification_poll : Pointer(Void))
    fun async_notification_poll_is_signalled = ma_async_notification_poll_is_signalled(p_notification_poll : Pointer(Void))

    struct AsyncNotificationEvent
      cb : Void
      e : Void
    end

    fun async_notification_event_init = ma_async_notification_event_init(p_notification_event : Pointer(Void))
    fun async_notification_event_uninit = ma_async_notification_event_uninit(p_notification_event : Pointer(Void))
    fun async_notification_event_wait = ma_async_notification_event_wait(p_notification_event : Pointer(Void))
    fun async_notification_event_signal = ma_async_notification_event_signal(p_notification_event : Pointer(Void))

    struct SlotAllocatorConfig
      capacity : Void
    end

    fun slot_allocator_config_init = ma_slot_allocator_config_init(capacity : Void)

    struct SlotAllocatorGroup
      bitfield : Void
    end

    struct SlotAllocator
      p_groups : Pointer(Void)
      p_slots : Pointer(Void)
      count : Void
      capacity : Void
      _owns_heap : Void
      _p_heap : Pointer(Void)
    end

    fun slot_allocator_get_heap_size = ma_slot_allocator_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun slot_allocator_init_preallocated = ma_slot_allocator_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_allocator : Pointer(Void))
    fun slot_allocator_init = ma_slot_allocator_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_allocator : Pointer(Void))
    fun slot_allocator_uninit = ma_slot_allocator_uninit(p_allocator : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun slot_allocator_alloc = ma_slot_allocator_alloc(p_allocator : Pointer(Void), p_slot : Pointer(Void))
    fun slot_allocator_free = ma_slot_allocator_free(p_allocator : Pointer(Void), slot : Void)

    struct Job
      toc : JobToc
      next : Void
      order : Void
      data : JobData
    end

    union JobToc
      breakup : JobTocBreakup
      allocation : Void
    end

    struct JobTocBreakup
      code : Void
      slot : Void
      refcount : Void
    end

    union JobData
      custom : JobDataCustom
      resource_manager : JobDataResourceManager
      device : JobDataDevice
    end

    struct JobDataCustom
      proc : Void
      data0 : Void
      data1 : Void
    end

    union JobDataResourceManager
      load_data_buffer_node : JobDataResourceManagerLoadDataBufferNode
      free_data_buffer_node : JobDataResourceManagerFreeDataBufferNode
      page_data_buffer_node : JobDataResourceManagerPageDataBufferNode
      load_data_buffer : JobDataResourceManagerLoadDataBuffer
      free_data_buffer : JobDataResourceManagerFreeDataBuffer
      load_data_stream : JobDataResourceManagerLoadDataStream
      free_data_stream : JobDataResourceManagerFreeDataStream
      page_data_stream : JobDataResourceManagerPageDataStream
      seek_data_stream : JobDataResourceManagerSeekDataStream
    end

    struct JobDataResourceManagerLoadDataBufferNode
      p_resource_manager : Pointer(Void)
      p_data_buffer_node : Pointer(Void)
      p_file_path : Pointer(LibC::Char)
      p_file_path_w : Pointer(Void)
      flags : Void
      p_init_notification : Pointer(Void)
      p_done_notification : Pointer(Void)
      p_init_fence : Pointer(Void)
      p_done_fence : Pointer(Void)
    end

    struct JobDataResourceManagerFreeDataBufferNode
      p_resource_manager : Pointer(Void)
      p_data_buffer_node : Pointer(Void)
      p_done_notification : Pointer(Void)
      p_done_fence : Pointer(Void)
    end

    struct JobDataResourceManagerPageDataBufferNode
      p_resource_manager : Pointer(Void)
      p_data_buffer_node : Pointer(Void)
      p_decoder : Pointer(Void)
      p_done_notification : Pointer(Void)
      p_done_fence : Pointer(Void)
    end

    struct JobDataResourceManagerLoadDataBuffer
      p_data_buffer : Pointer(Void)
      p_init_notification : Pointer(Void)
      p_done_notification : Pointer(Void)
      p_init_fence : Pointer(Void)
      p_done_fence : Pointer(Void)
      range_beg_in_pcm_frames : Void
      range_end_in_pcm_frames : Void
      loop_point_beg_in_pcm_frames : Void
      loop_point_end_in_pcm_frames : Void
      is_looping : Void
    end

    struct JobDataResourceManagerFreeDataBuffer
      p_data_buffer : Pointer(Void)
      p_done_notification : Pointer(Void)
      p_done_fence : Pointer(Void)
    end

    struct JobDataResourceManagerLoadDataStream
      p_data_stream : Pointer(Void)
      p_file_path : Pointer(LibC::Char)
      p_file_path_w : Pointer(Void)
      initial_seek_point : Void
      p_init_notification : Pointer(Void)
      p_init_fence : Pointer(Void)
    end

    struct JobDataResourceManagerFreeDataStream
      p_data_stream : Pointer(Void)
      p_done_notification : Pointer(Void)
      p_done_fence : Pointer(Void)
    end

    struct JobDataResourceManagerPageDataStream
      p_data_stream : Pointer(Void)
      page_index : Void
    end

    struct JobDataResourceManagerSeekDataStream
      p_data_stream : Pointer(Void)
      frame_index : Void
    end

    union JobDataDevice
      aaudio : JobDataDeviceAaudio
    end

    union JobDataDeviceAaudio
      reroute : JobDataDeviceAaudioReroute
    end

    struct JobDataDeviceAaudioReroute
      p_device : Pointer(Void)
      device_type : Void
    end

    fun job_init = ma_job_init(code : Void)
    fun job_process = ma_job_process(p_job : Pointer(Void))

    struct JobQueueConfig
      flags : Void
      capacity : Void
    end

    fun job_queue_config_init = ma_job_queue_config_init(flags : Void, capacity : Void)

    struct JobQueue
      flags : Void
      capacity : Void
      head : Void
      tail : Void
      sem : Void
      allocator : Void
      p_jobs : Pointer(Void)
      lock : Void
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun job_queue_get_heap_size = ma_job_queue_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun job_queue_init_preallocated = ma_job_queue_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_queue : Pointer(Void))
    fun job_queue_init = ma_job_queue_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_queue : Pointer(Void))
    fun job_queue_uninit = ma_job_queue_uninit(p_queue : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun job_queue_post = ma_job_queue_post(p_queue : Pointer(Void), p_job : Pointer(Void))
    fun job_queue_next = ma_job_queue_next(p_queue : Pointer(Void), p_job : Pointer(Void))

    struct AtomicDeviceState
      value : Void
    end

    struct DeviceJobThreadConfig
      no_thread : Void
      job_queue_capacity : Void
      job_queue_flags : Void
    end

    fun device_job_thread_config_init = ma_device_job_thread_config_init

    struct DeviceJobThread
      thread : Void
      job_queue : Void
      _has_thread : Void
    end

    fun device_job_thread_init = ma_device_job_thread_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_job_thread : Pointer(Void))
    fun device_job_thread_uninit = ma_device_job_thread_uninit(p_job_thread : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun device_job_thread_post = ma_device_job_thread_post(p_job_thread : Pointer(Void), p_job : Pointer(Void))
    fun device_job_thread_next = ma_device_job_thread_next(p_job_thread : Pointer(Void), p_job : Pointer(Void))

    struct DeviceNotification
      p_device : Pointer(Void)
      type : Void
      data : DeviceNotificationData
    end

    union DeviceNotificationData
      started : DeviceNotificationDataStarted
      stopped : DeviceNotificationDataStopped
      rerouted : DeviceNotificationDataRerouted
      interruption : DeviceNotificationDataInterruption
    end

    struct DeviceNotificationDataStarted
      _unused : LibC::Int
    end

    struct DeviceNotificationDataStopped
      _unused : LibC::Int
    end

    struct DeviceNotificationDataRerouted
      _unused : LibC::Int
    end

    struct DeviceNotificationDataInterruption
      _unused : LibC::Int
    end

    union Timer
      counter : Void
      counter_d : LibC::Double
    end

    union DeviceId
      wasapi : StaticArray(Void, 64)
      dsound : StaticArray(Void, 16)
      winmm : Void
      alsa : StaticArray(LibC::Char, 256)
      pulse : StaticArray(LibC::Char, 256)
      jack : LibC::Int
      coreaudio : StaticArray(LibC::Char, 256)
      sndio : StaticArray(LibC::Char, 256)
      audio4 : StaticArray(LibC::Char, 256)
      oss : StaticArray(LibC::Char, 64)
      aaudio : Void
      opensl : Void
      webaudio : StaticArray(LibC::Char, 32)
      custom : DeviceIdCustom
      nullbackend : LibC::Int
    end

    union DeviceIdCustom
      i : LibC::Int
      s : StaticArray(LibC::Char, 256)
      p : Pointer(Void)
    end

    fun device_id_equal = ma_device_id_equal(p_a : Pointer(Void), p_b : Pointer(Void))

    struct ContextConfig
      p_log : Pointer(Void)
      thread_priority : Void
      thread_stack_size : Void
      p_user_data : Pointer(Void)
      allocation_callbacks : Void
      dsound : ContextConfigDsound
      alsa : ContextConfigAlsa
      pulse : ContextConfigPulse
      coreaudio : ContextConfigCoreaudio
      jack : ContextConfigJack
      custom : Void
    end

    struct ContextConfigDsound
      h_wnd : Void
    end

    struct ContextConfigAlsa
      use_verbose_device_enumeration : Void
    end

    struct ContextConfigPulse
      p_application_name : Pointer(LibC::Char)
      p_server_name : Pointer(LibC::Char)
      try_auto_spawn : Void
    end

    struct ContextConfigCoreaudio
      session_category : Void
      session_category_options : Void
      no_audio_session_activate : Void
      no_audio_session_deactivate : Void
    end

    struct ContextConfigJack
      p_client_name : Pointer(LibC::Char)
      try_start_server : Void
    end

    struct DeviceConfig
      device_type : Void
      sample_rate : Void
      period_size_in_frames : Void
      period_size_in_milliseconds : Void
      periods : Void
      performance_profile : Void
      no_pre_silenced_output_buffer : Void
      no_clip : Void
      no_disable_denormals : Void
      no_fixed_sized_callback : Void
      data_callback : Void
      notification_callback : Void
      stop_callback : Void
      p_user_data : Pointer(Void)
      resampling : Void
      playback : DeviceConfigPlayback
      capture : DeviceConfigCapture
      wasapi : DeviceConfigWasapi
      alsa : DeviceConfigAlsa
      pulse : DeviceConfigPulse
      coreaudio : DeviceConfigCoreaudio
      opensl : DeviceConfigOpensl
      aaudio : DeviceConfigAaudio
    end

    struct DeviceConfigPlayback
      p_device_id : Pointer(Void)
      format : Void
      channels : Void
      p_channel_map : Pointer(Void)
      channel_mix_mode : Void
      calculate_lfe_from_spatial_channels : Void
      share_mode : Void
    end

    struct DeviceConfigCapture
      p_device_id : Pointer(Void)
      format : Void
      channels : Void
      p_channel_map : Pointer(Void)
      channel_mix_mode : Void
      calculate_lfe_from_spatial_channels : Void
      share_mode : Void
    end

    struct DeviceConfigWasapi
      usage : Void
      no_auto_convert_src : Void
      no_default_quality_src : Void
      no_auto_stream_routing : Void
      no_hardware_offloading : Void
      loopback_process_id : Void
      loopback_process_exclude : Void
    end

    struct DeviceConfigAlsa
      no_m_map : Void
      no_auto_format : Void
      no_auto_channels : Void
      no_auto_resample : Void
    end

    struct DeviceConfigPulse
      p_stream_name_playback : Pointer(LibC::Char)
      p_stream_name_capture : Pointer(LibC::Char)
      channel_map : LibC::Int
    end

    struct DeviceConfigCoreaudio
      allow_nominal_sample_rate_change : Void
    end

    struct DeviceConfigOpensl
      stream_type : Void
      recording_preset : Void
      enable_compatibility_workarounds : Void
    end

    struct DeviceConfigAaudio
      usage : Void
      content_type : Void
      input_preset : Void
      allowed_capture_policy : Void
      no_auto_start_after_reroute : Void
      enable_compatibility_workarounds : Void
      allow_set_buffer_capacity : Void
    end

    struct BackendCallbacks
      on_context_init : (Pointer(Void), Pointer(Void), Pointer(Void) -> Void)
      on_context_uninit : (Pointer(Void) -> Void)
      on_context_enumerate_devices : (Pointer(Void), Void, Pointer(Void) -> Void)
      on_context_get_device_info : (Pointer(Void), Void, Pointer(Void), Pointer(Void) -> Void)
      on_device_init : (Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Void) -> Void)
      on_device_uninit : (Pointer(Void) -> Void)
      on_device_start : (Pointer(Void) -> Void)
      on_device_stop : (Pointer(Void) -> Void)
      on_device_read : (Pointer(Void), Pointer(Void), Void, Pointer(Void) -> Void)
      on_device_write : (Pointer(Void), Pointer(Void), Void, Pointer(Void) -> Void)
      on_device_data_loop : (Pointer(Void) -> Void)
      on_device_data_loop_wakeup : (Pointer(Void) -> Void)
      on_device_get_info : (Pointer(Void), Void, Pointer(Void) -> Void)
    end

    struct DeviceInfo
      id : Void
      name : StaticArray(LibC::Char, 256)
      is_default : Void
      native_data_format_count : Void
      native_data_formats : StaticArray(DeviceInfoNativeDataFormat, 64)
    end

    struct DeviceInfoNativeDataFormat
      format : Void
      channels : Void
      sample_rate : Void
      flags : Void
    end

    struct DeviceDescriptor
      p_device_id : Pointer(Void)
      share_mode : Void
      format : Void
      channels : Void
      sample_rate : Void
      channel_map : StaticArray(Void, 254)
      period_size_in_frames : Void
      period_size_in_milliseconds : Void
      period_count : Void
    end

    struct ContextCommandWasapi
      code : LibC::Int
      p_event : Pointer(Void)
      data : ContextCommandWasapiData
    end

    union ContextCommandWasapiData
      quit : ContextCommandWasapiDataQuit
      create_audio_client : ContextCommandWasapiDataCreateAudioClient
      release_audio_client : ContextCommandWasapiDataReleaseAudioClient
    end

    struct ContextCommandWasapiDataQuit
      _unused : LibC::Int
    end

    struct ContextCommandWasapiDataCreateAudioClient
      device_type : Void
      p_audio_client : Pointer(Void)
      pp_audio_client_service : Pointer(Pointer(Void))
      p_result : Pointer(Void)
    end

    struct ContextCommandWasapiDataReleaseAudioClient
      p_device : Pointer(Void)
      device_type : Void
    end

    fun context_config_init = ma_context_config_init
    fun context_init = ma_context_init(backends : Pointer(Void), backend_count : Void, p_config : Pointer(Void), p_context : Pointer(Void))
    fun context_uninit = ma_context_uninit(p_context : Pointer(Void))
    fun context_sizeof = ma_context_sizeof
    fun context_get_log = ma_context_get_log(p_context : Pointer(Void)) : Pointer(Void)
    fun context_enumerate_devices = ma_context_enumerate_devices(p_context : Pointer(Void), callback : Void, p_user_data : Pointer(Void))
    fun context_get_devices = ma_context_get_devices(p_context : Pointer(Void), pp_playback_device_infos : Pointer(Pointer(Void)), p_playback_device_count : Pointer(Void), pp_capture_device_infos : Pointer(Pointer(Void)), p_capture_device_count : Pointer(Void))
    fun context_get_device_info = ma_context_get_device_info(p_context : Pointer(Void), device_type : Void, p_device_id : Pointer(Void), p_device_info : Pointer(Void))
    fun context_is_loopback_supported = ma_context_is_loopback_supported(p_context : Pointer(Void))
    fun device_config_init = ma_device_config_init(device_type : Void)
    fun device_init = ma_device_init(p_context : Pointer(Void), p_config : Pointer(Void), p_device : Pointer(Void))
    fun device_init_ex = ma_device_init_ex(backends : Pointer(Void), backend_count : Void, p_context_config : Pointer(Void), p_config : Pointer(Void), p_device : Pointer(Void))
    fun device_uninit = ma_device_uninit(p_device : Pointer(Void))
    fun device_get_context = ma_device_get_context(p_device : Pointer(Void)) : Pointer(Void)
    fun device_get_log = ma_device_get_log(p_device : Pointer(Void)) : Pointer(Void)
    fun device_get_info = ma_device_get_info(p_device : Pointer(Void), type : Void, p_device_info : Pointer(Void))
    fun device_get_name = ma_device_get_name(p_device : Pointer(Void), type : Void, p_name : Pointer(LibC::Char), name_cap : Void, p_length_not_including_null_terminator : Pointer(Void))
    fun device_start = ma_device_start(p_device : Pointer(Void))
    fun device_stop = ma_device_stop(p_device : Pointer(Void))
    fun device_is_started = ma_device_is_started(p_device : Pointer(Void))
    fun device_get_state = ma_device_get_state(p_device : Pointer(Void))
    fun device_post_init = ma_device_post_init(p_device : Pointer(Void), device_type : Void, p_playback_descriptor : Pointer(Void), p_capture_descriptor : Pointer(Void))
    fun device_set_master_volume = ma_device_set_master_volume(p_device : Pointer(Void), volume : LibC::Float)
    fun device_get_master_volume = ma_device_get_master_volume(p_device : Pointer(Void), p_volume : Pointer(LibC::Float))
    fun device_set_master_volume_db = ma_device_set_master_volume_db(p_device : Pointer(Void), gain_db : LibC::Float)
    fun device_get_master_volume_db = ma_device_get_master_volume_db(p_device : Pointer(Void), p_gain_db : Pointer(LibC::Float))
    fun device_handle_backend_data_callback = ma_device_handle_backend_data_callback(p_device : Pointer(Void), p_output : Pointer(Void), p_input : Pointer(Void), frame_count : Void)
    fun calculate_buffer_size_in_frames_from_descriptor = ma_calculate_buffer_size_in_frames_from_descriptor(p_descriptor : Pointer(Void), native_sample_rate : Void, performance_profile : Void)
    fun get_backend_name = ma_get_backend_name(backend : Void) : Pointer(LibC::Char)
    fun get_backend_from_name = ma_get_backend_from_name(p_backend_name : Pointer(LibC::Char), p_backend : Pointer(Void))
    fun is_backend_enabled = ma_is_backend_enabled(backend : Void)
    fun get_enabled_backends = ma_get_enabled_backends(p_backends : Pointer(Void), backend_cap : Void, p_backend_count : Pointer(Void))
    fun is_loopback_supported = ma_is_loopback_supported(backend : Void)
    fun calculate_buffer_size_in_milliseconds_from_frames = ma_calculate_buffer_size_in_milliseconds_from_frames(buffer_size_in_frames : Void, sample_rate : Void)
    fun calculate_buffer_size_in_frames_from_milliseconds = ma_calculate_buffer_size_in_frames_from_milliseconds(buffer_size_in_milliseconds : Void, sample_rate : Void)
    fun copy_pcm_frames = ma_copy_pcm_frames(dst : Pointer(Void), src : Pointer(Void), frame_count : Void, format : Void, channels : Void)
    fun silence_pcm_frames = ma_silence_pcm_frames(p : Pointer(Void), frame_count : Void, format : Void, channels : Void)
    fun offset_pcm_frames_ptr = ma_offset_pcm_frames_ptr(p : Pointer(Void), offset_in_frames : Void, format : Void, channels : Void) : Pointer(Void)
    fun offset_pcm_frames_const_ptr = ma_offset_pcm_frames_const_ptr(p : Pointer(Void), offset_in_frames : Void, format : Void, channels : Void) : Pointer(Void)
    fun offset_pcm_frames_ptr_f32 = ma_offset_pcm_frames_ptr_f32(p : Pointer(LibC::Float), offset_in_frames : Void, channels : Void) : Pointer(LibC::Float)
    fun offset_pcm_frames_const_ptr_f32 = ma_offset_pcm_frames_const_ptr_f32(p : Pointer(LibC::Float), offset_in_frames : Void, channels : Void) : Pointer(LibC::Float)
    fun clip_samples_u8 = ma_clip_samples_u8(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void)
    fun clip_samples_s16 = ma_clip_samples_s16(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void)
    fun clip_samples_s24 = ma_clip_samples_s24(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void)
    fun clip_samples_s32 = ma_clip_samples_s32(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void)
    fun clip_samples_f32 = ma_clip_samples_f32(p_dst : Pointer(LibC::Float), p_src : Pointer(LibC::Float), count : Void)
    fun clip_pcm_frames = ma_clip_pcm_frames(p_dst : Pointer(Void), p_src : Pointer(Void), frame_count : Void, format : Void, channels : Void)
    fun copy_and_apply_volume_factor_u8 = ma_copy_and_apply_volume_factor_u8(p_samples_out : Pointer(Void), p_samples_in : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_s16 = ma_copy_and_apply_volume_factor_s16(p_samples_out : Pointer(Void), p_samples_in : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_s24 = ma_copy_and_apply_volume_factor_s24(p_samples_out : Pointer(Void), p_samples_in : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_s32 = ma_copy_and_apply_volume_factor_s32(p_samples_out : Pointer(Void), p_samples_in : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_f32 = ma_copy_and_apply_volume_factor_f32(p_samples_out : Pointer(LibC::Float), p_samples_in : Pointer(LibC::Float), sample_count : Void, factor : LibC::Float)
    fun apply_volume_factor_u8 = ma_apply_volume_factor_u8(p_samples : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun apply_volume_factor_s16 = ma_apply_volume_factor_s16(p_samples : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun apply_volume_factor_s24 = ma_apply_volume_factor_s24(p_samples : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun apply_volume_factor_s32 = ma_apply_volume_factor_s32(p_samples : Pointer(Void), sample_count : Void, factor : LibC::Float)
    fun apply_volume_factor_f32 = ma_apply_volume_factor_f32(p_samples : Pointer(LibC::Float), sample_count : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_pcm_frames_u8 = ma_copy_and_apply_volume_factor_pcm_frames_u8(p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_pcm_frames_s16 = ma_copy_and_apply_volume_factor_pcm_frames_s16(p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_pcm_frames_s24 = ma_copy_and_apply_volume_factor_pcm_frames_s24(p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_pcm_frames_s32 = ma_copy_and_apply_volume_factor_pcm_frames_s32(p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_pcm_frames_f32 = ma_copy_and_apply_volume_factor_pcm_frames_f32(p_frames_out : Pointer(LibC::Float), p_frames_in : Pointer(LibC::Float), frame_count : Void, channels : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_pcm_frames = ma_copy_and_apply_volume_factor_pcm_frames(p_frames_out : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void, format : Void, channels : Void, factor : LibC::Float)
    fun apply_volume_factor_pcm_frames_u8 = ma_apply_volume_factor_pcm_frames_u8(p_frames : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun apply_volume_factor_pcm_frames_s16 = ma_apply_volume_factor_pcm_frames_s16(p_frames : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun apply_volume_factor_pcm_frames_s24 = ma_apply_volume_factor_pcm_frames_s24(p_frames : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun apply_volume_factor_pcm_frames_s32 = ma_apply_volume_factor_pcm_frames_s32(p_frames : Pointer(Void), frame_count : Void, channels : Void, factor : LibC::Float)
    fun apply_volume_factor_pcm_frames_f32 = ma_apply_volume_factor_pcm_frames_f32(p_frames : Pointer(LibC::Float), frame_count : Void, channels : Void, factor : LibC::Float)
    fun apply_volume_factor_pcm_frames = ma_apply_volume_factor_pcm_frames(p_frames : Pointer(Void), frame_count : Void, format : Void, channels : Void, factor : LibC::Float)
    fun copy_and_apply_volume_factor_per_channel_f32 = ma_copy_and_apply_volume_factor_per_channel_f32(p_frames_out : Pointer(LibC::Float), p_frames_in : Pointer(LibC::Float), frame_count : Void, channels : Void, p_channel_gains : Pointer(LibC::Float))
    fun copy_and_apply_volume_and_clip_samples_u8 = ma_copy_and_apply_volume_and_clip_samples_u8(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void, volume : LibC::Float)
    fun copy_and_apply_volume_and_clip_samples_s16 = ma_copy_and_apply_volume_and_clip_samples_s16(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void, volume : LibC::Float)
    fun copy_and_apply_volume_and_clip_samples_s24 = ma_copy_and_apply_volume_and_clip_samples_s24(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void, volume : LibC::Float)
    fun copy_and_apply_volume_and_clip_samples_s32 = ma_copy_and_apply_volume_and_clip_samples_s32(p_dst : Pointer(Void), p_src : Pointer(Void), count : Void, volume : LibC::Float)
    fun copy_and_apply_volume_and_clip_samples_f32 = ma_copy_and_apply_volume_and_clip_samples_f32(p_dst : Pointer(LibC::Float), p_src : Pointer(LibC::Float), count : Void, volume : LibC::Float)
    fun copy_and_apply_volume_and_clip_pcm_frames = ma_copy_and_apply_volume_and_clip_pcm_frames(p_dst : Pointer(Void), p_src : Pointer(Void), frame_count : Void, format : Void, channels : Void, volume : LibC::Float)
    fun volume_linear_to_db = ma_volume_linear_to_db(factor : LibC::Float) : LibC::Float
    fun volume_db_to_linear = ma_volume_db_to_linear(gain : LibC::Float) : LibC::Float
    fun mix_pcm_frames_f32 = ma_mix_pcm_frames_f32(p_dst : Pointer(LibC::Float), p_src : Pointer(LibC::Float), frame_count : Void, channels : Void, volume : LibC::Float)

    struct FileInfo
      size_in_bytes : Void
    end

    struct VfsCallbacks
      on_open : (Pointer(Void), Pointer(LibC::Char), Void, Pointer(Void) -> Void)
      on_open_w : (Pointer(Void), Pointer(Void), Void, Pointer(Void) -> Void)
      on_close : (Pointer(Void), Void -> Void)
      on_read : (Pointer(Void), Void, Pointer(Void), Void, Pointer(Void) -> Void)
      on_write : (Pointer(Void), Void, Pointer(Void), Void, Pointer(Void) -> Void)
      on_seek : (Pointer(Void), Void, Void, Void -> Void)
      on_tell : (Pointer(Void), Void, Pointer(Void) -> Void)
      on_info : (Pointer(Void), Void, Pointer(Void) -> Void)
    end

    fun vfs_open = ma_vfs_open(p_vfs : Pointer(Void), p_file_path : Pointer(LibC::Char), open_mode : Void, p_file : Pointer(Void))
    fun vfs_open_w = ma_vfs_open_w(p_vfs : Pointer(Void), p_file_path : Pointer(Void), open_mode : Void, p_file : Pointer(Void))
    fun vfs_close = ma_vfs_close(p_vfs : Pointer(Void), file : Void)
    fun vfs_read = ma_vfs_read(p_vfs : Pointer(Void), file : Void, p_dst : Pointer(Void), size_in_bytes : Void, p_bytes_read : Pointer(Void))
    fun vfs_write = ma_vfs_write(p_vfs : Pointer(Void), file : Void, p_src : Pointer(Void), size_in_bytes : Void, p_bytes_written : Pointer(Void))
    fun vfs_seek = ma_vfs_seek(p_vfs : Pointer(Void), file : Void, offset : Void, origin : Void)
    fun vfs_tell = ma_vfs_tell(p_vfs : Pointer(Void), file : Void, p_cursor : Pointer(Void))
    fun vfs_info = ma_vfs_info(p_vfs : Pointer(Void), file : Void, p_info : Pointer(Void))
    fun vfs_open_and_read_file = ma_vfs_open_and_read_file(p_vfs : Pointer(Void), p_file_path : Pointer(LibC::Char), pp_data : Pointer(Pointer(Void)), p_size : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct DefaultVfs
      cb : Void
      allocation_callbacks : Void
    end

    fun default_vfs_init = ma_default_vfs_init(p_vfs : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct Decoder
      ds : Void
      p_backend : Pointer(Void)
      p_backend_v_table : Pointer(Void)
      p_backend_user_data : Pointer(Void)
      on_read : Void
      on_seek : Void
      on_tell : Void
      p_user_data : Pointer(Void)
      read_pointer_in_pcm_frames : Void
      output_format : Void
      output_channels : Void
      output_sample_rate : Void
      converter : Void
      p_input_cache : Pointer(Void)
      input_cache_cap : Void
      input_cache_consumed : Void
      input_cache_remaining : Void
      allocation_callbacks : Void
      data : DecoderData
    end

    union DecoderData
      vfs : DecoderDataVfs
      memory : DecoderDataMemory
    end

    struct DecoderDataVfs
      p_vfs : Pointer(Void)
      file : Void
    end

    struct DecoderDataMemory
      p_data : Pointer(Void)
      data_size : Void
      current_read_pos : Void
    end

    struct DecodingBackendConfig
      preferred_format : Void
      seek_point_count : Void
    end

    fun decoding_backend_config_init = ma_decoding_backend_config_init(preferred_format : Void, seek_point_count : Void)

    struct DecodingBackendVtable
      on_init : (Pointer(Void), Void, Void, Void, Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Pointer(Void)) -> Void)
      on_init_file : (Pointer(Void), Pointer(LibC::Char), Pointer(Void), Pointer(Void), Pointer(Pointer(Void)) -> Void)
      on_init_file_w : (Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Void), Pointer(Pointer(Void)) -> Void)
      on_init_memory : (Pointer(Void), Pointer(Void), Void, Pointer(Void), Pointer(Void), Pointer(Pointer(Void)) -> Void)
      on_uninit : (Pointer(Void), Pointer(Void), Pointer(Void) -> Void)
    end

    struct DecoderConfig
      format : Void
      channels : Void
      sample_rate : Void
      p_channel_map : Pointer(Void)
      channel_mix_mode : Void
      dither_mode : Void
      resampling : Void
      allocation_callbacks : Void
      encoding_format : Void
      seek_point_count : Void
      pp_custom_backend_v_tables : Pointer(Pointer(Void))
      custom_backend_count : Void
      p_custom_backend_user_data : Pointer(Void)
    end

    fun decoder_config_init = ma_decoder_config_init(output_format : Void, output_channels : Void, output_sample_rate : Void)
    fun decoder_config_init_default = ma_decoder_config_init_default
    fun decoder_init = ma_decoder_init(on_read : Void, on_seek : Void, p_user_data : Pointer(Void), p_config : Pointer(Void), p_decoder : Pointer(Void))
    fun decoder_init_memory = ma_decoder_init_memory(p_data : Pointer(Void), data_size : Void, p_config : Pointer(Void), p_decoder : Pointer(Void))
    fun decoder_init_vfs = ma_decoder_init_vfs(p_vfs : Pointer(Void), p_file_path : Pointer(LibC::Char), p_config : Pointer(Void), p_decoder : Pointer(Void))
    fun decoder_init_vfs_w = ma_decoder_init_vfs_w(p_vfs : Pointer(Void), p_file_path : Pointer(Void), p_config : Pointer(Void), p_decoder : Pointer(Void))
    fun decoder_init_file = ma_decoder_init_file(p_file_path : Pointer(LibC::Char), p_config : Pointer(Void), p_decoder : Pointer(Void))
    fun decoder_init_file_w = ma_decoder_init_file_w(p_file_path : Pointer(Void), p_config : Pointer(Void), p_decoder : Pointer(Void))
    fun decoder_uninit = ma_decoder_uninit(p_decoder : Pointer(Void))
    fun decoder_read_pcm_frames = ma_decoder_read_pcm_frames(p_decoder : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun decoder_seek_to_pcm_frame = ma_decoder_seek_to_pcm_frame(p_decoder : Pointer(Void), frame_index : Void)
    fun decoder_get_data_format = ma_decoder_get_data_format(p_decoder : Pointer(Void), p_format : Pointer(Void), p_channels : Pointer(Void), p_sample_rate : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun decoder_get_cursor_in_pcm_frames = ma_decoder_get_cursor_in_pcm_frames(p_decoder : Pointer(Void), p_cursor : Pointer(Void))
    fun decoder_get_length_in_pcm_frames = ma_decoder_get_length_in_pcm_frames(p_decoder : Pointer(Void), p_length : Pointer(Void))
    fun decoder_get_available_frames = ma_decoder_get_available_frames(p_decoder : Pointer(Void), p_available_frames : Pointer(Void))
    fun decode_from_vfs = ma_decode_from_vfs(p_vfs : Pointer(Void), p_file_path : Pointer(LibC::Char), p_config : Pointer(Void), p_frame_count_out : Pointer(Void), pp_pcm_frames_out : Pointer(Pointer(Void)))
    fun decode_file = ma_decode_file(p_file_path : Pointer(LibC::Char), p_config : Pointer(Void), p_frame_count_out : Pointer(Void), pp_pcm_frames_out : Pointer(Pointer(Void)))
    fun decode_memory = ma_decode_memory(p_data : Pointer(Void), data_size : Void, p_config : Pointer(Void), p_frame_count_out : Pointer(Void), pp_pcm_frames_out : Pointer(Pointer(Void)))

    struct Encoder
      config : Void
      on_write : Void
      on_seek : Void
      on_init : Void
      on_uninit : Void
      on_write_pcm_frames : Void
      p_user_data : Pointer(Void)
      p_internal_encoder : Pointer(Void)
      data : EncoderData
    end

    union EncoderData
      vfs : EncoderDataVfs
    end

    struct EncoderDataVfs
      p_vfs : Pointer(Void)
      file : Void
    end

    struct EncoderConfig
      encoding_format : Void
      format : Void
      channels : Void
      sample_rate : Void
      allocation_callbacks : Void
    end

    fun encoder_config_init = ma_encoder_config_init(encoding_format : Void, format : Void, channels : Void, sample_rate : Void)
    fun encoder_init = ma_encoder_init(on_write : Void, on_seek : Void, p_user_data : Pointer(Void), p_config : Pointer(Void), p_encoder : Pointer(Void))
    fun encoder_init_vfs = ma_encoder_init_vfs(p_vfs : Pointer(Void), p_file_path : Pointer(LibC::Char), p_config : Pointer(Void), p_encoder : Pointer(Void))
    fun encoder_init_vfs_w = ma_encoder_init_vfs_w(p_vfs : Pointer(Void), p_file_path : Pointer(Void), p_config : Pointer(Void), p_encoder : Pointer(Void))
    fun encoder_init_file = ma_encoder_init_file(p_file_path : Pointer(LibC::Char), p_config : Pointer(Void), p_encoder : Pointer(Void))
    fun encoder_init_file_w = ma_encoder_init_file_w(p_file_path : Pointer(Void), p_config : Pointer(Void), p_encoder : Pointer(Void))
    fun encoder_uninit = ma_encoder_uninit(p_encoder : Pointer(Void))
    fun encoder_write_pcm_frames = ma_encoder_write_pcm_frames(p_encoder : Pointer(Void), p_frames_in : Pointer(Void), frame_count : Void, p_frames_written : Pointer(Void))

    struct WaveformConfig
      format : Void
      channels : Void
      sample_rate : Void
      type : Void
      amplitude : LibC::Double
      frequency : LibC::Double
    end

    fun waveform_config_init = ma_waveform_config_init(format : Void, channels : Void, sample_rate : Void, type : Void, amplitude : LibC::Double, frequency : LibC::Double)

    struct Waveform
      ds : Void
      config : Void
      advance : LibC::Double
      time : LibC::Double
    end

    fun waveform_init = ma_waveform_init(p_config : Pointer(Void), p_waveform : Pointer(Void))
    fun waveform_uninit = ma_waveform_uninit(p_waveform : Pointer(Void))
    fun waveform_read_pcm_frames = ma_waveform_read_pcm_frames(p_waveform : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun waveform_seek_to_pcm_frame = ma_waveform_seek_to_pcm_frame(p_waveform : Pointer(Void), frame_index : Void)
    fun waveform_set_amplitude = ma_waveform_set_amplitude(p_waveform : Pointer(Void), amplitude : LibC::Double)
    fun waveform_set_frequency = ma_waveform_set_frequency(p_waveform : Pointer(Void), frequency : LibC::Double)
    fun waveform_set_type = ma_waveform_set_type(p_waveform : Pointer(Void), type : Void)
    fun waveform_set_sample_rate = ma_waveform_set_sample_rate(p_waveform : Pointer(Void), sample_rate : Void)

    struct PulsewaveConfig
      format : Void
      channels : Void
      sample_rate : Void
      duty_cycle : LibC::Double
      amplitude : LibC::Double
      frequency : LibC::Double
    end

    fun pulsewave_config_init = ma_pulsewave_config_init(format : Void, channels : Void, sample_rate : Void, duty_cycle : LibC::Double, amplitude : LibC::Double, frequency : LibC::Double)

    struct Pulsewave
      waveform : Void
      config : Void
    end

    fun pulsewave_init = ma_pulsewave_init(p_config : Pointer(Void), p_waveform : Pointer(Void))
    fun pulsewave_uninit = ma_pulsewave_uninit(p_waveform : Pointer(Void))
    fun pulsewave_read_pcm_frames = ma_pulsewave_read_pcm_frames(p_waveform : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun pulsewave_seek_to_pcm_frame = ma_pulsewave_seek_to_pcm_frame(p_waveform : Pointer(Void), frame_index : Void)
    fun pulsewave_set_amplitude = ma_pulsewave_set_amplitude(p_waveform : Pointer(Void), amplitude : LibC::Double)
    fun pulsewave_set_frequency = ma_pulsewave_set_frequency(p_waveform : Pointer(Void), frequency : LibC::Double)
    fun pulsewave_set_sample_rate = ma_pulsewave_set_sample_rate(p_waveform : Pointer(Void), sample_rate : Void)
    fun pulsewave_set_duty_cycle = ma_pulsewave_set_duty_cycle(p_waveform : Pointer(Void), duty_cycle : LibC::Double)

    struct NoiseConfig
      format : Void
      channels : Void
      type : Void
      seed : Void
      amplitude : LibC::Double
      duplicate_channels : Void
    end

    fun noise_config_init = ma_noise_config_init(format : Void, channels : Void, type : Void, seed : Void, amplitude : LibC::Double)

    struct Noise
      ds : Void
      config : Void
      lcg : Void
      state : NoiseState
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    union NoiseState
      pink : NoiseStatePink
      brownian : NoiseStateBrownian
    end

    struct NoiseStatePink
      bin : Pointer(Pointer(LibC::Double))
      accumulation : Pointer(LibC::Double)
      counter : Pointer(Void)
    end

    struct NoiseStateBrownian
      accumulation : Pointer(LibC::Double)
    end

    fun noise_get_heap_size = ma_noise_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun noise_init_preallocated = ma_noise_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_noise : Pointer(Void))
    fun noise_init = ma_noise_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_noise : Pointer(Void))
    fun noise_uninit = ma_noise_uninit(p_noise : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun noise_read_pcm_frames = ma_noise_read_pcm_frames(p_noise : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun noise_set_amplitude = ma_noise_set_amplitude(p_noise : Pointer(Void), amplitude : LibC::Double)
    fun noise_set_seed = ma_noise_set_seed(p_noise : Pointer(Void), seed : Void)
    fun noise_set_type = ma_noise_set_type(p_noise : Pointer(Void), type : Void)

    struct ResourceManager
      config : Void
      p_root_data_buffer_node : Pointer(Void)
      data_buffer_bst_lock : Void
      job_threads : StaticArray(Void, 64)
      job_queue : Void
      default_vfs : Void
      log : Void
    end

    struct ResourceManagerDataBufferNode
      hashed_name32 : Void
      ref_count : Void
      result : Void
      execution_counter : Void
      execution_pointer : Void
      is_data_owned_by_resource_manager : Void
      data : Void
      p_parent : Pointer(Void)
      p_child_lo : Pointer(Void)
      p_child_hi : Pointer(Void)
    end

    struct ResourceManagerDataBuffer
      ds : Void
      p_resource_manager : Pointer(Void)
      p_node : Pointer(Void)
      flags : Void
      execution_counter : Void
      execution_pointer : Void
      seek_target_in_pcm_frames : Void
      seek_to_cursor_on_next_read : Void
      result : Void
      is_looping : Void
      is_connector_initialized : Void
      connector : ResourceManagerDataBufferNodeConnector
    end

    union ResourceManagerDataBufferNodeConnector
      decoder : Void
      buffer : Void
      paged_buffer : Void
    end

    struct ResourceManagerDataStream
      ds : Void
      p_resource_manager : Pointer(Void)
      flags : Void
      decoder : Void
      is_decoder_initialized : Void
      total_length_in_pcm_frames : Void
      relative_cursor : Void
      absolute_cursor : Void
      current_page_index : Void
      execution_counter : Void
      execution_pointer : Void
      is_looping : Void
      p_page_data : Pointer(Void)
      page_frame_count : StaticArray(Void, 2)
      result : Void
      is_decoder_at_end : Void
      is_page_valid : StaticArray(Void, 2)
      seek_counter : Void
    end

    struct ResourceManagerDataSource
      backend : ResourceManagerDataSourceBackend
      flags : Void
      execution_counter : Void
      execution_pointer : Void
    end

    union ResourceManagerDataSourceBackend
      buffer : Void
      stream : Void
    end

    struct ResourceManagerPipelineStageNotification
      p_notification : Pointer(Void)
      p_fence : Pointer(Void)
    end

    struct ResourceManagerPipelineNotifications
      init : Void
      done : Void
    end

    fun resource_manager_pipeline_notifications_init = ma_resource_manager_pipeline_notifications_init

    struct ResourceManagerDataSourceConfig
      p_file_path : Pointer(LibC::Char)
      p_file_path_w : Pointer(Void)
      p_notifications : Pointer(Void)
      initial_seek_point_in_pcm_frames : Void
      range_beg_in_pcm_frames : Void
      range_end_in_pcm_frames : Void
      loop_point_beg_in_pcm_frames : Void
      loop_point_end_in_pcm_frames : Void
      flags : Void
      is_looping : Void
    end

    fun resource_manager_data_source_config_init = ma_resource_manager_data_source_config_init

    struct ResourceManagerDataSupply
      type : Void
      backend : ResourceManagerDataSupplyBackend
    end

    union ResourceManagerDataSupplyBackend
      encoded : ResourceManagerDataSupplyBackendEncoded
      decoded : ResourceManagerDataSupplyBackendDecoded
      decoded_paged : ResourceManagerDataSupplyBackendDecodedPaged
    end

    struct ResourceManagerDataSupplyBackendEncoded
      p_data : Pointer(Void)
      size_in_bytes : Void
    end

    struct ResourceManagerDataSupplyBackendDecoded
      p_data : Pointer(Void)
      total_frame_count : Void
      decoded_frame_count : Void
      format : Void
      channels : Void
      sample_rate : Void
    end

    struct ResourceManagerDataSupplyBackendDecodedPaged
      data : Void
      decoded_frame_count : Void
      sample_rate : Void
    end

    struct ResourceManagerConfig
      allocation_callbacks : Void
      p_log : Pointer(Void)
      decoded_format : Void
      decoded_channels : Void
      decoded_sample_rate : Void
      job_thread_count : Void
      job_thread_stack_size : Void
      job_queue_capacity : Void
      flags : Void
      p_vfs : Pointer(Void)
      pp_custom_decoding_backend_v_tables : Pointer(Pointer(Void))
      custom_decoding_backend_count : Void
      p_custom_decoding_backend_user_data : Pointer(Void)
    end

    fun resource_manager_config_init = ma_resource_manager_config_init
    fun resource_manager_init = ma_resource_manager_init(p_config : Pointer(Void), p_resource_manager : Pointer(Void))
    fun resource_manager_uninit = ma_resource_manager_uninit(p_resource_manager : Pointer(Void))
    fun resource_manager_get_log = ma_resource_manager_get_log(p_resource_manager : Pointer(Void)) : Pointer(Void)
    fun resource_manager_register_file = ma_resource_manager_register_file(p_resource_manager : Pointer(Void), p_file_path : Pointer(LibC::Char), flags : Void)
    fun resource_manager_register_file_w = ma_resource_manager_register_file_w(p_resource_manager : Pointer(Void), p_file_path : Pointer(Void), flags : Void)
    fun resource_manager_register_decoded_data = ma_resource_manager_register_decoded_data(p_resource_manager : Pointer(Void), p_name : Pointer(LibC::Char), p_data : Pointer(Void), frame_count : Void, format : Void, channels : Void, sample_rate : Void)
    fun resource_manager_register_decoded_data_w = ma_resource_manager_register_decoded_data_w(p_resource_manager : Pointer(Void), p_name : Pointer(Void), p_data : Pointer(Void), frame_count : Void, format : Void, channels : Void, sample_rate : Void)
    fun resource_manager_register_encoded_data = ma_resource_manager_register_encoded_data(p_resource_manager : Pointer(Void), p_name : Pointer(LibC::Char), p_data : Pointer(Void), size_in_bytes : Void)
    fun resource_manager_register_encoded_data_w = ma_resource_manager_register_encoded_data_w(p_resource_manager : Pointer(Void), p_name : Pointer(Void), p_data : Pointer(Void), size_in_bytes : Void)
    fun resource_manager_unregister_file = ma_resource_manager_unregister_file(p_resource_manager : Pointer(Void), p_file_path : Pointer(LibC::Char))
    fun resource_manager_unregister_file_w = ma_resource_manager_unregister_file_w(p_resource_manager : Pointer(Void), p_file_path : Pointer(Void))
    fun resource_manager_unregister_data = ma_resource_manager_unregister_data(p_resource_manager : Pointer(Void), p_name : Pointer(LibC::Char))
    fun resource_manager_unregister_data_w = ma_resource_manager_unregister_data_w(p_resource_manager : Pointer(Void), p_name : Pointer(Void))
    fun resource_manager_data_buffer_init_ex = ma_resource_manager_data_buffer_init_ex(p_resource_manager : Pointer(Void), p_config : Pointer(Void), p_data_buffer : Pointer(Void))
    fun resource_manager_data_buffer_init = ma_resource_manager_data_buffer_init(p_resource_manager : Pointer(Void), p_file_path : Pointer(LibC::Char), flags : Void, p_notifications : Pointer(Void), p_data_buffer : Pointer(Void))
    fun resource_manager_data_buffer_init_w = ma_resource_manager_data_buffer_init_w(p_resource_manager : Pointer(Void), p_file_path : Pointer(Void), flags : Void, p_notifications : Pointer(Void), p_data_buffer : Pointer(Void))
    fun resource_manager_data_buffer_init_copy = ma_resource_manager_data_buffer_init_copy(p_resource_manager : Pointer(Void), p_existing_data_buffer : Pointer(Void), p_data_buffer : Pointer(Void))
    fun resource_manager_data_buffer_uninit = ma_resource_manager_data_buffer_uninit(p_data_buffer : Pointer(Void))
    fun resource_manager_data_buffer_read_pcm_frames = ma_resource_manager_data_buffer_read_pcm_frames(p_data_buffer : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun resource_manager_data_buffer_seek_to_pcm_frame = ma_resource_manager_data_buffer_seek_to_pcm_frame(p_data_buffer : Pointer(Void), frame_index : Void)
    fun resource_manager_data_buffer_get_data_format = ma_resource_manager_data_buffer_get_data_format(p_data_buffer : Pointer(Void), p_format : Pointer(Void), p_channels : Pointer(Void), p_sample_rate : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun resource_manager_data_buffer_get_cursor_in_pcm_frames = ma_resource_manager_data_buffer_get_cursor_in_pcm_frames(p_data_buffer : Pointer(Void), p_cursor : Pointer(Void))
    fun resource_manager_data_buffer_get_length_in_pcm_frames = ma_resource_manager_data_buffer_get_length_in_pcm_frames(p_data_buffer : Pointer(Void), p_length : Pointer(Void))
    fun resource_manager_data_buffer_result = ma_resource_manager_data_buffer_result(p_data_buffer : Pointer(Void))
    fun resource_manager_data_buffer_set_looping = ma_resource_manager_data_buffer_set_looping(p_data_buffer : Pointer(Void), is_looping : Void)
    fun resource_manager_data_buffer_is_looping = ma_resource_manager_data_buffer_is_looping(p_data_buffer : Pointer(Void))
    fun resource_manager_data_buffer_get_available_frames = ma_resource_manager_data_buffer_get_available_frames(p_data_buffer : Pointer(Void), p_available_frames : Pointer(Void))
    fun resource_manager_data_stream_init_ex = ma_resource_manager_data_stream_init_ex(p_resource_manager : Pointer(Void), p_config : Pointer(Void), p_data_stream : Pointer(Void))
    fun resource_manager_data_stream_init = ma_resource_manager_data_stream_init(p_resource_manager : Pointer(Void), p_file_path : Pointer(LibC::Char), flags : Void, p_notifications : Pointer(Void), p_data_stream : Pointer(Void))
    fun resource_manager_data_stream_init_w = ma_resource_manager_data_stream_init_w(p_resource_manager : Pointer(Void), p_file_path : Pointer(Void), flags : Void, p_notifications : Pointer(Void), p_data_stream : Pointer(Void))
    fun resource_manager_data_stream_uninit = ma_resource_manager_data_stream_uninit(p_data_stream : Pointer(Void))
    fun resource_manager_data_stream_read_pcm_frames = ma_resource_manager_data_stream_read_pcm_frames(p_data_stream : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun resource_manager_data_stream_seek_to_pcm_frame = ma_resource_manager_data_stream_seek_to_pcm_frame(p_data_stream : Pointer(Void), frame_index : Void)
    fun resource_manager_data_stream_get_data_format = ma_resource_manager_data_stream_get_data_format(p_data_stream : Pointer(Void), p_format : Pointer(Void), p_channels : Pointer(Void), p_sample_rate : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun resource_manager_data_stream_get_cursor_in_pcm_frames = ma_resource_manager_data_stream_get_cursor_in_pcm_frames(p_data_stream : Pointer(Void), p_cursor : Pointer(Void))
    fun resource_manager_data_stream_get_length_in_pcm_frames = ma_resource_manager_data_stream_get_length_in_pcm_frames(p_data_stream : Pointer(Void), p_length : Pointer(Void))
    fun resource_manager_data_stream_result = ma_resource_manager_data_stream_result(p_data_stream : Pointer(Void))
    fun resource_manager_data_stream_set_looping = ma_resource_manager_data_stream_set_looping(p_data_stream : Pointer(Void), is_looping : Void)
    fun resource_manager_data_stream_is_looping = ma_resource_manager_data_stream_is_looping(p_data_stream : Pointer(Void))
    fun resource_manager_data_stream_get_available_frames = ma_resource_manager_data_stream_get_available_frames(p_data_stream : Pointer(Void), p_available_frames : Pointer(Void))
    fun resource_manager_data_source_init_ex = ma_resource_manager_data_source_init_ex(p_resource_manager : Pointer(Void), p_config : Pointer(Void), p_data_source : Pointer(Void))
    fun resource_manager_data_source_init = ma_resource_manager_data_source_init(p_resource_manager : Pointer(Void), p_name : Pointer(LibC::Char), flags : Void, p_notifications : Pointer(Void), p_data_source : Pointer(Void))
    fun resource_manager_data_source_init_w = ma_resource_manager_data_source_init_w(p_resource_manager : Pointer(Void), p_name : Pointer(Void), flags : Void, p_notifications : Pointer(Void), p_data_source : Pointer(Void))
    fun resource_manager_data_source_init_copy = ma_resource_manager_data_source_init_copy(p_resource_manager : Pointer(Void), p_existing_data_source : Pointer(Void), p_data_source : Pointer(Void))
    fun resource_manager_data_source_uninit = ma_resource_manager_data_source_uninit(p_data_source : Pointer(Void))
    fun resource_manager_data_source_read_pcm_frames = ma_resource_manager_data_source_read_pcm_frames(p_data_source : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun resource_manager_data_source_seek_to_pcm_frame = ma_resource_manager_data_source_seek_to_pcm_frame(p_data_source : Pointer(Void), frame_index : Void)
    fun resource_manager_data_source_get_data_format = ma_resource_manager_data_source_get_data_format(p_data_source : Pointer(Void), p_format : Pointer(Void), p_channels : Pointer(Void), p_sample_rate : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun resource_manager_data_source_get_cursor_in_pcm_frames = ma_resource_manager_data_source_get_cursor_in_pcm_frames(p_data_source : Pointer(Void), p_cursor : Pointer(Void))
    fun resource_manager_data_source_get_length_in_pcm_frames = ma_resource_manager_data_source_get_length_in_pcm_frames(p_data_source : Pointer(Void), p_length : Pointer(Void))
    fun resource_manager_data_source_result = ma_resource_manager_data_source_result(p_data_source : Pointer(Void))
    fun resource_manager_data_source_set_looping = ma_resource_manager_data_source_set_looping(p_data_source : Pointer(Void), is_looping : Void)
    fun resource_manager_data_source_is_looping = ma_resource_manager_data_source_is_looping(p_data_source : Pointer(Void))
    fun resource_manager_data_source_get_available_frames = ma_resource_manager_data_source_get_available_frames(p_data_source : Pointer(Void), p_available_frames : Pointer(Void))
    fun resource_manager_post_job = ma_resource_manager_post_job(p_resource_manager : Pointer(Void), p_job : Pointer(Void))
    fun resource_manager_post_job_quit = ma_resource_manager_post_job_quit(p_resource_manager : Pointer(Void))
    fun resource_manager_next_job = ma_resource_manager_next_job(p_resource_manager : Pointer(Void), p_job : Pointer(Void))
    fun resource_manager_process_job = ma_resource_manager_process_job(p_resource_manager : Pointer(Void), p_job : Pointer(Void))
    fun resource_manager_process_next_job = ma_resource_manager_process_next_job(p_resource_manager : Pointer(Void))

    struct Stack
      offset : Void
      size_in_bytes : Void
      _data : StaticArray(UInt8, 1)
    end

    struct NodeGraph
      base : Void
      endpoint : Void
      p_processing_cache : Pointer(LibC::Float)
      processing_cache_frames_remaining : Void
      processing_size_in_frames : Void
      is_reading : Void
      p_pre_mix_stack : Pointer(Void)
    end

    struct NodeVtable
      on_process : (Pointer(Void), Pointer(Pointer(LibC::Float)), Pointer(Void), Pointer(Pointer(LibC::Float)), Pointer(Void) -> Void)
      on_get_required_input_frame_count : (Pointer(Void), Void, Pointer(Void) -> Void)
      input_bus_count : Void
      output_bus_count : Void
      flags : Void
    end

    struct NodeConfig
      vtable : Pointer(Void)
      initial_state : Void
      input_bus_count : Void
      output_bus_count : Void
      p_input_channels : Pointer(Void)
      p_output_channels : Pointer(Void)
    end

    fun node_config_init = ma_node_config_init

    struct NodeOutputBus
      p_node : Pointer(Void)
      output_bus_index : Void
      channels : Void
      input_node_input_bus_index : Void
      flags : Void
      ref_count : Void
      is_attached : Void
      lock : Void
      volume : LibC::Float
      p_next : Pointer(Void)
      p_prev : Pointer(Void)
      p_input_node : Pointer(Void)
    end

    struct NodeInputBus
      head : Void
      next_counter : Void
      lock : Void
      channels : Void
    end

    struct NodeBase
      p_node_graph : Pointer(Void)
      vtable : Pointer(Void)
      input_bus_count : Void
      output_bus_count : Void
      p_input_buses : Pointer(Void)
      p_output_buses : Pointer(Void)
      p_cached_data : Pointer(LibC::Float)
      cached_data_cap_in_frames_per_bus : Void
      cached_frame_count_out : Void
      cached_frame_count_in : Void
      consumed_frame_count_in : Void
      state : Void
      state_times : StaticArray(Void, 2)
      local_time : Void
      _input_buses : StaticArray(Void, 2)
      _output_buses : StaticArray(Void, 2)
      _p_heap : Pointer(Void)
      _owns_heap : Void
    end

    fun node_get_heap_size = ma_node_get_heap_size(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun node_init_preallocated = ma_node_init_preallocated(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_heap : Pointer(Void), p_node : Pointer(Void))
    fun node_init = ma_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun node_uninit = ma_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun node_get_node_graph = ma_node_get_node_graph(p_node : Pointer(Void)) : Pointer(Void)
    fun node_get_input_bus_count = ma_node_get_input_bus_count(p_node : Pointer(Void))
    fun node_get_output_bus_count = ma_node_get_output_bus_count(p_node : Pointer(Void))
    fun node_get_input_channels = ma_node_get_input_channels(p_node : Pointer(Void), input_bus_index : Void)
    fun node_get_output_channels = ma_node_get_output_channels(p_node : Pointer(Void), output_bus_index : Void)
    fun node_attach_output_bus = ma_node_attach_output_bus(p_node : Pointer(Void), output_bus_index : Void, p_other_node : Pointer(Void), other_node_input_bus_index : Void)
    fun node_detach_output_bus = ma_node_detach_output_bus(p_node : Pointer(Void), output_bus_index : Void)
    fun node_detach_all_output_buses = ma_node_detach_all_output_buses(p_node : Pointer(Void))
    fun node_set_output_bus_volume = ma_node_set_output_bus_volume(p_node : Pointer(Void), output_bus_index : Void, volume : LibC::Float)
    fun node_get_output_bus_volume = ma_node_get_output_bus_volume(p_node : Pointer(Void), output_bus_index : Void) : LibC::Float
    fun node_set_state = ma_node_set_state(p_node : Pointer(Void), state : Void)
    fun node_get_state = ma_node_get_state(p_node : Pointer(Void))
    fun node_set_state_time = ma_node_set_state_time(p_node : Pointer(Void), state : Void, global_time : Void)
    fun node_get_state_time = ma_node_get_state_time(p_node : Pointer(Void), state : Void)
    fun node_get_state_by_time = ma_node_get_state_by_time(p_node : Pointer(Void), global_time : Void)
    fun node_get_state_by_time_range = ma_node_get_state_by_time_range(p_node : Pointer(Void), global_time_beg : Void, global_time_end : Void)
    fun node_get_time = ma_node_get_time(p_node : Pointer(Void))
    fun node_set_time = ma_node_set_time(p_node : Pointer(Void), local_time : Void)

    struct NodeGraphConfig
      channels : Void
      processing_size_in_frames : Void
      pre_mix_stack_size_in_bytes : Void
    end

    fun node_graph_config_init = ma_node_graph_config_init(channels : Void)
    fun node_graph_init = ma_node_graph_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node_graph : Pointer(Void))
    fun node_graph_uninit = ma_node_graph_uninit(p_node_graph : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun node_graph_get_endpoint = ma_node_graph_get_endpoint(p_node_graph : Pointer(Void)) : Pointer(Void)
    fun node_graph_read_pcm_frames = ma_node_graph_read_pcm_frames(p_node_graph : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun node_graph_get_channels = ma_node_graph_get_channels(p_node_graph : Pointer(Void))
    fun node_graph_get_time = ma_node_graph_get_time(p_node_graph : Pointer(Void))
    fun node_graph_set_time = ma_node_graph_set_time(p_node_graph : Pointer(Void), global_time : Void)

    struct DataSourceNodeConfig
      node_config : Void
      p_data_source : Pointer(Void)
    end

    fun data_source_node_config_init = ma_data_source_node_config_init(p_data_source : Pointer(Void))

    struct DataSourceNode
      base : Void
      p_data_source : Pointer(Void)
    end

    fun data_source_node_init = ma_data_source_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_data_source_node : Pointer(Void))
    fun data_source_node_uninit = ma_data_source_node_uninit(p_data_source_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun data_source_node_set_looping = ma_data_source_node_set_looping(p_data_source_node : Pointer(Void), is_looping : Void)
    fun data_source_node_is_looping = ma_data_source_node_is_looping(p_data_source_node : Pointer(Void))

    struct SplitterNodeConfig
      node_config : Void
      channels : Void
      output_bus_count : Void
    end

    fun splitter_node_config_init = ma_splitter_node_config_init(channels : Void)

    struct SplitterNode
      base : Void
    end

    fun splitter_node_init = ma_splitter_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_splitter_node : Pointer(Void))
    fun splitter_node_uninit = ma_splitter_node_uninit(p_splitter_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct BiquadNodeConfig
      node_config : Void
      biquad : Void
    end

    fun biquad_node_config_init = ma_biquad_node_config_init(channels : Void, b0 : LibC::Float, b1 : LibC::Float, b2 : LibC::Float, a0 : LibC::Float, a1 : LibC::Float, a2 : LibC::Float)

    struct BiquadNode
      base_node : Void
      biquad : Void
    end

    fun biquad_node_init = ma_biquad_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun biquad_node_reinit = ma_biquad_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun biquad_node_uninit = ma_biquad_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct LpfNodeConfig
      node_config : Void
      lpf : Void
    end

    fun lpf_node_config_init = ma_lpf_node_config_init(channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, order : Void)

    struct LpfNode
      base_node : Void
      lpf : Void
    end

    fun lpf_node_init = ma_lpf_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun lpf_node_reinit = ma_lpf_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun lpf_node_uninit = ma_lpf_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct HpfNodeConfig
      node_config : Void
      hpf : Void
    end

    fun hpf_node_config_init = ma_hpf_node_config_init(channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, order : Void)

    struct HpfNode
      base_node : Void
      hpf : Void
    end

    fun hpf_node_init = ma_hpf_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun hpf_node_reinit = ma_hpf_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun hpf_node_uninit = ma_hpf_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct BpfNodeConfig
      node_config : Void
      bpf : Void
    end

    fun bpf_node_config_init = ma_bpf_node_config_init(channels : Void, sample_rate : Void, cutoff_frequency : LibC::Double, order : Void)

    struct BpfNode
      base_node : Void
      bpf : Void
    end

    fun bpf_node_init = ma_bpf_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun bpf_node_reinit = ma_bpf_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun bpf_node_uninit = ma_bpf_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct NotchNodeConfig
      node_config : Void
      notch : Void
    end

    fun notch_node_config_init = ma_notch_node_config_init(channels : Void, sample_rate : Void, q : LibC::Double, frequency : LibC::Double)

    struct NotchNode
      base_node : Void
      notch : Void
    end

    fun notch_node_init = ma_notch_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun notch_node_reinit = ma_notch_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun notch_node_uninit = ma_notch_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct PeakNodeConfig
      node_config : Void
      peak : Void
    end

    fun peak_node_config_init = ma_peak_node_config_init(channels : Void, sample_rate : Void, gain_db : LibC::Double, q : LibC::Double, frequency : LibC::Double)

    struct PeakNode
      base_node : Void
      peak : Void
    end

    fun peak_node_init = ma_peak_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun peak_node_reinit = ma_peak_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun peak_node_uninit = ma_peak_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct LoshelfNodeConfig
      node_config : Void
      loshelf : Void
    end

    fun loshelf_node_config_init = ma_loshelf_node_config_init(channels : Void, sample_rate : Void, gain_db : LibC::Double, q : LibC::Double, frequency : LibC::Double)

    struct LoshelfNode
      base_node : Void
      loshelf : Void
    end

    fun loshelf_node_init = ma_loshelf_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun loshelf_node_reinit = ma_loshelf_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun loshelf_node_uninit = ma_loshelf_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct HishelfNodeConfig
      node_config : Void
      hishelf : Void
    end

    fun hishelf_node_config_init = ma_hishelf_node_config_init(channels : Void, sample_rate : Void, gain_db : LibC::Double, q : LibC::Double, frequency : LibC::Double)

    struct HishelfNode
      base_node : Void
      hishelf : Void
    end

    fun hishelf_node_init = ma_hishelf_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_node : Pointer(Void))
    fun hishelf_node_reinit = ma_hishelf_node_reinit(p_config : Pointer(Void), p_node : Pointer(Void))
    fun hishelf_node_uninit = ma_hishelf_node_uninit(p_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct DelayNodeConfig
      node_config : Void
      delay : Void
    end

    fun delay_node_config_init = ma_delay_node_config_init(channels : Void, sample_rate : Void, delay_in_frames : Void, decay : LibC::Float)

    struct DelayNode
      base_node : Void
      delay : Void
    end

    fun delay_node_init = ma_delay_node_init(p_node_graph : Pointer(Void), p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_delay_node : Pointer(Void))
    fun delay_node_uninit = ma_delay_node_uninit(p_delay_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))
    fun delay_node_set_wet = ma_delay_node_set_wet(p_delay_node : Pointer(Void), value : LibC::Float)
    fun delay_node_get_wet = ma_delay_node_get_wet(p_delay_node : Pointer(Void)) : LibC::Float
    fun delay_node_set_dry = ma_delay_node_set_dry(p_delay_node : Pointer(Void), value : LibC::Float)
    fun delay_node_get_dry = ma_delay_node_get_dry(p_delay_node : Pointer(Void)) : LibC::Float
    fun delay_node_set_decay = ma_delay_node_set_decay(p_delay_node : Pointer(Void), value : LibC::Float)
    fun delay_node_get_decay = ma_delay_node_get_decay(p_delay_node : Pointer(Void)) : LibC::Float

    struct Engine
      node_graph : Void
      p_resource_manager : Pointer(Void)
      p_device : Pointer(Void)
      p_log : Pointer(Void)
      sample_rate : Void
      listener_count : Void
      listeners : StaticArray(Void, 4)
      allocation_callbacks : Void
      owns_resource_manager : Void
      owns_device : Void
      inlined_sound_lock : Void
      p_inlined_sound_head : Pointer(Void)
      inlined_sound_count : Void
      gain_smooth_time_in_frames : Void
      default_volume_smooth_time_in_pcm_frames : Void
      mono_expansion_mode : Void
      on_process : Void
      p_process_user_data : Pointer(Void)
    end

    struct Sound
      engine_node : Void
      p_data_source : Pointer(Void)
      seek_target : Void
      at_end : Void
      end_callback : Void
      p_end_callback_user_data : Pointer(Void)
      owns_data_source : Void
      p_resource_manager_data_source : Pointer(Void)
    end

    struct EngineNodeConfig
      p_engine : Pointer(Void)
      type : Void
      channels_in : Void
      channels_out : Void
      sample_rate : Void
      volume_smooth_time_in_pcm_frames : Void
      mono_expansion_mode : Void
      is_pitch_disabled : Void
      is_spatialization_disabled : Void
      pinned_listener_index : Void
    end

    fun engine_node_config_init = ma_engine_node_config_init(p_engine : Pointer(Void), type : Void, flags : Void)

    struct EngineNode
      base_node : Void
      p_engine : Pointer(Void)
      sample_rate : Void
      volume_smooth_time_in_pcm_frames : Void
      mono_expansion_mode : Void
      fader : Void
      resampler : Void
      spatializer : Void
      panner : Void
      volume_gainer : Void
      volume : Void
      pitch : LibC::Float
      old_pitch : LibC::Float
      old_doppler_pitch : LibC::Float
      is_pitch_disabled : Void
      is_spatialization_disabled : Void
      pinned_listener_index : Void
      fade_settings : EngineNodeFadeSettings
      _owns_heap : Void
      _p_heap : Pointer(Void)
    end

    struct EngineNodeFadeSettings
      volume_beg : Void
      volume_end : Void
      fade_length_in_frames : Void
      absolute_global_time_in_frames : Void
    end

    fun engine_node_get_heap_size = ma_engine_node_get_heap_size(p_config : Pointer(Void), p_heap_size_in_bytes : Pointer(Void))
    fun engine_node_init_preallocated = ma_engine_node_init_preallocated(p_config : Pointer(Void), p_heap : Pointer(Void), p_engine_node : Pointer(Void))
    fun engine_node_init = ma_engine_node_init(p_config : Pointer(Void), p_allocation_callbacks : Pointer(Void), p_engine_node : Pointer(Void))
    fun engine_node_uninit = ma_engine_node_uninit(p_engine_node : Pointer(Void), p_allocation_callbacks : Pointer(Void))

    struct SoundConfig
      p_file_path : Pointer(LibC::Char)
      p_file_path_w : Pointer(Void)
      p_data_source : Pointer(Void)
      p_initial_attachment : Pointer(Void)
      initial_attachment_input_bus_index : Void
      channels_in : Void
      channels_out : Void
      mono_expansion_mode : Void
      flags : Void
      volume_smooth_time_in_pcm_frames : Void
      initial_seek_point_in_pcm_frames : Void
      range_beg_in_pcm_frames : Void
      range_end_in_pcm_frames : Void
      loop_point_beg_in_pcm_frames : Void
      loop_point_end_in_pcm_frames : Void
      end_callback : Void
      p_end_callback_user_data : Pointer(Void)
      init_notifications : Void
      p_done_fence : Pointer(Void)
      is_looping : Void
    end

    fun sound_config_init = ma_sound_config_init
    fun sound_config_init_2 = ma_sound_config_init_2(p_engine : Pointer(Void))

    struct SoundInlined
      sound : Void
      p_next : Pointer(Void)
      p_prev : Pointer(Void)
    end

    fun sound_group_config_init = ma_sound_group_config_init
    fun sound_group_config_init_2 = ma_sound_group_config_init_2(p_engine : Pointer(Void))

    struct EngineConfig
      p_resource_manager : Pointer(Void)
      p_context : Pointer(Void)
      p_device : Pointer(Void)
      p_playback_device_id : Pointer(Void)
      data_callback : Void
      notification_callback : Void
      p_log : Pointer(Void)
      listener_count : Void
      channels : Void
      sample_rate : Void
      period_size_in_frames : Void
      period_size_in_milliseconds : Void
      gain_smooth_time_in_frames : Void
      gain_smooth_time_in_milliseconds : Void
      default_volume_smooth_time_in_pcm_frames : Void
      pre_mix_stack_size_in_bytes : Void
      allocation_callbacks : Void
      no_auto_start : Void
      no_device : Void
      mono_expansion_mode : Void
      p_resource_manager_vfs : Pointer(Void)
      on_process : Void
      p_process_user_data : Pointer(Void)
    end

    fun engine_config_init = ma_engine_config_init
    fun engine_init = ma_engine_init(p_config : Pointer(Void), p_engine : Pointer(Void))
    fun engine_uninit = ma_engine_uninit(p_engine : Pointer(Void))
    fun engine_read_pcm_frames = ma_engine_read_pcm_frames(p_engine : Pointer(Void), p_frames_out : Pointer(Void), frame_count : Void, p_frames_read : Pointer(Void))
    fun engine_get_node_graph = ma_engine_get_node_graph(p_engine : Pointer(Void)) : Pointer(Void)
    fun engine_get_resource_manager = ma_engine_get_resource_manager(p_engine : Pointer(Void)) : Pointer(Void)
    fun engine_get_device = ma_engine_get_device(p_engine : Pointer(Void)) : Pointer(Void)
    fun engine_get_log = ma_engine_get_log(p_engine : Pointer(Void)) : Pointer(Void)
    fun engine_get_endpoint = ma_engine_get_endpoint(p_engine : Pointer(Void)) : Pointer(Void)
    fun engine_get_time_in_pcm_frames = ma_engine_get_time_in_pcm_frames(p_engine : Pointer(Void))
    fun engine_get_time_in_milliseconds = ma_engine_get_time_in_milliseconds(p_engine : Pointer(Void))
    fun engine_set_time_in_pcm_frames = ma_engine_set_time_in_pcm_frames(p_engine : Pointer(Void), global_time : Void)
    fun engine_set_time_in_milliseconds = ma_engine_set_time_in_milliseconds(p_engine : Pointer(Void), global_time : Void)
    fun engine_get_time = ma_engine_get_time(p_engine : Pointer(Void))
    fun engine_set_time = ma_engine_set_time(p_engine : Pointer(Void), global_time : Void)
    fun engine_get_channels = ma_engine_get_channels(p_engine : Pointer(Void))
    fun engine_get_sample_rate = ma_engine_get_sample_rate(p_engine : Pointer(Void))
    fun engine_start = ma_engine_start(p_engine : Pointer(Void))
    fun engine_stop = ma_engine_stop(p_engine : Pointer(Void))
    fun engine_set_volume = ma_engine_set_volume(p_engine : Pointer(Void), volume : LibC::Float)
    fun engine_get_volume = ma_engine_get_volume(p_engine : Pointer(Void)) : LibC::Float
    fun engine_set_gain_db = ma_engine_set_gain_db(p_engine : Pointer(Void), gain_db : LibC::Float)
    fun engine_get_gain_db = ma_engine_get_gain_db(p_engine : Pointer(Void)) : LibC::Float
    fun engine_get_listener_count = ma_engine_get_listener_count(p_engine : Pointer(Void))
    fun engine_find_closest_listener = ma_engine_find_closest_listener(p_engine : Pointer(Void), absolute_pos_x : LibC::Float, absolute_pos_y : LibC::Float, absolute_pos_z : LibC::Float)
    fun engine_listener_set_position = ma_engine_listener_set_position(p_engine : Pointer(Void), listener_index : Void, x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun engine_listener_get_position = ma_engine_listener_get_position(p_engine : Pointer(Void), listener_index : Void)
    fun engine_listener_set_direction = ma_engine_listener_set_direction(p_engine : Pointer(Void), listener_index : Void, x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun engine_listener_get_direction = ma_engine_listener_get_direction(p_engine : Pointer(Void), listener_index : Void)
    fun engine_listener_set_velocity = ma_engine_listener_set_velocity(p_engine : Pointer(Void), listener_index : Void, x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun engine_listener_get_velocity = ma_engine_listener_get_velocity(p_engine : Pointer(Void), listener_index : Void)
    fun engine_listener_set_cone = ma_engine_listener_set_cone(p_engine : Pointer(Void), listener_index : Void, inner_angle_in_radians : LibC::Float, outer_angle_in_radians : LibC::Float, outer_gain : LibC::Float)
    fun engine_listener_get_cone = ma_engine_listener_get_cone(p_engine : Pointer(Void), listener_index : Void, p_inner_angle_in_radians : Pointer(LibC::Float), p_outer_angle_in_radians : Pointer(LibC::Float), p_outer_gain : Pointer(LibC::Float))
    fun engine_listener_set_world_up = ma_engine_listener_set_world_up(p_engine : Pointer(Void), listener_index : Void, x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun engine_listener_get_world_up = ma_engine_listener_get_world_up(p_engine : Pointer(Void), listener_index : Void)
    fun engine_listener_set_enabled = ma_engine_listener_set_enabled(p_engine : Pointer(Void), listener_index : Void, is_enabled : Void)
    fun engine_listener_is_enabled = ma_engine_listener_is_enabled(p_engine : Pointer(Void), listener_index : Void)
    fun engine_play_sound_ex = ma_engine_play_sound_ex(p_engine : Pointer(Void), p_file_path : Pointer(LibC::Char), p_node : Pointer(Void), node_input_bus_index : Void)
    fun engine_play_sound = ma_engine_play_sound(p_engine : Pointer(Void), p_file_path : Pointer(LibC::Char), p_group : Pointer(Void))
    fun sound_init_from_file = ma_sound_init_from_file(p_engine : Pointer(Void), p_file_path : Pointer(LibC::Char), flags : Void, p_group : Pointer(Void), p_done_fence : Pointer(Void), p_sound : Pointer(Void))
    fun sound_init_from_file_w = ma_sound_init_from_file_w(p_engine : Pointer(Void), p_file_path : Pointer(Void), flags : Void, p_group : Pointer(Void), p_done_fence : Pointer(Void), p_sound : Pointer(Void))
    fun sound_init_copy = ma_sound_init_copy(p_engine : Pointer(Void), p_existing_sound : Pointer(Void), flags : Void, p_group : Pointer(Void), p_sound : Pointer(Void))
    fun sound_init_from_data_source = ma_sound_init_from_data_source(p_engine : Pointer(Void), p_data_source : Pointer(Void), flags : Void, p_group : Pointer(Void), p_sound : Pointer(Void))
    fun sound_init_ex = ma_sound_init_ex(p_engine : Pointer(Void), p_config : Pointer(Void), p_sound : Pointer(Void))
    fun sound_uninit = ma_sound_uninit(p_sound : Pointer(Void))
    fun sound_get_engine = ma_sound_get_engine(p_sound : Pointer(Void)) : Pointer(Void)
    fun sound_get_data_source = ma_sound_get_data_source(p_sound : Pointer(Void)) : Pointer(Void)
    fun sound_start = ma_sound_start(p_sound : Pointer(Void))
    fun sound_stop = ma_sound_stop(p_sound : Pointer(Void))
    fun sound_stop_with_fade_in_pcm_frames = ma_sound_stop_with_fade_in_pcm_frames(p_sound : Pointer(Void), fade_length_in_frames : Void)
    fun sound_stop_with_fade_in_milliseconds = ma_sound_stop_with_fade_in_milliseconds(p_sound : Pointer(Void), fade_length_in_frames : Void)
    fun sound_set_volume = ma_sound_set_volume(p_sound : Pointer(Void), volume : LibC::Float)
    fun sound_get_volume = ma_sound_get_volume(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_pan = ma_sound_set_pan(p_sound : Pointer(Void), pan : LibC::Float)
    fun sound_get_pan = ma_sound_get_pan(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_pan_mode = ma_sound_set_pan_mode(p_sound : Pointer(Void), pan_mode : Void)
    fun sound_get_pan_mode = ma_sound_get_pan_mode(p_sound : Pointer(Void))
    fun sound_set_pitch = ma_sound_set_pitch(p_sound : Pointer(Void), pitch : LibC::Float)
    fun sound_get_pitch = ma_sound_get_pitch(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_spatialization_enabled = ma_sound_set_spatialization_enabled(p_sound : Pointer(Void), enabled : Void)
    fun sound_is_spatialization_enabled = ma_sound_is_spatialization_enabled(p_sound : Pointer(Void))
    fun sound_set_pinned_listener_index = ma_sound_set_pinned_listener_index(p_sound : Pointer(Void), listener_index : Void)
    fun sound_get_pinned_listener_index = ma_sound_get_pinned_listener_index(p_sound : Pointer(Void))
    fun sound_get_listener_index = ma_sound_get_listener_index(p_sound : Pointer(Void))
    fun sound_get_direction_to_listener = ma_sound_get_direction_to_listener(p_sound : Pointer(Void))
    fun sound_set_position = ma_sound_set_position(p_sound : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun sound_get_position = ma_sound_get_position(p_sound : Pointer(Void))
    fun sound_set_direction = ma_sound_set_direction(p_sound : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun sound_get_direction = ma_sound_get_direction(p_sound : Pointer(Void))
    fun sound_set_velocity = ma_sound_set_velocity(p_sound : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun sound_get_velocity = ma_sound_get_velocity(p_sound : Pointer(Void))
    fun sound_set_attenuation_model = ma_sound_set_attenuation_model(p_sound : Pointer(Void), attenuation_model : Void)
    fun sound_get_attenuation_model = ma_sound_get_attenuation_model(p_sound : Pointer(Void))
    fun sound_set_positioning = ma_sound_set_positioning(p_sound : Pointer(Void), positioning : Void)
    fun sound_get_positioning = ma_sound_get_positioning(p_sound : Pointer(Void))
    fun sound_set_rolloff = ma_sound_set_rolloff(p_sound : Pointer(Void), rolloff : LibC::Float)
    fun sound_get_rolloff = ma_sound_get_rolloff(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_min_gain = ma_sound_set_min_gain(p_sound : Pointer(Void), min_gain : LibC::Float)
    fun sound_get_min_gain = ma_sound_get_min_gain(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_max_gain = ma_sound_set_max_gain(p_sound : Pointer(Void), max_gain : LibC::Float)
    fun sound_get_max_gain = ma_sound_get_max_gain(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_min_distance = ma_sound_set_min_distance(p_sound : Pointer(Void), min_distance : LibC::Float)
    fun sound_get_min_distance = ma_sound_get_min_distance(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_max_distance = ma_sound_set_max_distance(p_sound : Pointer(Void), max_distance : LibC::Float)
    fun sound_get_max_distance = ma_sound_get_max_distance(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_cone = ma_sound_set_cone(p_sound : Pointer(Void), inner_angle_in_radians : LibC::Float, outer_angle_in_radians : LibC::Float, outer_gain : LibC::Float)
    fun sound_get_cone = ma_sound_get_cone(p_sound : Pointer(Void), p_inner_angle_in_radians : Pointer(LibC::Float), p_outer_angle_in_radians : Pointer(LibC::Float), p_outer_gain : Pointer(LibC::Float))
    fun sound_set_doppler_factor = ma_sound_set_doppler_factor(p_sound : Pointer(Void), doppler_factor : LibC::Float)
    fun sound_get_doppler_factor = ma_sound_get_doppler_factor(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_directional_attenuation_factor = ma_sound_set_directional_attenuation_factor(p_sound : Pointer(Void), directional_attenuation_factor : LibC::Float)
    fun sound_get_directional_attenuation_factor = ma_sound_get_directional_attenuation_factor(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_fade_in_pcm_frames = ma_sound_set_fade_in_pcm_frames(p_sound : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, fade_length_in_frames : Void)
    fun sound_set_fade_in_milliseconds = ma_sound_set_fade_in_milliseconds(p_sound : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, fade_length_in_milliseconds : Void)
    fun sound_set_fade_start_in_pcm_frames = ma_sound_set_fade_start_in_pcm_frames(p_sound : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, fade_length_in_frames : Void, absolute_global_time_in_frames : Void)
    fun sound_set_fade_start_in_milliseconds = ma_sound_set_fade_start_in_milliseconds(p_sound : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, fade_length_in_milliseconds : Void, absolute_global_time_in_milliseconds : Void)
    fun sound_get_current_fade_volume = ma_sound_get_current_fade_volume(p_sound : Pointer(Void)) : LibC::Float
    fun sound_set_start_time_in_pcm_frames = ma_sound_set_start_time_in_pcm_frames(p_sound : Pointer(Void), absolute_global_time_in_frames : Void)
    fun sound_set_start_time_in_milliseconds = ma_sound_set_start_time_in_milliseconds(p_sound : Pointer(Void), absolute_global_time_in_milliseconds : Void)
    fun sound_set_stop_time_in_pcm_frames = ma_sound_set_stop_time_in_pcm_frames(p_sound : Pointer(Void), absolute_global_time_in_frames : Void)
    fun sound_set_stop_time_in_milliseconds = ma_sound_set_stop_time_in_milliseconds(p_sound : Pointer(Void), absolute_global_time_in_milliseconds : Void)
    fun sound_set_stop_time_with_fade_in_pcm_frames = ma_sound_set_stop_time_with_fade_in_pcm_frames(p_sound : Pointer(Void), stop_absolute_global_time_in_frames : Void, fade_length_in_frames : Void)
    fun sound_set_stop_time_with_fade_in_milliseconds = ma_sound_set_stop_time_with_fade_in_milliseconds(p_sound : Pointer(Void), stop_absolute_global_time_in_milliseconds : Void, fade_length_in_milliseconds : Void)
    fun sound_is_playing = ma_sound_is_playing(p_sound : Pointer(Void))
    fun sound_get_time_in_pcm_frames = ma_sound_get_time_in_pcm_frames(p_sound : Pointer(Void))
    fun sound_get_time_in_milliseconds = ma_sound_get_time_in_milliseconds(p_sound : Pointer(Void))
    fun sound_set_looping = ma_sound_set_looping(p_sound : Pointer(Void), is_looping : Void)
    fun sound_is_looping = ma_sound_is_looping(p_sound : Pointer(Void))
    fun sound_at_end = ma_sound_at_end(p_sound : Pointer(Void))
    fun sound_seek_to_pcm_frame = ma_sound_seek_to_pcm_frame(p_sound : Pointer(Void), frame_index : Void)
    fun sound_seek_to_second = ma_sound_seek_to_second(p_sound : Pointer(Void), seek_point_in_seconds : LibC::Float)
    fun sound_get_data_format = ma_sound_get_data_format(p_sound : Pointer(Void), p_format : Pointer(Void), p_channels : Pointer(Void), p_sample_rate : Pointer(Void), p_channel_map : Pointer(Void), channel_map_cap : Void)
    fun sound_get_cursor_in_pcm_frames = ma_sound_get_cursor_in_pcm_frames(p_sound : Pointer(Void), p_cursor : Pointer(Void))
    fun sound_get_length_in_pcm_frames = ma_sound_get_length_in_pcm_frames(p_sound : Pointer(Void), p_length : Pointer(Void))
    fun sound_get_cursor_in_seconds = ma_sound_get_cursor_in_seconds(p_sound : Pointer(Void), p_cursor : Pointer(LibC::Float))
    fun sound_get_length_in_seconds = ma_sound_get_length_in_seconds(p_sound : Pointer(Void), p_length : Pointer(LibC::Float))
    fun sound_set_end_callback = ma_sound_set_end_callback(p_sound : Pointer(Void), callback : Void, p_user_data : Pointer(Void))
    fun sound_group_init = ma_sound_group_init(p_engine : Pointer(Void), flags : Void, p_parent_group : Pointer(Void), p_group : Pointer(Void))
    fun sound_group_init_ex = ma_sound_group_init_ex(p_engine : Pointer(Void), p_config : Pointer(Void), p_group : Pointer(Void))
    fun sound_group_uninit = ma_sound_group_uninit(p_group : Pointer(Void))
    fun sound_group_get_engine = ma_sound_group_get_engine(p_group : Pointer(Void)) : Pointer(Void)
    fun sound_group_start = ma_sound_group_start(p_group : Pointer(Void))
    fun sound_group_stop = ma_sound_group_stop(p_group : Pointer(Void))
    fun sound_group_set_volume = ma_sound_group_set_volume(p_group : Pointer(Void), volume : LibC::Float)
    fun sound_group_get_volume = ma_sound_group_get_volume(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_pan = ma_sound_group_set_pan(p_group : Pointer(Void), pan : LibC::Float)
    fun sound_group_get_pan = ma_sound_group_get_pan(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_pan_mode = ma_sound_group_set_pan_mode(p_group : Pointer(Void), pan_mode : Void)
    fun sound_group_get_pan_mode = ma_sound_group_get_pan_mode(p_group : Pointer(Void))
    fun sound_group_set_pitch = ma_sound_group_set_pitch(p_group : Pointer(Void), pitch : LibC::Float)
    fun sound_group_get_pitch = ma_sound_group_get_pitch(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_spatialization_enabled = ma_sound_group_set_spatialization_enabled(p_group : Pointer(Void), enabled : Void)
    fun sound_group_is_spatialization_enabled = ma_sound_group_is_spatialization_enabled(p_group : Pointer(Void))
    fun sound_group_set_pinned_listener_index = ma_sound_group_set_pinned_listener_index(p_group : Pointer(Void), listener_index : Void)
    fun sound_group_get_pinned_listener_index = ma_sound_group_get_pinned_listener_index(p_group : Pointer(Void))
    fun sound_group_get_listener_index = ma_sound_group_get_listener_index(p_group : Pointer(Void))
    fun sound_group_get_direction_to_listener = ma_sound_group_get_direction_to_listener(p_group : Pointer(Void))
    fun sound_group_set_position = ma_sound_group_set_position(p_group : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun sound_group_get_position = ma_sound_group_get_position(p_group : Pointer(Void))
    fun sound_group_set_direction = ma_sound_group_set_direction(p_group : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun sound_group_get_direction = ma_sound_group_get_direction(p_group : Pointer(Void))
    fun sound_group_set_velocity = ma_sound_group_set_velocity(p_group : Pointer(Void), x : LibC::Float, y : LibC::Float, z : LibC::Float)
    fun sound_group_get_velocity = ma_sound_group_get_velocity(p_group : Pointer(Void))
    fun sound_group_set_attenuation_model = ma_sound_group_set_attenuation_model(p_group : Pointer(Void), attenuation_model : Void)
    fun sound_group_get_attenuation_model = ma_sound_group_get_attenuation_model(p_group : Pointer(Void))
    fun sound_group_set_positioning = ma_sound_group_set_positioning(p_group : Pointer(Void), positioning : Void)
    fun sound_group_get_positioning = ma_sound_group_get_positioning(p_group : Pointer(Void))
    fun sound_group_set_rolloff = ma_sound_group_set_rolloff(p_group : Pointer(Void), rolloff : LibC::Float)
    fun sound_group_get_rolloff = ma_sound_group_get_rolloff(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_min_gain = ma_sound_group_set_min_gain(p_group : Pointer(Void), min_gain : LibC::Float)
    fun sound_group_get_min_gain = ma_sound_group_get_min_gain(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_max_gain = ma_sound_group_set_max_gain(p_group : Pointer(Void), max_gain : LibC::Float)
    fun sound_group_get_max_gain = ma_sound_group_get_max_gain(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_min_distance = ma_sound_group_set_min_distance(p_group : Pointer(Void), min_distance : LibC::Float)
    fun sound_group_get_min_distance = ma_sound_group_get_min_distance(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_max_distance = ma_sound_group_set_max_distance(p_group : Pointer(Void), max_distance : LibC::Float)
    fun sound_group_get_max_distance = ma_sound_group_get_max_distance(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_cone = ma_sound_group_set_cone(p_group : Pointer(Void), inner_angle_in_radians : LibC::Float, outer_angle_in_radians : LibC::Float, outer_gain : LibC::Float)
    fun sound_group_get_cone = ma_sound_group_get_cone(p_group : Pointer(Void), p_inner_angle_in_radians : Pointer(LibC::Float), p_outer_angle_in_radians : Pointer(LibC::Float), p_outer_gain : Pointer(LibC::Float))
    fun sound_group_set_doppler_factor = ma_sound_group_set_doppler_factor(p_group : Pointer(Void), doppler_factor : LibC::Float)
    fun sound_group_get_doppler_factor = ma_sound_group_get_doppler_factor(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_directional_attenuation_factor = ma_sound_group_set_directional_attenuation_factor(p_group : Pointer(Void), directional_attenuation_factor : LibC::Float)
    fun sound_group_get_directional_attenuation_factor = ma_sound_group_get_directional_attenuation_factor(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_fade_in_pcm_frames = ma_sound_group_set_fade_in_pcm_frames(p_group : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, fade_length_in_frames : Void)
    fun sound_group_set_fade_in_milliseconds = ma_sound_group_set_fade_in_milliseconds(p_group : Pointer(Void), volume_beg : LibC::Float, volume_end : LibC::Float, fade_length_in_milliseconds : Void)
    fun sound_group_get_current_fade_volume = ma_sound_group_get_current_fade_volume(p_group : Pointer(Void)) : LibC::Float
    fun sound_group_set_start_time_in_pcm_frames = ma_sound_group_set_start_time_in_pcm_frames(p_group : Pointer(Void), absolute_global_time_in_frames : Void)
    fun sound_group_set_start_time_in_milliseconds = ma_sound_group_set_start_time_in_milliseconds(p_group : Pointer(Void), absolute_global_time_in_milliseconds : Void)
    fun sound_group_set_stop_time_in_pcm_frames = ma_sound_group_set_stop_time_in_pcm_frames(p_group : Pointer(Void), absolute_global_time_in_frames : Void)
    fun sound_group_set_stop_time_in_milliseconds = ma_sound_group_set_stop_time_in_milliseconds(p_group : Pointer(Void), absolute_global_time_in_milliseconds : Void)
    fun sound_group_is_playing = ma_sound_group_is_playing(p_group : Pointer(Void))
    fun sound_group_get_time_in_pcm_frames = ma_sound_group_get_time_in_pcm_frames(p_group : Pointer(Void))
  end
end
