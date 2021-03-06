function y = doPool(x)

% 2x2 mean pooling

[xrow, xcol, numFilters] = size(x);

y = zeros(xrow/2,xcol/2,numFilters);
filter = ones(2)/(2*2);  % for mean

for k = 1 : numFilters
    
    image = conv2(x(:,:,k),filter,'valid');
    y(:,:,k) = image(1:2:end,1:2:end);
    
end

end