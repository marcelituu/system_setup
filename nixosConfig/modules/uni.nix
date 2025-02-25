{ config
, pkgs
, lib
, inputs
, ...
}:
{

  environment.systemPackages = with pkgs; [

    # -- code editor --
    jetbrains.idea-community-bin
    
    # -- java --
    jdk21
  ];


}
