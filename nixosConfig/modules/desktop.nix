{ config
, pkgs
, lib
, self
, ...
}:


  let vscode-insiders = (pkgs.vscode.override { isInsiders = true; }).overrideAttrs (oldAttrs: {
    src = (
      builtins.fetchTarball {
        url = "https://code.visualstudio.com/sha/download?build=insider&os=linux-x64";
        sha256 = "sha256:0vmndc40z0ahijjghpfb52kkkydcr107rbsg0hlan4yg5db1kl8n";
      }
    );
    version = "1.99-insider";
  });
  in 
{
  environment.systemPackages = with pkgs; [

    pavucontrol
    # -- dev --
    # -- browsers --
    google-chrome
    python3
    
    # -- code editor --
    vscode
    vscode-insiders
    nixpkgs-fmt #allow extension nix ide vscode
    gedit
    obsidian
  
    # -- icons --
    adwaita-icon-theme
    papirus-icon-theme

    # -- notifications --
    dunst

    # -- browsers --
    google-chrome
    
    # -- social --
    discord

    # -- psw --
    pcsx2

    # -- k8s
    kubectl
    minikube
    kubernetes-helm
    docker-machine-kvm2
    kubectx

    self.packages.${pkgs.system}.windsurf
    
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
      #accelSpeed = 0.5;
      naturalScrolling = false;
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
      font-awesome
      rubik

    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrains Mono" ];
      };
    };
  };

}
