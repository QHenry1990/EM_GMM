
% test EM_GMM demo

% GMM-EM算法
%% generate data
alpha = [0.3, 0.2, 0.5];
mu = zeros(2, 3);
sigma = zeros(2, 2, 3);
mu(:, 1) = [1.5; 2.5];
mu(:, 2) = [3.5; 1.2];
mu(:, 3) = [4.6; 3.5];
sigma(:,:, 1) = [1.0, 0.0;0.0 1.0];
sigma(:,:, 2) = [1.0, 0.6;0.6 1.0];
sigma(:,:, 3) = [1.0, 0.1;0.1 1.0];

x = -3:0.1:8;
y = -3:0.1:8;
prob = zeros(length(x), length(y));
for i = 1:length(x)
    for j = 1:length(y)
        for k = 1:3
            d1 = det(sigma(:,:, k));
            d2 = inv(sigma(:,:, k));
            vecx = [x(i); y(j)];
            d3 = -0.5*(vecx-mu(:, k)).'*d2*(vecx-mu(:, k));
            prob(i, j) = prob(i, j) + alpha(k)*1/sqrt((2*pi)^2*d1)*exp(d3);
        end
    end
end
figure; mesh(y, x, prob); shading interp;

dx = -3 + (3+8)*rand(1000, 1);
dy = -3 + (3+8)*rand(1000, 1);
dz = 0.1*rand(1000, 1);
figure; plot3(dx, dy, dz, '*');
X = []; ind = 0;
while ind<=5000 
    probxy = 0.0;
    dx = -3 + (3+8)*rand(1, 1);
    dy = -3 + (3+8)*rand(1, 1);
    dz = 0.1*rand(1, 1);
    for k = 1:3
        d1 = det(sigma(:,:, k));
        d2 = inv(sigma(:,:, k));
        vecx = [dx; dy];
        d3 = -0.5*(vecx-mu(:, k)).'*d2*(vecx-mu(:, k));
        probxy = probxy + alpha(k)*1/sqrt((2*pi)^2*d1)*exp(d3);
    end
    
    if (dz<=probxy)
        ind = ind + 1;
        X(ind, :) = [dx, dy];
    end
    disp(ind);
end

figure; plot(X(:, 1), X(:, 2), '*');


% % 多维高斯分布模型-随机数的产生，这样生成有问题
% r1 = mvnrnd(mu(:, 1).', sigma(:,:, 1), 1000);
% r2 = mvnrnd(mu(:, 2).', sigma(:,:, 2), 1000);
% r3 = mvnrnd(mu(:, 3).', sigma(:,:, 3), 1000);
figure; 
plot(r1(:, 1), r1(:, 2), '+');
hold on;
plot(r2(:, 1), r2(:, 2), '*');
plot(r3(:, 1), r3(:, 2), 'o');








%% processing data
% row = dimension, column = samples
init = 3;
[label, model, llh] = mixGaussEm(X.', init);
