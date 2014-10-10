clear all;

%add java libraries in lib folder to matlab
javaclasspath('./../lib/PubSim.jar');
javaaddpath('./../lib/JGraphT.jar');
javaaddpath('./../lib/Jama-1.0.3.jar');
javaaddpath('./../lib/bignums.jar');
javaaddpath('./../lib/flanagan.jar');
javaaddpath('./../lib/junit-4.11.jar');
javaaddpath('./../lib/RngPack.jar');
javaaddpath('./../lib/colt.jar');
javaaddpath('./../lib/jtransforms-2.4.jar');

B = [4,3,sqrt(2),1; 
     5,-1,3,10;
     5,4,1,-1;
     1,2,2,1];
fck = javaObjectEDT('pubsim.lattices.firstkind.FirstKindCheck',to_java_matrix(B));
fck.isFirstKind