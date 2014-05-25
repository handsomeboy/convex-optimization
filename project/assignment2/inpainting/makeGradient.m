function [ grad ] = makeGradient( x )
% input: x is a MxN gray scale image
%
% output: grad: a MxNx2 matrix containing the gradient components in dx and
% dy.

% Comment: I tried to use only forward differences, but the whole thing
% failed because in this case the gradients kind of "shifted" away.
%    grad_1 = x([2:end end],1:end) - x(1:end,1:end);
%    grad_2 = x(1:end,[2:end end]) - x(1:end,1:end);

% So I used centered differences, but this is actually not well suited for
% such applications...
   grad_1 = ((x([2:end end],1:end) - x(1:end,1:end)) + (x(1:end,1:end) - x([1 1:end-1],1:end)))./2;
   grad_2 = (x(1:end, [2:end end]) - x(1:end, 1:end) + x(1:end, 1:end) - x(1:end, [1 1:end-1]))./2;

   grad = zeros([size(x) 2]);
   
   grad(:,:,1) = grad_1;
   grad(:,:,2) = grad_2;
end

