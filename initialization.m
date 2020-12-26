function R = initialization(X, init)   %X是数据矩阵，init用于初始化MoG的成分，R返回的是一个n行k列的矩阵，第ij个元素表示第i个样本由第j个成分生成的概率
n = size(X,2);                         %n是样本个数
if isstruct(init)  % init with a model %isstruct判断输入是否是一个matlab结构体
    R  = expectation(X,init);          %如果init是一个结构体，直接用该模型进行E step
elseif numel(init) == 1                %如果init是一个整数
    k = init;                          %用init表示混合成分的个数，即类别个数
    label = ceil(k*rand(1,n));         %ceil用于向数轴的正方向取整，初始化样本的label
    R = full(sparse(1:n,label,1,n,k,n));              %sparse通过记录稀疏矩阵非负元素的索引和值来节省内存，full是一相反作用；R是n行k列矩阵，n表示样本个数，k表示类别数，每一行
                                                      %是一个one-hot向量，表示该样本属于哪一类
elseif all(size(init)==[1,n])  % init with labels     %若init是一个一行n列的向量，则为样本类别的向量
    label = init;
    k = max(label);
    R = full(sparse(1:n,label,1,n,k,n));
else
    error('ERROR: init is not valid.');
end