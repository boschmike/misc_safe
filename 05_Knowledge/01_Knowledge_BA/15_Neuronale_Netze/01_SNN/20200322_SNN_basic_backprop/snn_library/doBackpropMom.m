function [W1, W2] = doBackpropMom(W1, W2, X, D, alpha, beta)

mmt1 = zeros(size(W1));
mmt2 = zeros(size(W2));

for a = 1 : numel(D)
    
    x = X(a,:)';                        % get current (transp.) input row
    d = D(a);                           % get current output row
    
    v1 = W1*x;                          % get weighted sum of IL
    y1 = sigmoid(v1);                   % do activation function
    
    v = W2*y1;                          % get weighted sum of HL1
    
    y = sigmoid(v);                     % do activation function
    e     = d - y;                      % get current error of OL
    delta = y.*(1-y).*e;                % get delta of OL
    
    e1     = W2'*delta;                 % get current error of of HL1 
    delta1 = y1.*(1-y1).*e1;            % get delta of HL1
    
    dW1 = alpha*delta1*x';              % get updated weight1 matrix
    mmt1 = dW1 + beta*mmt1;             % update momentum1 matrix
    W1  = W1 + mmt1;                    % update weight1 matrix
    
    dW2 = alpha*delta*y1';              % get updated weight2 matrix
    mmt2 = dW2 + beta*mmt2;             % update momentum2 matrix
    W2  = W2 + mmt2;                    % update weight2 matrix
    
end

end
