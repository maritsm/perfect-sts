LoadPackage("grape");
LoadPackage("digraph");
LoadPackage("loops");

if not IsBound(n) then n:=13; fi;
Print(n,"\t",Factorial(n+1)/2^((n+1)/2)/Factorial((n+1)/2),"\n");

extend:=function(p) return p*(Difference([1..n],MovedPoints(p))[1],n+1); end;
shorten:=function(p) return p*(n+1,(n+1)^p); end;

ncyc:=PermList(List([0..n-1],i->(i+1) mod (n))+1);
smallinv:=Product(List([1..(n-1)/2],i->(2*i-1,2*i)));
biginv:=extend(smallinv);

count:=1;
