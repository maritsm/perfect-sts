LoadPackage("grape");
LoadPackage("digraph");
LoadPackage("loops");

sharply_tr_set_autgroup:=function(s)
    local m,des,bls,gra;
    m:=Size(s);
    bls:=List(Cartesian([1..m],[1..m]),x->[x[1],m+x[2],2*m+x[1]^s[x[2]]]);
    gra:=Digraph([1..3*m+m^2],function(x,y) return x<=3*m and y>3*m and x in bls[y-3*m]; end);
    return AutomorphismGroup(gra);
end;

sharply_tr_set_autgroup_2:=function(s)
    local m,Sm,verts,hom,gr,xs,h;
    m:=Size(s);
    Sm:=SymmetricGroup(m);
    verts:=Elements(s[1]^Sm);
    hom:=ActionHomomorphism(Sm,verts);
    gr:=Image(hom);
    xs:=Set(s,x->Position(verts,x));
    h:=Stabilizer(gr,xs,OnSets);
    return PreImage(hom,h);
end;

if not IsBound(n) then n:=9; fi;

perm:=Product(List([1..(n-1)/2],i->(2*i-1,2*i)));
Sn:=SymmetricGroup(n);
gra:=Graph(Sn,Elements(perm^Sn),OnPoints,function(x,y) return CycleLengths(x/y,[1..n])=[n]; end);;
cs:=CompleteSubgraphs(gra,n,2);; Size(cs);

for c in cs do
    ts:=Set(VertexNames(gra){c});
    h_graph_stab:=Stabilizer(AutGroupGraph(gra),c,OnSets);
    h_coll:=sharply_tr_set_autgroup(ts);
    h_Sn_stab:=sharply_tr_set_autgroup_2(ts);
    Print("gen group = ",StructureDescription(Group(ts)),"\t");
    Print("graph aut stab group = ",StructureDescription(h_graph_stab),"\t");
    Print("coll group = ",StructureDescription(h_coll),"\t");
    Print("Sn_stab group = ",StructureDescription(h_Sn_stab),"\t");
    Print("\c\n");
od;


extend:=function(p) return p*(Difference([1..n],MovedPoints(p))[1],n+1); end;
for c in cs do
    ts:=Set(VertexNames(gra){c});
    Apply(ts,extend);
    Print(StructureDescription(Group(ts/ts[1])),"\t");
    Print(Collected(List(ts/ts[1],x->CycleLengths(x,[1..n]))),"\n");
    l:=LoopByRightSection(Union([()],ts));
    Print(StructureDescription(AutomorphismGroup(l)),"\n");
od;

