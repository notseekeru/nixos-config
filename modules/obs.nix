{ config, lib, pkgs, ... }:

let
  cfg = config.modules.obs;
  obsPkgs = with pkgs; [
    obs-studio
    obs-studio-plugins.obs-pipewire-audio-capture   # PipeWire audio sink
    obs-studio-plugins.wlrobs                         # Wayland screen capture (wlroots)
    obs-studio-plugins.obs-vkcapture                  # Vulkan/OpenGL game capture
    obs-studio-plugins.obs-websocket                  # Remote control API
    obs-studio-plugins.input-overlay                  # Keyboard/mouse overlay
    obs-studio-plugins.obs-move-transition            # Smooth scene transitions
    obs-studio-plugins.obs-multi-rtmp                 # Multi-platform streaming
  ];

  # Default scene collection: Desktop Audio + Mic (pulse) + Display Capture (wlrobs)
  defaultScene = builtins.toJSON {
    name = "Default";
    DesktopAudioDevice1 = {
      prev_ver = 536936450;
      name = "Desktop Audio";
      uuid = "e8c7be75-50ec-410c-af3f-dbbc57f3e521";
      id = "pulse_output_capture";
      versioned_id = "pulse_output_capture";
      settings = { device_id = "default"; };
      mixers = 255; sync = 0; flags = 0; volume = 1.0; balance = 0.5;
      enabled = true; muted = false;
      push-to-mute = false; push-to-mute-delay = 0;
      push-to-talk = false; push-to-talk-delay = 0;
      hotkeys = {
        "libobs.mute" = []; "libobs.unmute" = [];
        "libobs.push-to-mute" = []; "libobs.push-to-talk" = [];
      };
      deinterlace_mode = 0; deinterlace_field_order = 0;
      monitoring_type = 0; private_settings = {};
    };
    AuxAudioDevice1 = {
      prev_ver = 536936450;
      name = "Mic/Aux";
      uuid = "130e1205-c230-4f68-a1c5-c326234143b7";
      id = "pulse_input_capture";
      versioned_id = "pulse_input_capture";
      settings = { device_id = "default"; };
      mixers = 255; sync = 0; flags = 0; volume = 1.0; balance = 0.5;
      enabled = true; muted = false;
      push-to-mute = false; push-to-mute-delay = 0;
      push-to-talk = false; push-to-talk-delay = 0;
      hotkeys = {
        "libobs.mute" = []; "libobs.unmute" = [];
        "libobs.push-to-mute" = []; "libobs.push-to-talk" = [];
      };
      deinterlace_mode = 0; deinterlace_field_order = 0;
      monitoring_type = 0; private_settings = {};
    };
    sources = [
      {
        prev_ver = 536936450;
        name = "Scene";
        uuid = "d495ec9a-2000-492c-b3d1-e1b0872a7f3e";
        id = "scene";
        versioned_id = "scene";
        settings = {
          id_counter = 0;
          custom_size = false;
          items = [];
        };
        mixers = 0; sync = 0; flags = 0; volume = 1.0; balance = 0.5;
        enabled = true; muted = false;
        push-to-mute = false; push-to-mute-delay = 0;
        push-to-talk = false; push-to-talk-delay = 0;
        hotkeys = { "OBSBasic.SelectScene" = []; };
        deinterlace_mode = 0; deinterlace_field_order = 0;
        monitoring_type = 0;
        canvas_uuid = "6c69626f-6273-4c00-9d88-c5136d61696e";
        private_settings = {};
      }
    ];
    groups = [];
    scene_order = [ { name = "Scene"; } ];
    current_scene = "Scene";
    current_program_scene = "Scene";
    canvases = [];
    current_transition = "Fade";
    transition_duration = 300;
    transitions = [];
    quick_transitions = [
      { name = "Cut"; duration = 300; hotkeys = []; id = 1; fade_to_black = false; }
      { name = "Fade"; duration = 300; hotkeys = []; id = 2; fade_to_black = false; }
      { name = "Fade"; duration = 300; hotkeys = []; id = 3; fade_to_black = true; }
    ];
    saved_projectors = [];
    preview_locked = false;
    scaling_enabled = false;
    scaling_level = -10;
    scaling_off_x = 0.0; scaling_off_y = 0.0;
    modules = {
      "scripts-tool" = [];
      "output-timer" = {
        streamTimerHours = 0; streamTimerMinutes = 0; streamTimerSeconds = 30;
        recordTimerHours = 0; recordTimerMinutes = 0; recordTimerSeconds = 30;
        autoStartStreamTimer = false; autoStartRecordTimer = false;
        pauseRecordTimer = true;
      };
    };
    version = 2;
  };

  defaultProfile = pkgs.writeText "obs-default-profile" ''
    [General]
    Name=Default

    [Audio]
    SampleRate=48000
    Channels=Stereo

    [Output]
    Mode=Simple
    RecType=Standard
    RecFormat=mkv
    RecEncoder=x264
    RecQuality=HQ
    RecTracks=1
    VBitrate=2500
    ABitrate=160
    StreamEncoder=x264
    StreamAudioBitrate=160
    AudioTrack1Bitrate=160
    AudioTrack2Bitrate=160
    AudioTrack3Bitrate=128
    AudioTrack4Bitrate=128
    AudioTrack5Bitrate=128
    AudioTrack6Bitrate=128

    [AdvOut]
    RecType=Standard
    RecEncoder=x264
    FFOutputToFile=false
    FFURL=blank
    RecFilePath=

    [Video]
    BaseCX=1920
    BaseCY=1080
    OutputCX=1920
    OutputCY=1080
    ScaleType=bicubic
    FPSCommon=60
    FPSInt=60
    FPSDen=1
    FPSType=Common
    ColorFormat=I420
    ColorSpace=Rec.709
    ColorRange=Partial
  '';

  # Global config: tells OBS which profile/scene collection to use
  globalIni = pkgs.writeText "obs-global.ini" ''
    [General]
    MaxLogs=10
    InfoIncrement=-1
    ProcessPriority=Normal
    EnableAutoUpdates=false
    BrowserHWAccel=true
    LastVersion=536936450

    [Video]
    Renderer=OpenGL
  '';
