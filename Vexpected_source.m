function Vex=Vexpected_source(I,X,Xsource,Nv)
     Vex=Nv*(Xsource-X(:,I))/norm(Xsource-X(:,I));     
end