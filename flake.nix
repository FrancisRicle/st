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
      packages.${system}.st = pkgs.st.overrideAttrs (old: {
        pname = "st";
        src = pkgs.fetchFromGitHub {
          owner = "FrancisRicle"; # Cambia esto
          repo = "st";
          rev = "3e7db675697a422170196ccdf4e3746024c9abed";
          sha256 = "sha256-WcYoP3IXSes4QGeLBR4Nymmc8VL5COBSPaPRl554WQk=";
        };
        buildInputs = old.buildInputs ++ deps; # Agrega dependencias si es necesario
      });

      defaultPackage.${system} = self.packages.${system}.st;
    };
}
