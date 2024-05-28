function Fiw = Interaction_disque(I,X,Xdisque,Size,Rdisque)
    A=3000;
    B=0.3;
    if norm(X(:,I)-Xdisque) > Rdisque
        diw=norm(X(:,I)-Xdisque) - Rdisque;
        Niw=(X(:,I)-Xdisque)/norm(X(:,I)-Xdisque);
    else
        diw=Rdisque - norm(X(:,I)-Xdisque);
        Niw=(Xdisque-X(:,I))/norm(X(:,I)-Xdisque);
    end
    
    Fiw=A*exp((Size(I)-diw)/B)*Niw;
end