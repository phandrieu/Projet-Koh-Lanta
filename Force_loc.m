function F=Force_loc(I,V)
%Force locomotrice
     k=100;
     Vm=10;
     F=k*(1-(norm(V(:,I)/Vm)^2))*V(:,I);
end