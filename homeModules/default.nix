{ inputs, lib, ... }:

{
  imports = [
    inputs.self.homeModules.profiles
    inputs.self.homeModules.neovim
    inputs.self.homeModules.zsh
  ];

  spreetin = {
    neovim.enable = lib.mkDefault true;
    zsh.enable = lib.mkDefault true;
  };
}
