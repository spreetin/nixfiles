{ self, inputs, ... }:

{
  imports = [
    self.nixosModules.vhost_handler
    self.nixosModules.profiles
    self.nixosModules.themes
    inputs.catppuccin.nixosModules.catppuccin
  ];
}
