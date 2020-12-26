%EM算法的M step，X表示数据矩阵，R表示隶属度矩阵，第ij个元素表示第i个样本由第j个成分生成的概率，model是结构体，表示模型，其属性是模型的参数
function model = maximization(X, R)
[d,n] = size(X);                                    %d表示样本维数，n表示样本个数
k = size(R,2);                                      %k表示MoG成分的个数
nk = sum(R,1);                                      %nk表示求隶属度矩阵R的列和
w = nk/n;                                           %w表示混合成分系数               
mu = bsxfun(@times, X*R, 1./nk);                    %mu是一个m行k列的矩阵，表示k个高斯成分的期望，每个都是m元随机变量

Sigma = zeros(d,d,k);                               %Sigma是一个三维张量，表示第k个高斯成分的协方差矩阵是d*d的
r = sqrt(R);
for i = 1:k                                         %循环计算每个成分的协方差
    Xo = bsxfun(@minus,X,mu(:,i));
    Xo = bsxfun(@times,Xo,r(:,i)');
    Sigma(:,:,i) = Xo*Xo'/nk(i)+eye(d)*(1e-6);
end

model.mu = mu;
model.Sigma = Sigma;
model.w = w;