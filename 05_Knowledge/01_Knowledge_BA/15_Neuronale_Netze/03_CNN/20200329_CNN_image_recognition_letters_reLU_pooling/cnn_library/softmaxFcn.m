function y = softmaxFcn(x)

ex = exp(x);
y = ex / sum(ex);

end