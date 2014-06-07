%approximates the proportion of lattices of Voronoi's first kind

clear all;

%add java libraries in lib folder to matlab
javaclasspath('./lib/PubSim.jar');
javaaddpath('./lib/JGraphT.jar');
javaaddpath('./lib/Jama-1.0.3.jar');
javaaddpath('./lib/bignums.jar');
javaaddpath('./lib/flanagan.jar');
javaaddpath('./lib/junit-4.11.jar');
javaaddpath('./lib/RngPack.jar');
javaaddpath('./lib/colt.jar');
javaaddpath('./lib/jtransforms-2.4.jar');
addpath('./matlab') %add the matlab functions we will use

%javaclasspath('-dynamic')

L = 500; %number of Monte-Carlo trials
Ns = [1,2,3,4,5]; %the dimensions we will run simulations for

%start simulations for uniform, gaussian and MIMO matrices
disp('uniform');
puniform = runmontecarlo( @(n) rand(n), Ns, L ); 
disp('gaussian');
pgaussian = runmontecarlo( @(n) randn(n), Ns, L ); 
disp('mimo');
pmimo = runmontecarlo( @(n) randomMIMOmatrix(n), Ns, L ); 


plot(Ns, puniform, '.r'); hold on;
plot(Ns, pgaussian, 'sb'); hold on;
plot(Ns, pmimo, 'xg'); hold on;

