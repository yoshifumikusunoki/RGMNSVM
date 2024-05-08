function pca_projection = RBF_PCA(X,s,dim)

eps = 1e-12;
m = size(X,2);

X = X/s;

xx = sum(X.^2,1)';
D = xx*ones(1,m) - 2*(X.')*X + ones(m,1)*xx';
G = exp(-D/2);

v = sum(G,2)/m;
G = G - v*ones(1,m) - ones(m,1)*v' + sum(v)/m*ones(m,1)*ones(1,m);

G = (G+G')/2;

% [EV,ED] = eig(G);
% [~,I_ED] = sort(diag(ED),'descend');
% ED = ED(I_ED(1:min(dim,m)),I_ED(1:min(dim,m)));
% EV = EV(:,I_ED(1:min(dim,m)));

[EV,ED] = eigs(G,dim);
ED = diag(ED);

nz_ED = find(ED>eps);
PC = (ED(nz_ED).^(-1/2)*ones(1,size(EV,1))).*EV(:,nz_ED)';

pca_projection = @(Y) projection(Y/s,X,PC,v);
end

function Z = projection(Y,X,PC,v)
k = size(Y,2);
m = size(X,2);
yy = sum(Y.^2,1)';
xx = sum(X.^2,1)';
D = xx*ones(1,k) - 2*(X')*Y + ones(m,1)*yy';
G = exp(-D/2);
Z = PC*G - PC*v*ones(1,k) - sum(PC,2)*sum(G,1)/m + sum(v)/m*sum(PC,2)*ones(1,k);
end