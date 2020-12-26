%EM算法的E step，X表示数据矩阵，model表示模型结构体，R表示返回的隶属度矩阵，llh表示似然函数的目标值
function [R, llh] = expectation(X, model)
mu = model.mu;
Sigma = model.Sigma;
w = model.w;                           %w为MoG的混合系数向量

n = size(X,2);                         %n为样本个数
k = size(mu,2);                        %k为MoG混合成分的个数，即类别个数
R = zeros(n,k);                        %R隶属度矩阵，行数为样本个数，列数为类别个数，第ij个元素表示第i个样本由第j个成分生成的概率
for i = 1:k                            %计算样本的每个gauss概率的对数
    R(:,i) = loggausspdf(X,mu(:,i),Sigma(:,:,i));
end
R = bsxfun(@plus,R,log(w));            %计算隶属度（未归一化）矩阵的对数
T = logsumexp(R,2);                    %对R取指数加和再取对数
llh = sum(T)/n; % loglikelihood        %似然函数的均值
R = exp(bsxfun(@minus,R,T));           %计算隶属度矩阵