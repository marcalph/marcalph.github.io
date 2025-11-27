{
  description = "Jekyll development environment for marcalph.github.io";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            ruby_3_3
            bundler
            pkg-config
            libxml2
            libxslt
            zlib
            libyaml
          ];

          shellHook = ''
            export GEM_HOME="$PWD/.gems"
            export PATH="$GEM_HOME/bin:$PATH"
            export BUNDLE_PATH="$GEM_HOME"

            echo "Jekyll dev environment ready!"
            echo "Run: bundle install && bundle exec jekyll serve"
          '';
        };
      }
    );
}
