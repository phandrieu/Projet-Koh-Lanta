function result = condition_arret(Xsource, Xnjaune, Xnrouge, N)
    result=0;
    epsilon = 5;
    for i=1:N
        if(norm(Xsource'-Xnjaune(:,i))<epsilon)
            result=2;
        end
        if(norm(Xsource'-Xnrouge(:,i))<epsilon)
            result=1;
        end
    end
end