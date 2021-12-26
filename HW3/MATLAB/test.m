function svm(C,P)
%
%   C How many c you want to do (default 10)
%   P Until what power you want (defaul 5)
%
global p1;
ct=10;
pt=5;
if (nargin == 1)
    ct=C;
end
if (nargin == 2)
    ct=C;
    pt=P;
end
kkk={'linear','poly','rbf'};
load('dataset.mat');
ind = crossvalind('Kfold', 100, 2);
xtr = X(ind ==1,:);
xtest = X(ind ==2,:);
ytr = Y(ind ==1,:);
ytest = Y(ind ==2,:);
lknsv = zeros(ct);
lkbias = zeros(ct);
lkerr = zeros(ct);
pksvn = zeros(1,ct*pt);
pkbias = zeros(1,ct*pt);
rksvn = zeros(1,ct*pt);
rkbias = zeros(1,ct*pt);
for indi = 1:length(kkk)
    switch kkk{indi}
        case 'linear'
            for c = 1:ct
                [lknsv(c),alpha,lkbias(c)] = svc(xtr,ytr,'linear',c);
        %        %predY = svcoutput(xtr,ytr,xtest,'linear',alpha,lkbias(c));
                lkerr(c) = svcerror(xtr,ytr,xtest,ytest,'linear',alpha,lkbias(c))
        %        [lrnsv(c),alpha,lrbias(c)] = svr(xtr,ytr,'linear',c);
        %        lrerr(c) = svrerror(xtr,xtest,ytest,'linear',alpha,lrbias(c))
            end
            figure
            plot (lkerr);
            ylabel('Error')
            xlabel('C upper bound')
            print -depsc linear.eps;
        case 'poly'
            n=1;
            for c = 1:ct
                for p=1:pt
                    p1 = p;
                    [pksvn(n),alpha,pkbias(n)] = svc(xtr,ytr,'poly',c);
                    %predY = svcoutput(xtr,ytr,xtest,'poly',alpha,pkbias(c));
                    pkerr(p,c) = svcerror(xtr,ytr,xtest,ytest,'poly',alpha,pkbias(n));
                    %[prnsv(n),alpha,prbias(n)] = svr(xtr,ytr,'linear',c);
                    %lrerr(n) = svrerror(xtr,xtest,ytest,'linear',alpha,prbias(n))
                    n = n+1;
                end
            end
            figure
            surf(pkerr)
            ylabel('Dimension')
            xlabel('C upper bound')
            zlabel('Error')
            print -depsc polynomial.eps;
        case 'rbf'
            n=1;
            for c = 1:ct
                for p=1:pt
                    p1 = p;
                    [rknsv(n),alpha,rkbias(n)] = svc(xtr,ytr,'rbf',c);
                    %predY = svcoutput(xtr,ytr,xtest,'rbf',alpharp,bias(c));
                    rkerr(p,c) = svcerror(xtr,ytr,xtest,ytest,'rbf',alpha,rkbias(n));
                    %[rrnsv(n),alpha,rrbias(n)] = svr(xtr,ytr,'linear',c);
                    %rrerr(n) = svrerror(xtr,xtest,ytest,'linear',alpha,rrbias(n))
                    n=n+1;
                end
            end
            figure
            surf(rkerr)
            ylabel('Sigma')
            xlabel('C upper bound')
            zlabel('Error')
            print -depsc rbf.eps;
    end
end
end