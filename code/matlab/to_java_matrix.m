function out = to_java_matrix(B)
% to_java_matrix converts the matrix B to a Jama.Matrix
%from the java matrix library
    
out = javaObjectEDT('Jama.Matrix',B);

end