{
  description = "Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    treefmt-nix,
    ...
  }:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = [treefmt-nix.flakeModule];

      perSystem = {
        config,
        pkgs,
        ...
      }: let
        python = pkgs.python313;
      in {
        treefmt = {
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            ruff-format.enable = true;
            ruff-check.enable = true;
            taplo.enable = true;
          };
        };

        devShells.default = pkgs.mkShell {
          inputsFrom = [config.treefmt.build.devShell];
          packages = [
            python
            pkgs.uv
            pkgs.ruff
            pkgs.basedpyright
          ];
          env = {
            # uvにNixのPythonを使わせ、Pythonの自動ダウンロードを無効化する
            UV_PYTHON = "${python}/bin/python";
            UV_PYTHON_DOWNLOADS = "never";
          };
          shellHook = ''
            export UV_PROJECT_ENVIRONMENT="$PWD/.venv"
          '';
        };
      };
    };
}
