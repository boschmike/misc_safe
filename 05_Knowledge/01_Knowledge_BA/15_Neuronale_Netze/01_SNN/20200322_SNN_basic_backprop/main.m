addpath snn_library;

clear all

X = [0 0 1;
     0 1 1;
     1 0 1;
     1 1 1;
    ];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
D = [1
     0
     0
     1
    ];

nodesHL1 = 4;                               % DEFINE num of nodes in HL1
nodesIL  = size(X,2);                       % get num of IL by input vec 

W1 = 2 * rand(nodesHL1, nodesIL) - 1;       % define weight matrix #1
W2 = 2 * rand(1, nodesHL1)       - 1;       % define weight matrix #2

alpha = 0.9;                                % DEFINE learning factor
beta = 0.9;                                 % DEFINE momentum factor

for epoch = 1:10000                         % train
    [W1, W2] = doBackprop(W1, W2, X, D, alpha);             % w/o mom
    %     [W1, W2] = doBackpropMom(W1, W2, X, D, alpha, beta);    % w/ mom
    %     [W1, W2] = doBackpropCrEntr(W1, W2, X, D, alpha);             % w/o mom
end

y   = nan(numel(D),1);                      % define result vec
y_r = y;                                    % define result vec (rounded)        

for a = 1 : numel(D)                        % inference
   x  = X(a,:)';
   v1 = W1*x;
   y1 = sigmoid(v1);
   v  = W2*y1;
   y(a)   = sigmoid(v);
   y_r(a) = round(y(a));
end
