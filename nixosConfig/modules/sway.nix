{
  config,
  pkgs,
  lib,
  ...
}:
{
  # services.xserver = {
  #   enable = true;
  #   windowManager.stumpwm.enable = true;
  #   displayManager.lightdm.enable = true;
  # };

  programs.sway.enable = true;
  programs.waybar.enable = true;

  environment.systemPackages = with pkgs; [
    alacritty    
    picom
    wofi
    alsa-utils
    slurp
    grim
    sway-contrib.grimshot
    fuzzel
    networkmanagerapplet

  ];
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
}
