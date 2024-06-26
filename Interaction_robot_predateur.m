function F = Interaction_robot_predateur(I,X,Xpred,Size,SizePred,Npred)
A=50000;
B=2;

F=[0;0];

for j=1:Npred
    d=norm(X(:,I)-Xpred(:,j));
    r=Size(I)+SizePred(j);
    n=(X(:,I)-Xpred(:,j))/d;

    F=F+A*exp((r-d)/B)*n;
end
end