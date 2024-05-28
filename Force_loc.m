function F=Force_loc(I,V)
%Force locomotrice
     k=1;
     Vm=0.3;
     F=k*(1-(norm(V(:,I)/Vm)^2))*V(:,I);
end