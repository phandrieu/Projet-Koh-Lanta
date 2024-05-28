function F=Interaction_robots(I,J,X1,X2,Gmasse,Size1,Size2,N1,N2)
%calcul de la force qui s'exerce sur l'individu I de la part des autres et
%du groupe

%constantes multiplicatives devant les forces
CO=0.5;
CG=0.05;

F=[0;0;0];

for l=1:2
    for k=1:eval(['N', num2str(l)])
        if l==J
            if not(k == I)
                l0=5*(eval(['Size', num2str(l)])(I)+eval(['Size', num2str(l)])(k));
                normale=(eval(['X', num2str(l)])(:,I)-eval(['X', num2str(l)])(:,k))/l0;
                d=norm(normale);
            
            F= F + CO*normale*(d^(-3)-d^(-2))*exp(-d);
            end
        else
            l0=5*(eval(['Size', num2str(l)])(I)+eval(['Size', num2str(l)])(k));
            normale=(eval(['X', num2str(l)])(:,I)-eval(['X', num2str(l)])(:,k))/l0;
            d=norm(normale);
            
            F= F + CO*normale*(-d^(-2))*exp(-d);
        end
    end

    F=F+ CG*(Gmasse-X(:,I))/norm(Gmasse-X(:,I))/N;
end
end