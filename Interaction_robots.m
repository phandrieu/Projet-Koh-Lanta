function F=Interaction_robots(I,J,X1,X2,Gmasse,Size1,Size2,N1,N2)
%calcul de la force qui s exerce sur l individu I de la part des autres et
%du groupe

%constantes multiplicatives devant les forces
CO=50;
CG=0.25;

F=[0;0];

if J==1
    for k=1:N1
        if not(k == I)
                l0=5*(Size1(I)+Size1(k));
                normale=(X1(:,I)-X1(:,k))/l0;
                d=norm(normale);
            
            F= F + CO*normale*(d^(-3)-d^(-2))*exp(-d);
        end
    end
    for k=1:N2
        l0=5*(Size1(I)+Size1(k));
        normale=(X1(:,I)-X2(:,k))/l0;
        d=norm(normale);
            
        F= F + CO*normale*(-d^(-2))*exp(-d);
    end

    %F=F+ CG*(Gmasse-X1(:,I))/norm(Gmasse-X1(:,I))/N1;

else
    for k=1:N2
        if not(k == I)
                l0=5*(Size2(I)+Size2(k));
                normale=(X2(:,I)-X2(:,k))/l0;
                d=norm(normale);
            
            F= F + CO*normale*(d^(-3)-d^(-2))*exp(-d);
        end
    end
    for k=1:N1
        l0=5*(Size2(I)+Size2(k));
        normale=(X2(:,I)-X1(:,k))/l0;
        d=norm(normale);
            
        F= F + CO*normale*(-d^(-2))*exp(-d);
    end

    F=F+ CG*(Gmasse-X2(:,I))/norm(Gmasse-X2(:,I))/N2;
end
end