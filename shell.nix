{ pkgs ? import <nixpkgs> { config.documentation = { man.enable = false; doc.enable = false; info.enable = false; }; }
, unstable ? import <unstable> { config.documentation = { man.enable = false; doc.enable = false; info.enable = false; }; }
}:

let
  pywpkgs = unstable.python310.withPackages (p: with p; [ pandoc-xnos openpyxl ]);
  rbwpkgs = unstable.ruby_3_1.withPackages (p: with p; [ pandocomatic ]);
  hswpkgs = unstable.haskellPackages.ghcWithPackages (h: with h; [
    pandoc pandoc-crossref pandoc-include-code pandoc-plot
  ]);

  fonts = pkgs.makeFontsConf { fontDirectories = with pkgs; [ freefont_ttf fira fira-mono ubuntu_font_family noto-fonts-cjk gyre-fonts hyperscrypt-font lmodern ]; }; # https://github.com/NixOS/nixpkgs/issues/24485

  md2pdf-script = (pkgs.writeScriptBin "md2pdf" ''
    #!/usr/bin/env bash

    for F in "$@"; do
        OFILE="$(sed -rn 's/^(.*)(\.md)$/\1.pdf/p' <<<"$F")"
        [[ -f "$OFILE" ]] && mv "$OFILE" "$OFILE".bak
        set -x
        ${rbwpkgs.out}/bin/pandocomatic -b -c ~/.pandoc/pandocomatic/pandocomatic.yaml -o "$OFILE" "$F" 1>&2 && echo "$OFILE"
        set +x
    done
  '').out;

in

pkgs.mkShell {
  nativeBuildInputs = with pkgs; [
    lua jdk librsvg
    (texlive.combine { inherit (texlive)
        scheme-small fontspec
        xcolor koma-script nth marvosym fontawesome multirow placeins enumitem tcolorbox # used by 1nnovatio* templates
        lualatex-math environ lastpage titlesec advdate
        footnotebackref selnolig csquotes mdframed zref needspace titling mlmodern tex-gyre fvextra # used by eisvogel.tex template
        svg # for diagram-generator.lua
        collection-langgerman collection-langenglish
    ;})
  ]
  ++ (with unstable; [
    # pandoc-plantuml-filter # set PLANTUML_BIN otherwise the filter doesn't work!
    pandoc-drawio-filter pandoc-include
  ])
  ++ [ hswpkgs pywpkgs rbwpkgs ]; # proxy vars to get the out path for the complete env

  # SOURCE_DATE needed for LaTeX \today to function!
  # PLANTUML and DOT used by pandoc-lua-filters
  shellHook = ''
    export SOURCE_DATE_EPOCH="$(date +%s)"
    export FORCE_SOURCE_DATE=1
    export PATH=${md2pdf-script}/bin:${pywpkgs.out}/bin:${rbwpkgs.out}/bin:${hswpkgs.out}/bin:${unstable.pandoc-lua-filters}/share/pandoc/filters''${PATH:+:''${PATH}}
    export FONTCONFIG_FILE=${fonts}
    export PLANTUML_BIN=${unstable.plantuml}/bin/plantuml
    export PLANTUML=${unstable.plantuml}/lib/plantuml.jar
    export DOT=${pkgs.graphviz}/bin/dot
  '';
}