{
  description = ''Binding for Qt 5's Qt SQL library. Provides a single API for multiple database engines.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-qt5_qtsql-master.flake = false;
  inputs.src-qt5_qtsql-master.ref   = "refs/heads/master";
  inputs.src-qt5_qtsql-master.owner = "philip-wernersbach";
  inputs.src-qt5_qtsql-master.repo  = "nim-qt5_qtsql";
  inputs.src-qt5_qtsql-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-qt5_qtsql-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-qt5_qtsql-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}