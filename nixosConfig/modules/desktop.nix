{ config
, pkgs
, lib
, inputs
, ...
}:
{

  environment.systemPackages = with pkgs; [

    pavucontrol
    # -- dev --

    # -- code editor --
    vscode
    nixpkgs-fmt #allow extension nix ide vscode
    gedit
    obsidian

    # -- icons --
    adwaita-icon-theme
    papirus-icon-theme

    # -- notifications --
    dunst
  ];


  programs.nix-ld.enable = true;

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    preferences = {
      "browser.fullscreen.autohide" = false;
      "browser.compactmode.show" = true;
    };
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      middleEmulation = false;
    };
    touchpad = {
      accelProfile = "flat";
      naturalScrolling = true;
    };
  };

  # services.dbus.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # If you want to use JACK applications, uncomment this
  #jack.enable = true;

  # use the example session manager (no others are packaged yet so this is enabled by default,
  # no need to redefine it in your config for now)
  #media-session.enable = true;

  # check the names with fc-list

  nixpkgs.config.input-fonts.acceptLicense = true;

  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.symbols-only

    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrains Mono" ];
      };
    };
  };

}
