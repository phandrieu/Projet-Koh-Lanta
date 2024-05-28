%% Projet Koh Lanta

clear all;

N = 10;
n = 5;

Vrobot=3;

% Définition de l ile

R_ile = 200;
Center_ile = [250; 250];
R_spawn = R_ile -1;
R_pred = 50;
theta_pred = linspace(0, 7*pi/8, n);
theta = linspace(0, 2*pi, 1000);

% Équipe 1 : rouges

Xnrouge = zeros(2,N);     %position des rouges au temps n
Xn1rouge = zeros(2,N);    %position des rouges au temps n+1

Mass1 = zeros(1, N);
Relax1 = zeros(1, N);
Size1 = zeros(1, N);

Mass1(1,:)=70;            %en kg
Relax1(1,:)=0.5;          %en sec
Size1(1,:)=0.70;          %en m

theta_init = linspace(-pi/6, pi/6, N);
Xnrouge(1,:) = Center_ile(1) - R_spawn*cos(theta_init); % Position x fixe à la bordure gauche
Xnrouge(2,:) = Center_ile(2) + R_spawn*sin(theta_init); % Répartir le long du rayon

Vmax = 5;
   
% Équipe 2 : jaunes

Xnjaune = zeros(2,N);     %postion des jaunes au temps n
Xn1jaune = zeros(2,N);    %position des jaunes au temps n+1

Mass2 = zeros(1, N);
Relax2 = zeros(1, N);
Size2 = zeros(1, N);

Mass2(1,:)=70;            %en kg
Relax2(1,:)=0.5;          %en sec
Size2(1,:)=0.70;          %en m

Xnjaune(1,:) = Center_ile(1) + R_spawn*cos(theta_init);       % Position x fixe à la bordure gauche
Xnjaune(2,:) = Center_ile(2) + R_spawn * sin(theta_init);     % Répartir le long du rayon

% Equipe 3 : predateurs

Xnpred = zeros(2,n);      %position des predateurs au temps n
Xn1pred = zeros(2,n);     %position des predateurs au temps n+1

Mass3 = zeros(1, n);
Relax3 = zeros(1, n);
Size3 = zeros(1, n);

Mass3(1,:)=0.1;          %en kg
Relax3(1,:)=0.5;         %en sec
Size3(1,:)=0.01;         %en m

Xnpred(1,:) = Center_ile(1) + R_pred*cos(theta_pred);
Xnpred(2,:) = Center_ile(2) + R_pred*sin(theta_pred);


% Définition du domaine spatial

a = 500;
b = 500;

x = [0:0.1:a];
y = [0:0.1:b];





Bordure_ile_x = Center_ile(1)+R_ile*cos(theta);
Bordure_ile_y = Center_ile(2)+R_ile*sin(theta);


%Définition obstacles disques
NbrDisque=5;
XDisques=[[250;250],[210;270],[180;201],[220;210],[255;200]];
RDisques=[R_ile,5,5,5,5],;

% Définition du domaine temporel

Tfinal = 100;
dt = 0.05;

% Vitesses

Vnrouge=zeros(2,N); %vitesses au temps tn
Vn1rouge=zeros(2,N); %vitesses au temps tn+1
Vexpecrouge=zeros(2,N); %vitesses désirées au temps tn

Vnjaune=zeros(2,N); %vitesses au temps tn
Vn1jaune=zeros(2,N); %vitesses au temps tn+1
Vexpecjaune=zeros(2,N); %vitesses désirées au temps tn

Vnpred=zeros(2,n); %vitesses au temps tn
Vn1pred=zeros(2,n); %vitesses au temps tn+1
Vexpecpred=zeros(2,n); %vitesses désirées au temps tn


% Forces

Force_others1=zeros(2,N);
Force_others2=zeros(2,N);
Force_others3=zeros(2,n);

Force_disque1=zeros(2,N);
Force_disque2=zeros(2,N);
Force_disque3=zeros(2,n);

Force_loc1=zeros(2,N);
Force_loc2=zeros(2,N);
Force_loc3=zeros(2,n);

Force_fuite1=zeros(2,N);
Force_fuite2=zeros(2,N);

%position de la fin

Xfin=[randi([200 300],1,1),randi([200 300],1,1)];

% Initialisation : Positions initiales

%while min(dist)<5


    
%for i in (1,10)
%    dist(i)=abs(norm([Xfin(1)-Xnjaune(1,:),Xfin(2)-Xnjaune(2,:)]))
%    dist(i+N)=abs(norm([Xfin(1)-Xnrouge(1,:),Xfin(2)-Xnrouge(2,:)]))
%     

%Choix du Leader des rouges
Ileader=randi([1, N]);

t=0;
cont=1;

