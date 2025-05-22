# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:
{
  networking.hostName = "marcel";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  services.xserver.videoDrivers = [ "modesetting" ];
  hardware.graphics.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  virtualisation.waydroid.enable = true;


  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };

  environment.systemPackages = with pkgs; [
    powertop
    acpi
    brightnessctl
    thinkfan
  ];

  services.tlp = {
    enable = true;
    settings = {


      # --- ThinkPad Battery Thresholds ---
      # IMPORTANT: Check your battery identifier with `tlp-stat -b` (might be BAT0 or BAT1)
      # These settings significantly improve battery lifespan if often plugged in.
      # Add START_CHARGE_THRESH_BAT1 / STOP_CHARGE_THRESH_BAT1 if you have a second battery

      # --- CPU Frequency Scaling ---
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "performance"; # Or "schedutil" for a balance

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "performance"; # Or "power" for max savings

      # Disable CPU boost on battery for significant power savings
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1; # Set to 1 if you need max performance bursts on battery

      CPU_HWP_DYN_BOOST_ON_AC = 1; # Use Intel HWP dynamic boost if available
      CPU_HWP_DYN_BOOST_ON_BAT = 1; # Disable dynamic boost on battery

      SCHED_POWERSAVE_ON_AC = 0; # Disable scheduler powersave hints on AC
      SCHED_POWERSAVE_ON_BAT =0; # Enable scheduler powersave hints on Battery

      # --- PCI Express Active State Power Management (PCIe ASPM) ---
      PCIE_ASPM_ON_AC = "performance";
      PCIE_ASPM_ON_BAT = "performance";

   
  };
  };


 
}
