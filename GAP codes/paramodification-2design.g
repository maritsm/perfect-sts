# version 14/10/2022

LoadPackage( "IncidenceStructures", false );
LoadPackage( "grape", false);
###############################################################################
DeclareInfoClass( "InfoParamod" ); 

AllRegularBlockColorings := function( bls, nr_colors, gr )
  local Gamma, complete_subgraphs, graph_of_cliques, colorings, ret,
        new_blocks, c, c_vec, i, j;
  Gamma := Graph( gr, bls, OnSets,
                  function( x, y )
                    return x <> y and Intersection( x, y ) = [];
                  end );
  complete_subgraphs := CompleteSubgraphs( Gamma, Size( bls ) / nr_colors, 1 );
  complete_subgraphs := Union( List( complete_subgraphs,
    x -> Orbit( AutomorphismGroup( Gamma ), x, OnSets ) ) );
  Info( InfoParamod, 3, "cliques of the line graph computed..." );
  graph_of_cliques := Graph( Gamma.group, complete_subgraphs, OnSets,
    function( x, y )
      return x <> y and Intersection( x, y ) = [];
    end );
  colorings := CompleteSubgraphs( graph_of_cliques, nr_colors, 1 );
  Info( InfoParamod, 3, Size( colorings ), " block colorings computed..." );
  ret := [];
  for c in colorings do
    c_vec := 0*[1..Size(bls)];
    for i in [1..nr_colors] do 
      for j in VertexNames( graph_of_cliques )[c[i]] do
        c_vec[ Position( bls, VertexNames( Gamma )[j] ) ] := i;
      od;
    od;
    Add(ret, Transformation( c_vec ) );
  od;
  return ret;
end;

ParamodificationOf2DesignNC := function( des, b, chi )
  local Cb, n_Cb, C_star_b, intact_blks, B_star;
  Cb := Filtered( BlocksOfIncidenceStructure( des ),
    x -> Size( Intersection( x, b ) ) = 1 );
  n_Cb := Length( Cb );
  C_star_b := List( [1..n_Cb],
    i -> Union( Difference( Cb[i], b ), [ b[i^chi] ] ) );
  intact_blks := Difference( BlocksOfIncidenceStructure( des ), Cb );
  B_star := Union( intact_blks, C_star_b );
  Apply( B_star, PlainListCopy );
  return IncidenceStructureByBlocks( Union(B_star), B_star );
end;

ParamodificationOf2Design := function( des, b, chi )
  local Cb;
  if not b in BlocksOfIncidenceStructure( des ) then 
    Error( "argument 2 must be a block of argument 1");
  fi;
  Cb := Filtered( BlocksOfIncidenceStructure( des ),
                   x -> Size( Intersection( x, b ) ) = 1 );
  Cb := List( Cb, x -> Difference( x, b) );
  if not ForAll( Combinations( [1..Size(Cb)], 2 ),
      p -> Intersection( Cb{p} ) = [] or ( p[1]^chi <> p[2]^chi ) ) then
    Error( "argument 3 is not a proper block coloring" ); 
  fi;
  return ParamodificationOf2DesignNC( des, b, chi );
end;

ParamodificationsOf2DesignWithBlock := function( des, b )
  local k, Cb, b_stab, new_designs, all, allchibmod, i, isom_class, colorings;
  if not b in BlocksOfIncidenceStructure( des ) then 
    Error( "argument 2 must be a block of argument 1");
  fi;
  k := Size( BlocksOfIncidenceStructure( des )[1] );
  Cb := Filtered( BlocksOfIncidenceStructure( des ),
    x -> Size( Intersection( x, b ) ) = 1 );
  Cb := List( Cb, x -> Difference( x, b ) ); 
  b_stab := Stabilizer( AutomorphismGroup@IncidenceStructures( des ), b, OnSets );
  colorings := AllRegularBlockColorings( Cb, k, b_stab );
  Info( InfoParamod, 4, Size( colorings ), " coloring(s) for the given design-block pair computed..." );
  new_designs := List( colorings, c -> ParamodificationOf2DesignNC( des, b, c ) );
  all := [1..Length( new_designs )];
  allchibmod := [];
  while all <> [] do
    i := Remove( all );
    isom_class := Filtered( all, x -> Isomorphism@IncidenceStructures( new_designs[i],
      new_designs[x] ) <> fail ) ;
    all := Difference( all, isom_class );
    Add( allchibmod, new_designs[i] );
  od;
  return allchibmod;
