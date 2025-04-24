{
  description = "Suckless Terminal";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: 
    let
      system = "x86_64-linux"; # Cambia según tu arquitectura si es necesario
      pkgs = import nixpkgs { inherit system; };
    deps = with pkgs; [
      harfbuzzFull
      xorg.libX11
      xorg.libXft
      xorg.libXext
      xorg.libXinerama
    ];
    in {
      packages.${system}.default = pkgs.st.overrideAttrs (old: {
        pname = "st";
        src = pkgs.fetchFromGitHub {
          owner =  "FrancisRicle";
          repo = "st";
          rev = "4b789bb7a67a2be9052028eff07d7cb904a63cfd";
          sha256 = "sha256-nLo4NVLevzrMI7m75U7huVqIkhLRknW77CZN/8NS8/s=";
        };
        buildInputs = old.buildInputs ++ deps; # Agrega dependencias si es necesario
      });
    };
}
