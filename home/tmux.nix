{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.tmux;
in {
  config = lib.mkIf cfg.enable {
    programs.tmux = {
      baseIndex = 1;
      escapeTime = 10;
      clock24 = true;
      focusEvents = true;
      keyMode = "vi";
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
    };

    programs.tmux.extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc"

      # ---Keybind---
      bind a display-panes;
      bind q confirm-before -p "kill-pane? (y/n)" kill-pane
      bind x confirm-before -p "kill-session? (y/n)" kill-session

      # ~ navigate better with vi movement
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
         | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
        "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R

      # ---Status---
      # ~ overal status setting
      set -g status-position top
      set -g status-justify absolute-centre
      set -g status-style "fg=#DCD7BA bg=default"
      set -g status-left '#{?client_prefix,#[fg=#FF5D62],#[fg=#C8C093]} さすが '
      set -g status-right ' #S:#h '

      # ~ current selected pane
      setw -g window-status-current-style 'fg=#DCD7BA underscore'
      setw -g window-status-current-format ' #I:#W#F '

      # ~ unselected pane
      setw -g window-status-style 'fg=#C8C093'
      setw -g window-status-format '#I:#W#F'

      # copy mode
      setw -g mode-style 'fg=#DCA561'
    '';
    programs.tmux.plugins = with pkgs; [
      tmuxPlugins.yank
    ];
  };
}