end;

AllParamodificationsOf2Design := function( des )
  local blocks, rep_blocks, allchibmods, uus, b;
  blocks := BlocksOfIncidenceStructure( des );
  rep_blocks := List( Orbits( AutomorphismGroup@IncidenceStructures( des ), blocks, OnSets ),
    orb -> Representative( orb ) );
  Info( InfoParamod, 3, Size( rep_blocks ), " block representatives for the 2-design computed..." );
  allchibmods := [];
  for b in rep_blocks do
    uus := ParamodificationsOf2DesignWithBlock( des, b );
    uus := Filtered( uus, x -> Isomorphism@IncidenceStructures( x, des ) = fail and
        ForAll( allchibmods, y -> Isomorphism@IncidenceStructures( y, x ) = fail ) );
    Append( allchibmods, uus );
  od;
  return allchibmods;
end;

######################################################
######################################################
######################################################

des:=IncidenceStructureByBlocks([1..25],[[1,2,9],[1,3,13],[1,4,10],[1,5,11],[1,6,24],[1,7,15],[1,8,19],[1,12,22],[1,14,16],
[1,17,18],[1,20,23],[1,21,25],[2,3,6],[2,4,12],[2,5,15],[2,7,21],[2,8,14],
[2,10,16],[2,11,17],[2,13,23],[2,18,20],[2,19,25],[2,22,24],[3,4,14],[3,5,7],
[3,8,22],[3,9,17],[3,10,11],[3,12,18],[3,15,25],[3,16,24],[3,19,20],[3,21,23],
[4,5,8],[4,6,13],[4,7,20],[4,9,25],[4,11,21],[4,15,19],[4,16,17],[4,18,22],
[4,23,24],[5,6,18],[5,9,12],[5,10,23],[5,13,20],[5,14,24],[5,16,19],[5,17,21],
[5,22,25],[6,7,14],[6,8,23],[6,9,15],[6,10,21],[6,11,19],[6,12,25],[6,16,20],
[6,17,22],[7,8,11],[7,9,22],[7,10,25],[7,12,16],[7,13,24],[7,17,19],[7,18,23],
[8,9,24],[8,10,12],[8,13,17],[8,15,21],[8,16,18],[8,20,25],[9,10,13],[9,11,23],
[9,14,20],[9,16,21],[9,18,19],[10,14,22],[10,15,18],[10,17,20],[10,19,24],[11,12,24],
[11,13,18],[11,14,25],[11,15,16],[11,20,22],[12,13,21],[12,14,17],[12,15,20],[12,19,23],
[13,14,19],[13,15,22],[13,16,25],[14,15,23],[14,18,21],[15,17,24],[16,22,23],[17,23,25],
[18,24,25],[19,21,22],[20,21,24]]);

StructureDescription(AutomorphismGroup@IncidenceStructures(des));

SetInfoLevel(InfoParamod,4);
AllParamodificationsOf2Design(des);
List(last,x->StructureDescription(AutomorphismGroup@IncidenceStructures(x)));


#ParamodificationsOf2DesignWithBlock( des, BlocksOfIncidenceStructure(des)[1] );
#b:=BlocksOfIncidenceStructure(des)[1];

### BASSZUS!!
# A Union ilyen listát is tud eredményezni: [2,8..14]
# Ez lecsapja a glabella-t....
# Hack: PlainListCopy([2,8..14]);

