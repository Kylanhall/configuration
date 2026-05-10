{ config, pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;

    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      bradlc.vscode-tailwindcss
      pkief.material-icon-theme
      christian-kohler.path-intellisense
      jnoortheen.nix-ide
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "gitlens";
        publisher = "eamodio";
        version = "17.12.2";
        sha256 = "sha256-hXpGlnBrZoOnlBB3DydEAnp5zRMnpWuJ1PMEmTzJqqo=";
      }
      {
        name = "prettier-vscode";
        publisher = "esbenp";
        version = "12.4.0";
        sha256 = "sha256-RtIqVns16+W9/9coBFd0LNZ+ZdfhslC7d1qyvoZHmkI=";
      }
    ];
      userSettings = {
        # Theme & appearance
        "workbench.colorTheme" = "Dracula";
        "workbench.iconTheme" = "material-icon-theme";
        "editor.fontFamily" = "'JetBrains Mono', monospace";
        "editor.fontSize" = 14;
        "editor.lineHeight" = 1.6;
        "editor.fontLigatures" = true;
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;
        "workbench.list.smoothScrolling" = true;

        # Editor behaviour
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.minimap.enabled" = false;
        "editor.renderWhitespace" = "boundary";
        "editor.bracketPairColorization.enabled" = true;
        "editor.guides.bracketPairs" = true;
        "editor.inlayHints.enabled" = "on";

        # C# specific
        "[csharp]" = {
          "editor.defaultFormatter" = "ms-dotnettools.csharp";
        };
        "dotnet.completion.showCompletionItemsFromUnimportedNamespaces" = true;
        "csharp.inlayHints.enableInlayHintsForParameters" = true;
        "csharp.inlayHints.enableInlayHintsForLiteralParameters" = true;
        "csharp.inlayHints.enableInlayHintsForTypes" = true;

        # Terminal
        "terminal.integrated.fontFamily" = "'JetBrains Mono', monospace";
        "terminal.integrated.fontSize" = 13;
        "terminal.integrated.defaultProfile.linux" = "zsh";

        # Git
        "git.autofetch" = true;
        "git.confirmSync" = false;
        "gitlens.codeLens.enabled" = true;

        # Misc
        "files.autoSave" = "onFocusChange";
        "explorer.confirmDelete" = false;
        "breadcrumbs.enabled" = true;
        "workbench.startupEditor" = "none";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
      };
    };
  };
}