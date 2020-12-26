# EM_GMM
EM for GMM, a simple demo
一些数学公式的说明

GMM模型记录</br>
一维高斯混合模型
$$p(x) = \sum_{k=1}^K\alpha_kN(x;\mu_k, \sigma^2_k)$$
其中
$$\sum_{k=1}^K\alpha_k = 1$$
$$N(x;\mu, \sigma^2) = \frac{1}{\sqrt{2\pi}\sigma}e^{-\frac{(x-\mu)^2}{2\sigma^2}}$$
多维高斯混合模型
$$p(\boldsymbol x) = \sum_{k=1}^K\alpha_kN(\boldsymbol x;\boldsymbol{\mu_k}, \Sigma_k)$$
$$N(\boldsymbol x;\boldsymbol{\mu}, \Sigma) = \frac{1}{\sqrt{(2\pi)^N|\Sigma|}}e^{-\frac{1}{2}(\boldsymbol x-\boldsymbol  \mu)^T\Sigma^{-1}(\boldsymbol x-\boldsymbol  \mu)}$$
其中
$$\boldsymbol { \Sigma}_{N\times N} = E[(\boldsymbol x-\boldsymbol  \mu)(\boldsymbol x-\boldsymbol  \mu)^T]$$
$$\boldsymbol { \Sigma}[i, j] = E[(x_i-\mu_i)(x_j-\mu_j)]$$
当角标相同时
$$COV(x_i, x_i) = \Sigma[i,i] = \sigma^2_i = E[(x_i-u_i)^2] = E[x^2_i]-\mu^2_i$$
备注列向量$\boldsymbol x_{N\times 1}$，注意K和N没有必然联系
$$\boldsymbol x = (x_1,x_2,\cdots, x_N)^T$$
备注GMM模型需要估计的参数：第一是个数$K$，每一个$k$对应的向量$\boldsymbol{\mu_k}$和协方差矩阵$\boldsymbol \Sigma_k$