in
{
  options.modules.obs = {
    enable = lib.mkEnableOption "OBS Studio recording module";

    externalPlugins = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      default = [ ];
      description = "Extra OBS plugins to install";
      example = lib.literalExpression "[ pkgs.obs-studio-plugins.obs-backgroundremoval ]";
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = obsPkgs ++ cfg.externalPlugins;

    # OBS needs realtime scheduling for glitch-free capture
    security.pam.loginLimits = [
      { domain = "@audio"; type = "-"; item = "memlock"; value = "unlimited"; }
      { domain = "@audio"; type = "-"; item = "rtprio"; value = "88"; }
      { domain = "@audio"; type = "-"; item = "nice"; value = "-11"; }
    ];

    # Ensure user is in audio group for realtime privileges
    users.users.seeker.extraGroups = lib.mkBefore [ "audio" ];

    # Inject declarative OBS config into home-manager
    home-manager.users.seeker = { ... }: {
      # OBS config directory layout
      xdg.configFile = {
        # ── Global ──
        "obs-studio/global.ini".source = globalIni;

        # ── User preferences (no FirstRun nag) ──
        "obs-studio/user.ini".text = ''
          [General]
          Pre19Defaults=false
          Pre21Defaults=false
          Pre23Defaults=false
          Pre24.1Defaults=false
          ConfirmOnExit=true
          HotkeyFocusType=NeverDisableHotkeys
          FirstRun=false

          [BasicWindow]
          PreviewEnabled=true
          PreviewProgramMode=false
          SceneDuplicationMode=true
          SwapScenesMode=true
          SnappingEnabled=true
          ScreenSnapping=true
          SourceSnapping=true
          CenterSnapping=false
          SnapDistance=10
          SpacingHelpersEnabled=true
          RecordWhenStreaming=false
          KeepRecordingWhenStreamStops=false
          SysTrayEnabled=true
          SysTrayWhenStarted=false
          SaveProjectors=false
          ShowTransitions=true
          ShowListboxToolbars=true
          ShowStatusBar=true
          ShowSourceIcons=true
          ShowContextToolbars=true
          EditBarMode=Undocked
          TbModeViewMode=1
          TbModeTransitions=true

          [Auth]
          LastAuth=

          [AdvOut]
          RecEncoder=x264

          [SimpleOutput]
          VBitrate=2500
          ABitrate=160

          [Output]
          RecEncoder=x264
        '';

        # ── Profile: Default (recording-focused) ──
        "obs-studio/basic/profiles/Default/basic.ini".source = defaultProfile;

        # ── Scene collection: Default (desktop audio + mic + display) ──
        "obs-studio/basic/scenes/Default.json".text = defaultScene;
      };
    };
  };
}
