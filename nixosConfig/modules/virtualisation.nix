{
  config,
  pkgs,
  lib,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    swtpm
    docker
    docker-compose
    kompose
    # win-virtio # TODO: make this optional as module
  ];

  virtualisation.docker.enable = true;

  programs.dconf.enable = true;
  virtualisation.libvirtd.enable = true;
  users.users.marcel.extraGroups = [
    "libvirtd"
    "docker"
  ];
}