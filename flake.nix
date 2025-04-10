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
        pname = "st-myfork";
        src = pkgs.fetchFromGitHub {
          owner = "FrancisRicle"; # Cambia esto
          repo = "st";
          rev = "ab180974d910596ad936a291d3eeaefdb5b1b31c"; # Específico a tu versión
          sha256 = "sha256-WcYoP3IXSes4QGeLBR4Nymmc8VL5COBSPaPRl554WQk="; # Reemplázalo con el hash correcto
        };
        buildInputs = old.buildInputs ++ deps; # Agrega dependencias si es necesario
      });

      defaultPackage.${system} = self.packages.${system}.st;
    };
}
