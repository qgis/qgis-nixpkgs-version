{
  description = "Shared nixpkgs versions for QGIS";
  inputs.nixpkgs-26-05.url = "github:NixOS/nixpkgs/nixos-26.05";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    {
      self,
      nixpkgs-26-05,
      nixpkgs-unstable,
    }:
    {
      inherit nixpkgs-26-05 nixpkgs-unstable;
    };
}
