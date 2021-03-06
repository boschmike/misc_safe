clear all;
clc;

addpath cnn_library;
addpath MNIST;

rng(1);

% Variables:
alpha = 0.01;
beta = 0.95;

% Learning data aquisition:
Images = loadMNISTImages('./MNIST/t10k-images.idx3-ubyte');
Images = reshape(Images,28,28,[]);
Labels = loadMNISTLabels('./MNIST/t10k-labels.idx1-ubyte');
Labels(Labels == 0) = 10;   % 0 --> 10


% Learning:
W1 = 1e-2*randn([9 9 20]);
W5 = (2*rand(100,2000)-1)*sqrt(6)/sqrt(360+2000);
Wo = (2*rand( 10, 100)-1)*sqrt(6)/sqrt( 10+ 100);

X = Images(:,:,1:8000);
D = Labels(1:8000);

for epoch = 1 : 3
   
    [W1, W5, Wo] = trainConvMinst(W1, W5, Wo, X, D, alpha, beta);
    
end

save('MnistConv.mat');

% Test:
X = Images(:,:,8001:10000);
D = Labels(8001:10000);

acc = 0;
N = length(D);
for k = 1:N
    
    % Get input data:
    x  = X(:,:,k);                      % input         28x28
    
    % Calculate trough whole net:
    y1 = doConv(x,W1);                  % convolution   20x20x20
    y2 = reLUfcn(y1);                   %
    y3 = doPool(y2);                    % pool          10x10x20
    y4 = reshape(y3,[],1);              %               2000
    v5 = W5*y4;                         %               360
    y5 = reLUfcn(v5);                   %
    v  = Wo*y5;                         %
    y  = softmaxFcn(v);                 % softmax       10
    
    [~,i] = max(y);
    if i == D(k)
       acc = acc + 1; 
    end
    
end

acc = acc / N;
fprintf('Accuracy is %f\n',acc);

% %% check single pic:
% nr = 234;
% 
% % Get input data:
% x  = X(:,:,nr);                      % input         28x28
% 
% % Calculate trough whole net:
% y1 = doConv(x,W1);                  % convolution   20x20x20
% y2 = reLUfcn(y1);                   %
% y3 = doPool(y2);                    % pool          10x10x20
% y4 = reshape(y3,[],1);              %               2000
% v5 = W5*y4;                         %               360
% y5 = reLUfcn(v5);                   %
% v  = Wo*y5;                         %
% y  = softmaxFcn(v);                 % softmax       10
% 
% [~,i] = max(y);
% 
% % Image viewer:
% img = X(:,:,nr);
% imshow(img)
% label = D(nr);
