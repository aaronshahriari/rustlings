{
  description = "Multiple dev environments";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          name = "rust";
          buildInputs = with pkgs; [
            rustlings
            rustc
            cargo
            rust-analyzer
          ];
          shellHook = ''
            export PROMPT_SUFFIX="(nix)"
            export SHELL=/run/current-system/sw/bin/zsh
          '';
        };
      }
    );
}
