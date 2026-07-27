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
    # Use mkBefore so other modules can override; avoids self-referencing recursion
    users.users.seeker.extraGroups = lib.mkBefore [ "audio" ];
  };
}
