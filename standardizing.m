function Y = standardizing(X)
[m,n] = size(X);
mn = mean(X,1);
sd = std(X,0,1);
Y = zeros(size(X));
for i=1:n
    if sd(i) > 0
        Y(:,i) = (X(:,i)-mn(i))/sd(i);
    end
end
end