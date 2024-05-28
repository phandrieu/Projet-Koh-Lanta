function result = condition_arret(Xsource, Xnjaune, Xnrouge, N)
    result=false;
    epsilon = 0.5;
    for i=1:N
        if(norm(Xsource'-Xnjaune(:,i))<0.5)
            result=true;
        end
        if(norm(Xsource'-Xnrouge(:,i))<0.5)
            result=true;
        end
    end
end