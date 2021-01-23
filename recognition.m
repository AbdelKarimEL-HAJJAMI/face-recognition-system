clear;
close all;
load data;
load eigenfaces;

% Seuil de reconnaissance a regler convenablement
s = 2e+04;

% Pourcentage d'information 
per = 0.95;

% Nombre N de composantes principales a prendre en compte 
% [dans un second temps, N peut etre calcule pour atteindre le pourcentage
% d'information avec N valeurs propres] :
N = min(2, nb_individus*nb_postures-1);
K = min(3, nb_postures); % Nombre de plus proches voisins
matrice_confusion = false;

% N premieres composantes principales des images d'apprentissage :
C = X_c*W;
C = C(:, 1:N); % On ne garde que les N premières composantes principales
    
if ~matrice_confusion
    figure('Name','Image tiree aleatoirement','Position',[0.2*L,0.2*H,0.6*L,0.5*H]);

    % Tirage aleatoire d'une image de test :
    %individu = randi(37)
    individu = numeros_individus(randi(length(numeros_individus)));
    posture = randi(6);
    chemin = './dataset';
    fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg']
    Im=importdata(fichier);
    I=rgb2gray(Im);
    I=im2double(I);
    image_test=I(:)'; 

    % Affichage de l'image de test :
    colormap gray;
    imagesc(I);
    axis image;
    axis off;

    % N premieres composantes principales de l'image de test :
    C_test = (image_test-individu_moyen.') * W;
    C_test = C_test(:, 1:N); % On ne garde que les N premières composantes principales

    % Determination de l'image d'apprentissage la plus proche (plus proche voisin) :
    d = []; % Vecteur des distances
    for i = 1:nb_individus*nb_postures
        d = [d, sqrt(sum((C(i, :) - C_test(1, :)).^2))];
    end
    kmin = mink(d, K);
    ppv = find(d <= max(kmin)); % Plus proche voisin
    if K == 1
        ppv_d = d(ppv); % Distance au plus proche voisin
        individu_reconnu = numeros_individus(floor((ppv-1)/nb_postures)+1);
    else
        k_individus = zeros(nb_individus, 1);
        for i = 1:K
            indice_indiv = floor((ppv(i)-1)/nb_postures)+1;
            k_individus(indice_indiv) = 1 + k_individus(indice_indiv);
        end
        individu_reconnu = numeros_individus(find(k_individus == max(k_individus)));
    end

    % Affichage du resultat :
    if K > 1 || ppv_d <= s
        title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
            ['Je reconnais l''individu numero ' num2str(individu_reconnu)]},'FontSize',20);
        %title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
        %	['Je reconnais l''individu numero ' num2str(individu_reconnu+3)]},'FontSize',20);
    else
        title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu)];...
            'Je ne reconnais pas cet individu !'},'FontSize',20);
        %title({['Posture numero ' num2str(posture) ' de l''individu numero ' num2str(individu+3)];...
        %	'Je ne reconnais pas cet individu !'},'FontSize',20);
    end
else
   % Calcul de la matrice de confusion
    Conf = zeros(nb_individus);
    for indice_individu = 1:nb_individus
        for posture = 1:6
            individu = numeros_individus(indice_individu);

            fichier = [chemin '/' num2str(individu+3) '-' num2str(posture) '.jpg'];
            Im=importdata(fichier);
            I=rgb2gray(Im);
            I=im2double(I);
            image_test=I(:)';

            C_test = (image_test-individu_moyen.') * W;
            C_test = C_test(:, 1:N); % On ne garde que les N premières composantes principales

            d = []; % Vecteur des distances
            for i = 1:nb_individus*nb_postures
                d = [d, sqrt(sum((C(i, :) - C_test(1, :)).^2))];
            end
            kmin = mink(d, K);
            ppv = find(d <= max(kmin)); % Plus proche voisin

            k_individus = zeros(nb_individus, 1);
            for i = 1:K
                indice_indiv = floor((ppv(i)-1)/nb_postures)+1;
                k_individus(indice_indiv) = 1 + k_individus(indice_indiv);
            end
            indice_reconnu = find(k_individus == max(k_individus));
            individu_reconnu = numeros_individus();

            Conf(indice_individu, indice_reconnu) = Conf(indice_individu, indice_reconnu) + 1;
        end
    end
    
    Conf
    taux_erreur = (sum(Conf, 'all') - sum(diag(Conf))) / (nb_individus*6);
    fprintf("Taux d'erreur = %0.3f\n", taux_erreur);
end







