{ inputs, ... }:

{
  imports = [
    inputs.self.nixosModules.vhost_handler
    inputs.self.nixosModules.profiles
    inputs.self.nixosModules.themes
    inputs.catppuccin.nixosModules.catppuccin
  ];
}
