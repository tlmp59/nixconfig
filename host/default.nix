{ self, nixpkgs, home-manager, ... }@inputs: let
  inherit (nixpkgs) lib;

  mylib = import ../lib { inherit lib; };
  specialArgs = { inherit inputs lib mylib; }; 

  genNixHosts = system: let
    # TODO: add fault tolerance options when no host in system dir
    hosts = mylib.dirsIn ./${system};
  in lib.genAttrs hosts (
    hostname: lib.nixosSystem {
      inherit system specialArgs;
      modules = [ 
	./${system}/${hostname}/configuration.nix 
	../module/nixos
      ];
    }
  );
  
  # genDarwinHosts = 
in {
  nixosConfigurations = lib.mergeAttrsList [
    (genNixHosts "x86_64-linux") 
    (genNixHosts "aarch64-linux") 
  ];
}
