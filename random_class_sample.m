function t = random_class_sample(lX,ratio)
p = max(lX);
m = numel(lX);
t = zeros(m,1);
for i=1:p
    Ii = find(lX==i);
    mi = numel(Ii);
    idx = randperm(mi,min(mi,floor(ratio*mi)));
    t(Ii(idx)) = 1;
end
end