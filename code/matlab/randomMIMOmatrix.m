function out = randomMIMOmatrix(n)
%randomMIMOmatrix generates a random n by n matrix.  When n
%is even these matrices are commonly used to model multiple
%antenna (MIMO) communication channels

h = ceil(n/2);

R = randn(h);
C = randn(h);

B = [R, -C; C, R];

out = B(1:n, 1:n);

end