%% Boucle en temps %%%%%%%%%%%%%%%
while (t<Tfinal && not(condition_arret(Xfin, Xnjaune, Xnrouge, N)))
   
    % Calcul du centre de masse
    Gjaune=sum(Xnjaune')'/N; 
    Grouge=sum(Xnrouge')'/N;
    Gpred=sum(Xnpred')'/n;
    
    %%%%%%%%%% Calcul forces interaction Rouge %%%%%%%%%%
    for i=1:N
        %calcul des forces s execant sur robot i
        Force_others1(:,i)=Interaction_robots(i,1,Xnrouge,Xnjaune,Gjaune,Size1,Size2,N,N);
        Force_fuite1(:,i)=Interaction_robot_predateur(i,Xnrouge,Xnpred,Size1,Size3,n);  

        s=zeros(2,1);
        for k=1:NbrDisque
            s=s+Interaction_disque(i,Xnrouge,XDisques(:,k),Size1,RDisques(1,k));
        end
        Force_disque1(:,i)=s;

        %Vitesse expected du robot i
        if i==Ileader
            if count%10==0
                source=(125+randi([125 250],2,1))*rand(2,1);
            end
            Vexpecrouge(:,i)=Vexpected_source(i,Xnrouge,source,Vrobot)
        else
            source=Xnrouge(:,Ileader);
            Vexpecrouge(:,i)=Vexpected_source(i,Xnrouge,source,Vrobot);
        end
    end

    %%%%%%%%%% Calcul forces interaction Jaune %%%%%%%%%%
    for i=1:N
        %calcul des forces s execant sur robot i
        Force_others2(:,i)=Interaction_robots(i,2,Xnrouge,Xnjaune,Gjaune,Size1,Size2,N,N);
        Force_loc2(:,i)=Force_loc(i,Vnjaune);
        Force_fuite2(:,i)=Interaction_robot_predateur(i,Xnjaune,Xnpred,Size2,Size3,n);   
        
        s=zeros(2,1);
        for k=1:NbrDisque
            s=s+Interaction_disque(i,Xnjaune,XDisques(:,k),Size2,RDisques(1,k));
        end
        Force_disque2(:,i)=s;
    end

    %%%%%%%%%% Calcul forces interaction Predateurs %%%%%%%%%%

    for i=1:n
        %calcul des forces s execant sur robot i
        Force_others3(:,i)=Interaction_predateurs(i,Xnpred,Gpred,Size3,n);
        Force_loc3(:,i)=Force_loc(i,Vnpred);

        s=zeros(2,1);
        for k=1:NbrDisque
            s=s+Interaction_disque(i,Xnpred,XDisques(:,k),Size3,RDisques(1,k));
        end
        Force_disque3(:,i)=s;
        
        %Vitesse expected du robot i
        %Vexpec(:,i)=Vexpected_robots(i,Xnpred,Vnpred,source,Vrobot);
    end

    %Itération de la méthode d Euler : Une méthode d Euler pour chaque classe d acteur
    Vn1rouge=Vnrouge + dt * (Force_others1 + Force_disque1 + Force_loc1 + Force_fuite1)./Mass1;
    Vn1jaune=Vnjaune + dt*(Force_others2 + Force_disque2 + Force_loc2 + Force_fuite2)./Mass2;
    Vn1pred=Vnpred + dt*(Vexpecpred-Vnpred)./Relax3 + dt * Force_others3./Mass3 + dt*Force_disque3./Mass3;
    
    %Encadrement de la vitesse pour garantir la convergence
    Vn1jaune=min(2*Vmax,Vn1jaune); 
    Vn1jaune=max(-2*Vmax,Vn1jaune);
    Vn1rouge=min(2*Vmax,Vn1rouge); 
    Vn1rouge=max(-2*Vmax,Vn1rouge);
    Vn1pred=min(2*Vmax,Vn1pred); 
    Vn1pred=max(-2*Vmax,Vn1pred);
  
    %calcul des nouvelles positions

    Xn1jaune=Xnjaune + dt*Vn1jaune;
    Xn1rouge=Xnrouge + dt*Vn1rouge;
    Xn1pred=Xnpred + dt*Vn1pred;
    
    % Affichage
    nbiter=2;
    if mod(cont,nbiter)==0 
        figure(1)
        clf();
        hold on;
        % Afficher le rectangle bleu
        rectangle('Position', [0, 0, a, b], 'FaceColor', 'b');
        % Afficher le disque jaune au milieu
        fill(Bordure_ile_x, Bordure_ile_y, 'g');

        % Afficher arbres
        for k=1:NbrDisque
            fill(XDisques(1,k)+RDisques(k)*cos(theta),XDisques(2,k)+RDisques(k)*sin(theta),'b'); 
        end
        plot(Xn1jaune(1,:),Xn1jaune(2,:),'yo','MarkerSize',5,'MarkerFaceColor','y');
        plot(Xn1rouge(1,:),Xn1rouge(2,:),'ro','MarkerSize',5,'MarkerFaceColor','r');
        plot(Xn1pred(1,:),Xn1pred(2,:),'bo','MarkerSize',5,'MarkerFaceColor','b');
        axis equal;
        xlim([0 a]);
        ylim([0 b]);
        hold off
        drawnow limitrate nocallbacks;
    end 
    Vnjaune=Vn1jaune;
    Vnrouge=Vn1rouge;
    Vnpred=Vn1pred;
    Xnjaune=Xn1jaune;
    Xnrouge=Xn1rouge;
    Xnpred=Xn1pred;
    t=t+dt;
    temps(cont)=t;
    cont=cont+1;
    
end