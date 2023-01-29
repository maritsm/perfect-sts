# 7, 9, 25, 33 || 79, 139, 367, 811, 1531, 25771, 50923, 61339, and 69991


for g in AllTransitiveGroups(NrMovedPoints,33) do 
    Print(
        g,
        " :: ", 
        Size(g),
        " :: ",
        Filtered(
            OrbitLengths(g,Combinations([1..NrMovedPoints(g)],3),OnSets),
            y->y<=NrMovedPoints(g)*(NrMovedPoints(g)-1)/6
        ),
        "\n"
    ); 
od;

# returns a list [s1,...,sk] such that Sum(li{si})=n
sum_to_n:=function(n,li)
    local k,r1,r2;
    if ForAny(li,x->x<=0) then
        Error("bad imput");
    fi;
    if n<0 then return []; fi;
    if li=[] then 
        if n=0 then 
            return [[]];
        else
            return []; 
        fi;
    fi;
    k:=Length(li);
    r1:=List(sum_to_n(n-li[k],li{[1..k-1]}),x->Concatenation(x,[k]));
    r2:=sum_to_n(n,li{[1..k-1]});
    return Concatenation(r2,r1);
end;

###

LoadPackage("inci");
LoadPackage("pag");

is_perfect_sts_wrt_block:=function(s,b)
    local bls;
    bls:=BlocksOfIncidenceStructure(s);
    bls:=List(b,a->List(Filtered(bls,x->b<>x and a in x),y->Difference(y,[a])));
    bls:=List(bls,x->Product(x,y->(y[1],y[2])));
    bls:=List(Combinations(bls,2),x->Product(x));
    return ForAll(bls,x->Order(x)=NrMovedPoints(x)/2);
end;

is_perfect_sts:=function(s)
    local bls;
    bls:=List(Orbits(AutomorphismGroup@IncidenceStructures(s),BlocksOfIncidenceStructure(s),OnSets), x->x[1]);
    return ForAll(bls,x->is_perfect_sts_wrt_block(s,x));
end;

#g:=Group(CyclicPermutation(33));

gr_set:=AllPrimitiveGroups(NrMovedPoints,25);
#gr_set:=AllPrimitiveGroups(NrMovedPoints,37,Size,37);
for g in gr_set do
    d:=KramerMesnerSearch(2,NrMovedPoints(g),3,1,g);;
    incs:=[];
    for x in d do
        bls:=Union(List(x,y->Orbit(g,y,OnSets)));
        ist:=IncidenceStructureByBlocks([1..NrMovedPoints(g)],bls);
        if ForAll(incs,x->fail=Isomorphism@IncidenceStructures(x,ist)) then
            Add(incs,ist);
        fi;
        Unbind(bls);
    od;
    Print("gr = ", g, "   |incs| = ",Size(incs),"\n");
    result:=Filtered(incs,is_perfect_sts);
    if result<>[] then Print("# HIT!!\n"); break; fi;
od;

###
LoadPackage("inci");
LoadPackage("grape");

is_perfect_sts_wrt_block:=function(s,b)
    local bls;
    bls:=BlocksOfIncidenceStructure(s);
    bls:=List(b,a->List(Filtered(bls,x->b<>x and a in x),y->Difference(y,[a])));
    bls:=List(bls,x->Product(x,y->(y[1],y[2])));
    bls:=List(Combinations(bls,2),x->Product(x));
    return ForAll(bls,x->Order(x)=NrMovedPoints(x)/2);
end;

is_perfect_sts:=function(s)
    local bls;
    bls:=List(Orbits(AutomorphismGroup@IncidenceStructures(s),BlocksOfIncidenceStructure(s),OnSets), x->x[1]);
    return ForAll(bls,x->is_perfect_sts_wrt_block(s,x));
end;

g:=PrimitiveGroup(121,1);
oo1:=OrbitsDomain(g,Combinations([1..NrMovedPoints(g)],3),OnSets);;
oo2:=Filtered(oo1,x->ForAll(x,y->Size(Intersection(x[1],y))<>2));;
oo3:=Set(oo2,Set);;
gra:=Graph(g,oo3,OnSetsSets,function(x,y) return x<>y and ForAll(y,u->Size(Intersection(u,x[1]))<2); end);;
gra2:=NewGroupGraph(AutomorphismGroup(gra),gra);;
nb:=121*(121-1)/6;
cs0:=CompleteSubgraphsOfGivenSize(gra,nb,0,true,true,List(VertexNames(gra),Size));
bls:=Union(VertexNames(gra){cs0[1]});;
s:=IncidenceStructureByBlocks([1..121],bls);
Size(AutomorphismGroup@IncidenceStructures(s));
is_perfect_sts(s);

#cs:=CompleteSubgraphsOfGivenSize(gra,nb,1,true,true,List(VertexNames(gra),Size));
