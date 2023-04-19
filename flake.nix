{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; overlays = [ self.overlays.${system}.default ]; };
    in {
      devShells.default = pkgs.mkShell {
        name = "otto-dev";
        buildInputs = with pkgs; [
            pkgs.minikube
            pkgs.kubectl
            pkgs.kubernetes-helm
            pkgs.k9s
        ];
      };
      overlays.default = (final: prev: {
      });
  });
}
