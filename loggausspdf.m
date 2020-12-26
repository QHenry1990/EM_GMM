function y = loggausspdf(X, mu, Sigma)              %计算Gauss概率分布函数的对数的函数，输入变量分别为数据X，期望mu，期望协方差Sigma
d = size(X,1);                                      %d表示样本维数
X = bsxfun(@minus,X,mu);                            %样本与均值作差
[U,p]= chol(Sigma);                                 %chol表示将协方差矩阵Sigma进行一个上三角矩阵分解，U表示上三角因子矩阵，Sigma=U'的逆与U作积（将协方差矩阵分解求逆加快计算效率）
if p ~= 0                                           %如果p不为0则Sigma不是正定矩阵，报错
    error('ERROR: Sigma is not PD.');
end
Q = U'\X;                                           %Q=U'的逆与X的乘积
q = dot(Q,Q,1);  % quadratic term (M distance)      %dot表示点乘之后求列和
c = d*log(2*pi)+2*sum(log(diag(U)));   % normalization constant
y = -(c+q)/2;