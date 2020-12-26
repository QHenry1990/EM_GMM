function [label, model, llh] = mixGaussEm(X, init)
% Perform EM algorithm for fitting the Gaussian mixture model.
% Input: 
%   X: d x n data matrix
%   init: k (1 x 1) number of components or label (1 x n, 1<=label(i)<=k) or model structure
% Output:
%   label: 1 x n cluster label
%   model: trained model structure
%   llh: loglikelihood
% Written by Mo Chen (sth4nth@gmail.com).
%% init
fprintf('EM for Gaussian mixture: running ... \n');
tol = 1e-6;
maxiter = 500;
llh = -inf(1,maxiter);
R = initialization(X,init);
for iter = 2:maxiter
    [~,label(1,:)] = max(R,[],2);      %label表示1*n的类别向量
    R = R(:,unique(label));            % remove empty clusters，unique输出label向量中不重复的元素，表示非空类别向量    
    model = maximization(X,R);         %EM算法的M step，X表示数据矩阵，R表示类别矩阵，model是结构体，表示模型，其属性是模型的参数
    [R, llh(iter)] = expectation(X,model);            %EM算法的E step，X表示数据矩阵，model表示模型结构体，R表示返回的隶属度矩阵，llh表示似然函数的目标值
    if abs(llh(iter)-llh(iter-1)) < tol*abs(llh(iter))
        break; 
    end
end
llh = llh(2:iter);