{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-darwin" "x86_64-darwin" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells.python = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [
            (python3.withPackages (python-pkgs: with python-pkgs; [
              pandas
              polars
              ipython
              jupyter
              matplotlib
              python-lsp-server
              black
            ]))
          ];
        };
      };
    };
}
