function gen_foldout(lX,ratio)
h = 10;
n = 100;
cvs = [5,10];
m = numel(lX);
train = zeros(m,n);
for j=1:n
    train(:,j) = train_label_ratio(lX,ratio/100);
end
T = cell(1,n);
for cv=cvs
    for j=1:n
        t = train(:,j);
        Tcv = cell(1,h);
        for l=1:h
            tt = zeros(m,cv);
            ttt = train_label_cv(lX(t==1),cv);
            tt(t==1,:) = ttt;
            Tcv{l} = tt;
        end
        T{j}.t = t;
        T{j}.Tcv = Tcv;
    end
    assignin('base',strcat('T_',num2str(n),'ratio',num2str(ratio),'_',num2str(h),'cv',num2str(cv)),T);
end
end

function t = train_label_cv(l,cv)
p = max(l);
m = numel(l);
t = ones(m,cv);
for j=1:p
    I = find(l==j);
    s = numel(I);
    I = I(randperm(s));
    for i=1:cv
        lb = round(s*(i-1)/cv)+1;
        ub = round(s*i/cv);
        t(I(lb:ub),i) = 0;
    end
end
end

function t = train_label_ratio(l,ratio)
p = max(l);
m = numel(l);
t = zeros(m,1);
for j=1:p
    I = find(l==j);
    s = numel(I);
    t(I(randperm(s,min(s,floor(ratio*s))))) = 1;
end
end