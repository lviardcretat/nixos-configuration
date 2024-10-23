{ 
  pkgs,
  lib,
  config,
  host,
  ... 
}:

let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
  '';

  bindWorkspaceSwitch =
    if (host == "desktop") then
      ["$mainMod, code:ampersand , workspace, 1"
      "$mainMod, code:grave, workspace, 2"
      "$mainMod, code:quotedbl, workspace, 3"
      "$mainMod, code:leftsinglequotemark, workspace, 4"
      "$mainMod, code:parenleft, workspace, 5"
      "$mainMod, \-, workspace, 6"
      "$mainMod, \è, workspace, 7"
      "$mainMod, code:underscore, workspace, 8"
      "$mainMod, \ç, workspace, 9"
      "$mainMod, code:parenright, workspace, 10"]
    else
      ["$mainMod, F1, workspace, 1"
      "$mainMod, F2, workspace, 2"
      "$mainMod, F3, workspace, 3"
      "$mainMod, F4, workspace, 4"
      "$mainMod, F5, workspace, 5"
      "$mainMod, F6, workspace, 6"
      "$mainMod, F7, workspace, 7"
      "$mainMod, F8, workspace, 8"
      "$mainMod, F9, workspace, 9"
      "$mainMod, F10, workspace, 10"];
in
{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = if (host == "desktop") then
        ["DP-2,1920x1080@240,0x0,1"
         "DP-3,1920x1080@240,0x1080,1,transform,2"]
      else
        ["eDP-1,1920x1080@60,0x0,1"];

      general = { 
        gaps_in = 5;
        gaps_out = 20;
        border_size = 2;

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false ;

        # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        # https://wiki.hyprland.org/Configuring/Variables/#decoration
        rounding = 10;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;

        # https://wiki.hyprland.org/Configuring/Variables/#blur
        blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
        };
      };

      animations = {
        # https://wiki.hyprland.org/Configuring/Variables/#animations
        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ]; 
      };

      dwindle = {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
        preserve_split = true; # You probably want this
      };

      master = {
        # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
        new_status = "master";
      };

      misc = { 
        # https://wiki.hyprland.org/Configuring/Variables/#misc
        force_default_wallpaper = 0; # Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
      };

      input = {
        # https://wiki.hyprland.org/Configuring/Variables/#input
        kb_layout = "fr";
        follow_mouse = 1;
        sensitivity = 0;# -1.0 - 1.0, 0 means no modification.
      };

      gestures = {
        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        workspace_swipe = false;
      };

      "$mainMod" = "SUPER";
      "$terminal" = "kitty";
      "$fileManager" = "yazi";
      "$menu" = "rofi -show drun -show-icons";

      bind = [
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, P, pseudo" # dwindle
        "$mainMod, J, togglesplit" # dwindle

        # Rofi launcher
        "$mainMod, space, exec, $menu"
        "$mainMod, Y, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mainMod SHIFT, Y, exec, wf-recorder -g \"$(slurp)\" -f ~/Recordings/recording_$(date +\"%Y-%m-%d_%H:%M:%S.mp4\")"
        "$mainMod SHIFT, C, exec, killall -s SIGINT wf-recorder"
        "$mainMod, L, exec, ags -t bar0"

        # Move focus with mainMod + arrow keys
        "$mainMod, left, movefocus, l"
        "$mainMod, right, movefocus, r"
        "$mainMod, up, movefocus, u"
        "$mainMod, down, movefocus, d"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ]
      ++bindWorkspaceSwitch;

      bindm = [
        # Move/resize windows with mainMod + LMB/RMB and dragging
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      windowrule = [];
      windowrulev2 = [];

      exec-once = ''${startupScript}/bin/start'';
    };
  };
}
