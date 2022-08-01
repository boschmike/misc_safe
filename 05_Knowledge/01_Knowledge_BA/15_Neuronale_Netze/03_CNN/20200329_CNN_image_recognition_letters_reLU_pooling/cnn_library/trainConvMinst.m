function [W1, W5, Wo] = trainConvMinst(W1, W5, Wo, X, D, alpha, beta)

momentum1 = zeros(size(W1));
momentum5 = zeros(size(W5));
momentumo = zeros(size(Wo));

N = length(D);

bsize = 100;
blist = 1:bsize:(N-bsize+1);

% One epoch loop:
for batch = 1 : length(blist)
    
    dW1 = zeros(size(W1));
    dW5 = zeros(size(W5));
    dWo = zeros(size(Wo));
    
    % Mini-batch loop:
    begin    = blist(batch);
    for mini = begin : (begin+bsize-1)
 
        % Forward pass = inference
        x  = X(:,:,mini);                   % input         28x28
        y1 = doConv(x,W1);                  % convolution   20x20x20
        y2 = reLUfcn(y1);                   %
        y3 = doPool(y2);                    % pool          10x10x20
        y4 = reshape(y3,[],1);              %               2000
        v5 = W5*y4;                         %               360
        y5 = reLUfcn(v5);                   %
        v  = Wo*y5;                         %
        y  = softmaxFcn(v);                 % softmax       10
        
        % One-hot encoding:
        d = zeros(10,1);
        d(sub2ind(size(d),D(mini),1)) = 1;
        
        % Backpropagation:
        e      = d - y;                     % get current error of OL
        delta  = e;                         % get delta of OL
        
        e5     = Wo'*delta;                 % get current error of HL5
        delta5 = d_reLUfcn(y5).*e5;         % get delta of HL5
        
        e4     = W5'*delta5;                % get current error of HL4
        
        e3     = reshape(e4,size(y3));
        
        e2     = zeros(size(y2));
        W3     = ones(size(y2))/(2*2);
        for c = 1:20
            e2(:,:,c) = kron(e3(:,:,c),ones([2 2])).*W3(:,:,c);
        end
        
        delta2 = d_reLUfcn(y2).*e2;
        
        delta1_x = zeros(size(W1));         % HL1
        for c = 1:20
            delta1_x(:,:,c) = conv2(x(:,:),rot90(delta2(:,:,c),2),'valid');
        end
        
        dW1 = dW1 + delta1_x;
        dW5 = dW5 + delta5*y4';
        dWo = dWo + delta *y5';
        
    end
    
    % Update weights:
    dW1 = dW1 / bsize;
    dW5 = dW5 / bsize;
    dWo = dWo / bsize;
    
    momentum1 = alpha*dW1 + beta*momentum1;
    W1 = W1 + momentum1;
    
    momentum5 = alpha*dW5 + beta*momentum5;
    W5 = W5 + momentum5;
    
    momentumo = alpha*dWo + beta*momentumo;
    Wo = Wo + momentumo;
    
end

end