######################################################
######################################################
######################################################
LoadPackage("inci");
SetInfoLevel(InfoIncidenceStructures,2);

bls1:=[[1,2,9],[1,3,13],[1,4,10],[1,5,11],[1,6,24],[1,7,15],[1,8,19],[1,12,22],[1,14,16],
[1,17,18],[1,20,23],[1,21,25],[2,3,6],[2,4,12],[2,5,15],[2,7,21],[2,8,14],
[2,10,16],[2,11,17],[2,13,23],[2,18,20],[2,19,25],[2,22,24],[3,4,14],[3,5,7],
[3,8,22],[3,9,17],[3,10,11],[3,12,18],[3,15,25],[3,16,24],[3,19,20],[3,21,23],
[4,5,8],[4,6,13],[4,7,20],[4,9,25],[4,11,21],[4,15,19],[4,16,17],[4,18,22],
[4,23,24],[5,6,18],[5,9,12],[5,10,23],[5,13,20],[5,14,24],[5,16,19],[5,17,21],
[5,22,25],[6,7,14],[6,8,23],[6,9,15],[6,10,21],[6,11,19],[6,12,25],[6,16,20],
[6,17,22],[7,8,11],[7,9,22],[7,10,25],[7,12,16],[7,13,24],[7,17,19],[7,18,23],
[8,9,24],[8,10,12],[8,13,17],[8,15,21],[8,16,18],[8,20,25],[9,10,13],[9,11,23],
[9,14,20],[9,16,21],[9,18,19],[10,14,22],[10,15,18],[10,17,20],[10,19,24],[11,12,24],
[11,13,18],[11,14,25],[11,15,16],[11,20,22],[12,13,21],[12,14,17],[12,15,20],[12,19,23],
[13,14,19],[13,15,22],[13,16,25],[14,15,23],[14,18,21],[15,17,24],[16,22,23],[17,23,25],
[18,24,25],[19,21,22],[20,21,24]];;
bls2:=[[1,2,9],[1,3,13],[1,4,10],[1,5,11],[1,6,24],[1,7,15],[1,8,19],[1,12,22],[1,14,16],[1,17,18],
[1,20,23],[1,21,25],[2,3,6],[2,4,12],[2,5,15],[2,7,21],[2,8..14],[2,10,16],[2,11,17],[2,13,23],[2,18,20],[2,19,25],[2,22,24],
[3,4,14],[3,5,7],[3,8,22],[3,9,17],[3,10,11],[3,12,18],[3,15,25],[3,16,24],[3,19,20],
[3,21,23],[4,5,8],[4,6,13],[4,7,20],[4,9,25],[4,11,21],[4,15,19],[4,16,17],[4,18,22],[4,23,24],[5,6,18],[5,9,12],[5,10,23],
[5,13,20],[5,14,24],[5,16,19],[5,17,21],[5,22,25],[6,7,14],[6,8,23],[6,9,15],[6,10,21],[6,11,19],
[6,12,25],[6,16,20],[6,17,22],[7,8,11],[7,9,22],[7,10,25],[7,12,16],[7,13,24],[7,17,19],[7,18,23],[8,9,24],[8,10,12],[8,13,17],
[8,15,21],[8,16,18],[8,20,25],[9,10,13],[9,11,23],[9,14,20],[9,16,21],[9,18,19],[10,14,22],[10,15,18],
[10,17,20],[10,19,24],[11,12,24],[11,13,18],[11,14,25],[11,15,16],[11,20,22],[12,13,21],[12,14,17],[12,15,20],[12,19,23],[13,14,19],
[13,15,22],[13,16,25],[14,15,23],[14,18,21],[15,17,24],[16,22,23],[17,23,25],[18,24,25],[19,21,22],[20,21,24]];;

d1:=IncidenceStructureByBlocks([1..25],bls1);
d2:=IncidenceStructureByBlocks([1..25],bls2);

CanonicalLabellingOfIncidenceStructure(d1);
CanonicalLabellingOfIncidenceStructure(d2);

