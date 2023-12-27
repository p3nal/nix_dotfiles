{
  pkgs,
  inputs,
  ...
}: {
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      la = "ls -a";
      lah = "ls -laht";
      ".." = "cd ..";
      msnw = "mount /mnt/snw";
      usnw = "umount /mnt/snw";
      snw = "cd /mnt/snw";
      bkup = "ionice -c 3 rsync -auvhP /home/penal/Sync /home/penal/.dotfiles /home/penal/Movies /mnt/snw --delete-after";
      phonebkup = "ionice -c 3 rsync -ruvhP /home/penal/Media/ /mnt/snw/personal-media/";
      projbkup = "ionice -c 3 rsync -auvhP /home/penal/Playground /home/penal/Projects /mnt/snw --include='**.gitignore' --filter=':- .gitignore' --delete-after";
      scan = "iwctl station wlan0 scan && iwctl station wlan0 get-networks";
      connect = "iwctl station wlan0 connect";
      up = "systemctl start";
      down = "systemctl stop";
      z = "zathura";
      duh = "du . -h --max-depth 0 | awk '{print(\$1)}'";
      # see https://github.com/russelltg/wl-screenrec
      record = ''wl-screenrec -f Videos/screenrec-"`date +%a-%d-%b-%H-%M-%S`".mp4'';
      recordarea = ''wl-screenrec -g "`slurp -w 0`" -f Videos/screenrec-"`date +%a-%d-%b-%H-%M-%S`".mp4'';
    };
    enableCompletion = true;
    profileExtra = ''
      if [ -z "$DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        exec ssh-agent Hyprland
      fi
      export XDG_DATA_DIRS="''$HOME/.nix-profile/share:''${XDG_DATA_DIRS}"
      # eval $(ssh-agent)
    '';
    bashrcExtra = ''
      parse_git_branch() {
        git branch --show-current 2> /dev/null | awk -F: '{print "("$1")"}'
      }

      export PS1='\[\e]133;k;start_kitty\a\]\[\e]133;A\a\]\[\e]133;k;end_kitty\a\]\n\[\e]133;k;start_secondary_kitty\a\]\[\e]133;A;k=s\a\]\[\e]133;k;end_secondary_kitty\a\]\[\033[1;32m\][\[\e]0;\u@\h: \w\a\]\u@\h:\w] \[\e[91m\]$(parse_git_branch)\[\e[00m\]\n\$\[\033[0m\] \[\e]133;k;start_suffix_kitty\a\]\[\e[5 q\]\[\e]2;\w\a\]\[\e]133;k;end_suffix_kitty\a\]'
      # Enable vim mode
      set -o vi
      bind -m vi-insert 'TAB: menu-complete'
      bind -m vi-command 'TAB: menu-complete'
      bind -m vi-command 'Control-l: clear-screen'
      bind -m vi-insert 'Control-l: clear-screen'
      bind -m vi-insert 'Control-e: end-of-line'
      bind -m vi-insert 'Control-a: beginning-of-line'

      # Enable school proxy
      function pe() {
      	export http_proxy="http://10.23.201.11:3128/"
      	export https_proxy=$http_proxy
      	export ftp_proxy=$http_proxy
      	export rsync_proxy=$http_proxy
      	export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
      	export HTTP_PROXY=$http_proxy
      	export HTTPS_PROXY=$http_proxy
      	export FTP_PROXY=$http_proxy
      	export RSYNC_PROXY=$http_proxy
      	echo -e "Proxy environment variables set."
      }

      # Disable school proxy
      function pd() {
      	unset http_proxy https_proxy ftp_proxy rsync_proxy \
      		  HTTP_PROXY HTTPS_PROXY FTP_PROXY RSYNC_PROXY \
      		  no_proxy
      	echo -e "Proxy environment variables removed."
      }
    '';
    shellOptions = [
      "autocd"
      "cdspell"
      "direxpand"
    ];
  };
}
