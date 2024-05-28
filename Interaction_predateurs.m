function F=Interaction_predateurs(I,X,Gmasse,Size,N)
%calcul de la force qui s'exerce sur l'individu I de la part des autres et
%du groupe

%constantes multiplicatives devant les forces
CO=0.5;
CG=0.05;

F=[0;0;0];

for j=1:N
    if not(j == I)
        l0=5*(Size(I)+Size(j));
        normale=(X(:,I)-X(:,j))/l0;
        d=norm(normale);
    
     F= F + CO*normale*(d^(-3)-d^(-2))*exp(-d);
    end
end

 F=F+ CG*(Gmasse-X(:,I))/norm(Gmasse-X(:,I))/N;
 
end
