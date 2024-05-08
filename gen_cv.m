function gen_cv(lX,n,cv)
m = numel(lX);
ts = cell(1,n);
for j=1:n
    t = train_label(lX,cv);
    tt = ones(m,cv);
    tt(sub2ind([m,cv],1:m,t')) = 0;
    ts{j} = tt;
end
assignin('base',strcat('T_',num2str(n),'cv',num2str(cv)),ts);
end

function t = train_label(l,cv)
p = max(l);
m = numel(l);
t = zeros(m,1);
for j=1:p
    s = sum(l==j);
    rp = randperm(s);
    tj = zeros(s,1);
    for i=1:cv
        lb = round(s*(i-1)/cv)+1;
        ub = round(s*i/cv);
        tj(rp(lb:ub)) = i;
    end
    t(l==j) = tj;
end
end