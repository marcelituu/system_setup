{ config
, pkgs
, lib
, ...
}:
{
  users.users.marcel = {
    isNormalUser = true;
    description = "marcel";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ ];
  };

  programs.zsh.enable = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
   # vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    vimv
    wget
    git
    pciutils # lspci setpci
    usbutils # lsusb
    lshw
    file
    fastfetch
    gnumake
    ripgrep
    tmux
    tree
    btop
    du-dust
    tldr
    xclip
    neofetch
    brightnessctl
    fzf
    zoxide
    speedtest-cli
  ];

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_ES.UTF-8";
    LC_IDENTIFICATION = "es_ES.UTF-8";
    LC_MEASUREMENT = "es_ES.UTF-8";
    LC_MONETARY = "es_ES.UTF-8";
    LC_NAME = "es_ES.UTF-8";
    LC_NUMERIC = "es_ES.UTF-8";
    LC_PAPER = "es_ES.UTF-8";
    LC_TELEPHONE = "es_ES.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  console.keyMap = "es";




  nixpkgs.overlays = [
    (final: prev: {
      dmraid = prev.dmraid.overrideAttrs (oA: {
        patches = oA.patches ++ [
          (prev.fetchpatch2 {
            url = "https://raw.githubusercontent.com/NixOS/nixpkgs/f298cd74e67a841289fd0f10ef4ee85cfbbc4133/pkgs/os-specific/linux/dmraid/fix-dmevent_tool.patch";
            hash = "sha256-MmAzpdM3UNRdOk66CnBxVGgbJTzJK43E8EVBfuCFppc=";
          })
        ];
      });
    })
  ];

}
