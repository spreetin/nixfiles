inputs:
{
  ...
}:

{
  imports = [
    inputs.self.homeModules.neovim
    inputs.self.homeModules.zsh
    inputs.self.homeModules.profiles
  ];
}
