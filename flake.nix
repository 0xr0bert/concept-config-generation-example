{
  description = "CONCEPT configuration generation";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem(system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      rec {
        pythonEnv = pkgs.python3.withPackages(p : with p; [
          jupyter
	  networkx
          numpy
          pandas
	  scipy
        ]);
        devShell = pkgs.mkShell {
          buildInputs = [
            pythonEnv
            pkgs.glibcLocales
          ];
          shellHook = ''
            export PS1="\n\[\033[1;32m\][concept-config:\\w]\$\[\033[0m\] "
          '';
        };
      }
    );
}
