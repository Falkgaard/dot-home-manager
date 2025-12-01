{
   description = "Falk's (unstable channel) Home Manager configuration flake.";
   
   inputs = {
      # Specify the source of Home Manager and Nixpkgs.
      nixpkgs.url  = "github:nixos/nixpkgs/nixos-unstable";
      home-manager = {
         url                    = "github:nix-community/home-manager";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      stylix = {
         url                    = "github:nix-community/stylix";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      nvf = {
         url                    = "github:NotAShelf/nvf"; # NOTE: Neovim
         inputs.nixpkgs.follows = "nixpkgs";
      };
      nixcord = {
         url                    = "github:kaylorben/nixcord";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      firefox-addons = {
         url                    = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
         inputs.nixpkgs.follows = "nixpkgs";
      };
      niri = {
         url                    = "github:sodiboo/niri-flake";
         inputs.nixpkgs.follows = "nixpkgs";
      };
   };
   
   outputs = { nixpkgs, home-manager, stylix, nvf, nixcord, niri, ... } @ inputs:
   let
      system = "x86_64-linux"; # TODO: Parameterize?
      pkgs   = nixpkgs.legacyPackages.${system};
   in
   {
      # TODO: Add support for multiple users later.
      # Home Manager user configuration (for user `falk`):
      homeConfigurations."falk" = home-manager.lib.homeManagerConfiguration {
         inherit pkgs;
         extraSpecialArgs = { inherit inputs; }; # NOTE: Added for firefox-addons and inputs
         modules = [
            # TODO: Move these out into module/ config files
            nvf.homeManagerModules.default
            stylix.homeModules.stylix
            nixcord.homeModules.nixcord
            niri.homeModules.niri
            ./home.nix
            { nixpkgs.config.allowUnfree = true; } # NOTE: Redundant?
         ];
         # NOTE: Optionally use `extraSpecialArgs` to pass through arguments to `home.nix`.
      };
   };
   
}

