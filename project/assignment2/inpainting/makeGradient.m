function [ grad ] = makeGradient( x )
% input: x is a MxN gray scale image
%
% output: grad: a MxNx2 matrix containing the gradient components in dx and
% dy.
%
% Comment: I tried to use only forward differences, but the whole thing
% failed because in this case the gradients kind of "shifted" away. Is this
% a general problem, or should I have tried something smarter? Matlab's
% gradient function produces a centered difference approximation of the
% gradient, but I actually thought that this is not suited for such
% applications...
[grad_1 grad_2] = gradient(x);
grad = zeros(size(x));
grad(:,:,1 ) = grad_1;
grad(:,:,2 ) = grad_2;

end

