function result = condition_arret(Xsource, Xnjaune, Xnrouge, N)
    result=false;
    epsilon = 10;
    for i=1:N
        if(norm(Xsource'-Xnjaune(:,i))<epsilon)
            result=true;
        end
        if(norm(Xsource'-Xnrouge(:,i))<epsilon)
            result=true;
        end
    end
end