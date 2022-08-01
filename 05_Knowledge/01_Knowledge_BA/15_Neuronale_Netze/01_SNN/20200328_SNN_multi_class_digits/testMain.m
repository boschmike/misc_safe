addpath mlnn_library;

clear all

main;

X = zeros(5,5,5);

X(:,:,1) = [0 0 0 0 0;
            0 1 1 0 0;
            0 0 1 0 0;
            0 0 1 0 0;
            0 0 1 0 0;
           ];
       
X(:,:,2) = [1 1 1 1 0;
            0 0 0 0 1;
            0 1 1 1 0;
            1 0 0 0 0;
            1 1 1 1 1;
           ];
       
X(:,:,3) = [1 1 1 1 0;
            0 0 0 0 1;
            1 1 1 1 1;
            0 0 0 0 1;
            1 1 1 1 0;
           ];
       
X(:,:,4) = [0 0 0 1 0;
            0 0 1 1 0;
            0 1 0 1 0;
            1 1 1 1 1;
            0 0 0 1 0;
           ];
       
X(:,:,5) = [0 1 1 1 1;
            1 0 0 0 0;
            1 1 1 0 0;
            0 0 1 0 0;
            1 1 1 0 0;
           ];
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
D = [1 0 0 0 0;
     0 1 0 0 0;
     0 0 1 0 0;
     0 0 0 1 0;
     0 0 0 0 1;
    ];

nodesHL1 = 50;                              % DEFINE num of nodes in HL1
nodesIL  = numel(X(:,:,1));                 % get num of IL by input vec
nodesOL  = numel(D(1,:));                   % get num of OL by output vec

y   = nan(numel(D(1,:)),nodesOL);           % define result vec
y_r = y;                                    % define result vec (rounded)        

for a = 1 : numel(D(1,:))                   % inference
    x = reshape(X(:,:,a),25,1);             % get current input (as row)
    d = D(a,:)';                            % get current output row
    v1 = W1*x;                              % get weighted sum of IL
    y1 = sigmoidFcn(v1);                    % do activation function
    v = W2*y1;                              % get weighted sum of HL1
    y(a,:) = softmaxFcn(v);                 % do activation function
    y_r(a,:) = round(y(a,:));
end
