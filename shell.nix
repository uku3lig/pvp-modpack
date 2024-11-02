{pkgs ? import <nixpkgs> {}}:
with pkgs;
  mkShellNoCC {
    packages = [packwiz yq];
  }
