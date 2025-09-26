{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.spreetin;
in
{
  sops.secrets.myusrpasswd.neededForUsers = true;
  users = {
    users.david = {
      isNormalUser = true;
      description = "David Falk";
      extraGroups = [
        "networkmanager"
        "wheel"
        "video"
        "users"
        "david"
      ]
      ++ lib.optional (lib.elem "kvm-host" cfg.profiles) "libvirtd";
      hashedPasswordFile = config.sops.secrets.myusrpasswd.path;
      uid = 1000;
      shell = pkgs.zsh;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMwQTryaCEquPZevu6Bktsit6X9N0ELTlR+64HEmmAlu david"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKEYtM61shlz8Q+XkHRW2El3hlmknXLVvh9LEmMbSA0E david"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFj57xx0m3ZSdYsklZqAdyQYeFHmR5ul/6NjOiAfYO0p david"
        #"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILF57+ssPTZXdwVa/ySNLdz86Za7P7UDBVBGgcItkzT3 deck"
      ];
    };
    groups = {
      david.gid = 1000;
    };
  };

  security = {
    polkit = {
      enable = true;
      extraConfig = ''
                polkit.addRule(function(action, subject) {
        	        if (subject.isInGroup("users") && (
        	          action.id == "org.freedesktop.login1.reboot" ||
        		        action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
        		        action.id == "org.freedesktop.login1.power-off" ||
        		        action.id == "org.freedesktop.login1.power-off-multiple-sessions")) {
        	            return polkit.Result.YES;
        	          }
        	      })
      '';
    };
  };
}
