{ pkgs, ... }:

{
  # Intel GPU hardware acceleration
  hardware.graphics.extraPackages = with pkgs; [
    intel-media-driver      # VAAPI hardware acceleration (modern)
    intel-vaapi-driver      # Older Intel VAAPI
    intel-compute-runtime   # OpenCL on Intel
  ];
}
