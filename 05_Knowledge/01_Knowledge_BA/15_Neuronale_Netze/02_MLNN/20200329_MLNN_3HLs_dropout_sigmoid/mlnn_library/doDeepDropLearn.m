function [W1, W2, W3, W4] = doDeepDropLearn(W1, W2, W3, W4, X, D, alpha, dropRate)

for a = 1 : numel(D(1,:))
    
    x = reshape(X(:,:,a),25,1);         % get current input (as row)
    d = D(a,:)';                        % get current output row
    
    v1 = W1*x;                          % get weighted sum of Hl1
    y1 = sigmoidFcn(v1);                % do activation function
    y1 = y1.*dropoutFcn(y1,dropRate);   % do droput on HL1
    
    v2 = W2*y1;                         % get weighted sum of HL2
    y2 = sigmoidFcn(v2);                % do activation function
    y2 = y2.*dropoutFcn(y2,dropRate);   % do droput on HL2
    
    v3 = W3*y2;                         % get weighted sum of HL3
    y3 = sigmoidFcn(v3);                % do activation function
    y3 = y3.*dropoutFcn(y3,dropRate);   % do droput on HL3
    
    v = W4*y3;                          % get weighted sum of OL
    y = softmaxFcn(v);                  % do activation function
    
    e     = d - y;                      % get current error of OL
    delta = e;                          % get delta of OL
    
    e3     = W4'*delta;                 % get current error of HL3
    delta3 = y3.*(1-y3).*e3;            % get delta of HL3
    
    e2     = W3'*delta3;                % get current error of HL2 
    delta2 = y2.*(1-y2).*e2;            % get delta of HL2
    
    e1     = W2'*delta2;                % get current error of HL1 
    delta1 = y1.*(1-y1).*e1;            % get delta of HL1
    
    dW4 = alpha*delta*y3';              % get updated weight4 matrix
    W4  = W4 + dW4;                     % update weight4 matrix
    
    dW3 = alpha*delta3*y2';             % get updated weight3 matrix
    W3  = W3 + dW3;                     % update weight3 matrix
    
    dW2 = alpha*delta2*y1';             % get updated weight2 matrix
    W2  = W2 + dW2;                     % update weight2 matrix
    
    dW1 = alpha*delta1*x';              % get updated weight1 matrix
    W1  = W1 + dW1;                     % update weight1 matrix
    
end

end
