{
  description = "Suckless Terminal";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    deps = with pkgs; [
      harfbuzzFull
      xorg.libX11
      xorg.libXft
      xorg.libXext
      xorg.libXinerama
    ];
  in
  {
    packages.x86_64-linux.st = pkgs.st.overrideAttrs (oldAttrs: rec {
      src = ./.;
      version = "v1.0";
      patches = [];
      buildInputs = oldAttrs.buildInputs ++ deps;
      installFlags = oldAttrs.installFlags ++ [
        "PREFIX=$HOME/.local/bin"
      ];
    });
    packages.x86_64-linux.default = self.packages.x86_64-linux.st;
    #defaultPackage.${system} = self.packages.${system}.st;
    devShell.x86_64-linux = pkgs.mkShell {
      buildInputs = deps;
    };
  };
}
