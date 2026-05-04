{ config, pkgs, lib, ... }:
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # Theme
      dracula-theme.theme-dracula

      # Web languages
      bradlc.vscode-tailwindcss

      # General
      pkief.material-icon-theme
      christian-kohler.path-intellisense
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "vscode-dotnet-runtime";
        publisher = "ms-dotnettools";
        version = "3.0.0";
        sha256 = "sha256-RA7skgj6yFZxk2XuJZtcDrI4dFrAbwODmwqSx4xWFUY=";
      }
      {
        name = "csharp";
        publisher = "ms-dotnettools";
        version = "2.130.5";
        sha256 = "sha256-HBkE5zksCJZzFhVTTfB8JiyacktRSwj/MMfQeK+pPMk=";
      }
      {
        name = "csdevkit";
        publisher = "ms-dotnettools";
        version = "2.13.12";
        sha256 = "sha256-ANKNv77HhSlR7TJufW4f/T5xoQgO7mJXmz5n9Mff7t8=";
      }
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
    };
  };
}