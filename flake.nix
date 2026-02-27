{
  description = "Shared nixpkgs versions for QGIS";
  inputs.nixpkgs-25-11.url = "github:NixOS/nixpkgs/nixos-25.11";
  inputs.nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  outputs =
    {
      self,
      nixpkgs-25-11,
      nixpkgs-unstable,
    }:
    {
      inherit nixpkgs-25-11 nixpkgs-unstable;
    };
}
