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
          owner =  "FrancisRicle";
          repo = "st";
          rev ="18d6ade541bb3f7a876036614a9cc991dce43dd6";
          sha256 = "sha256-fSZlvGyOwHFHQOWB79XT1GR5GYzyo1Eif16n9yRXLBk=";
        };
        buildInputs = old.buildInputs ++ deps; # Agrega dependencias si es necesario
      });

      packages.${system}.default = self.packages.${system}.st;
    };
}
