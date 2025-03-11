{ stdenv
, inputs
, callPackage
, fetchurl
, nixosTests
, commandLineArgs ? ""
, useVSCodeRipgrep ? stdenv.hostPlatform.isLinux
, ...
}:
let
  inherit (stdenv.hostPlatform) system;
  throwSystem = throw "Unsupported system: ${system}";

  plat =
    {
      x86_64-linux = "4a9b9c6cf723db24e830e15cae3c37be4799d0934f92d85d17c8f8ec3430d02e";
      # Pretty sure these below aren't currently supported.
      # x86_64-darwin = "macos-x64";
      # aarch64-linux = "linux-arm64";
      # aarch64-darwin = "macos-arm64";
      # armv7l-linux = "linux-armhf";
    }.${system} or throwSystem;

  archive_fmt = if stdenv.hostPlatform.isDarwin then "zip" else "tar.gz";

  sha256 = {
    x86_64-linux = "4a9b9c6cf723db24e830e15cae3c37be4799d0934f92d85d17c8f8ec3430d02e";
  }.${system} or throwSystem;

in
# https://windsurf-stable.codeium.com/api/update/linux-x64/stable/latest
callPackage "${inputs.nixpkgs}/pkgs/applications/editors/vscode/generic.nix" rec {
  inherit commandLineArgs useVSCodeRipgrep;

  version = "1.4.3";
  pname = "windsurf";

  executableName = "windsurf";
  longName = "Windsurf";
  shortName = "windsurf";

  src = fetchurl {
    url = "https://windsurf-stable.codeiumdata.com/linux-x64/stable/d4fc55fbd0d7b321c4f3b5fb4f56e01c0775d394/Windsurf-linux-x64-${version}.${archive_fmt}";
   # https://windsurf-stable.codeiumdata.com/linux-x64/stable/d4fc55fbd0d7b321c4f3b5fb4f56e01c0775d394/Windsurf-linux-x64-1.4.3.tar.gz
    inherit sha256;
  };

  sourceRoot = "Windsurf";

  tests = nixosTests.vscodium;

  updateScript = "nil";

  meta = {
    description = "Windsurf - A vsCodium fork + AI features";
    platforms = [ "x86_64-linux" ];
  };
}
