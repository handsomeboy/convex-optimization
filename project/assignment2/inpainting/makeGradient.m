function [ grad ] = makeGradient( x )
   %% construct bigger x_tilde image with mirrored boundaries
   flipH = flipdim(x,2);
   bigH = [flipH(:,end) x];
   
   flipV = flipdim(bigH,1);
   x_big = [ flipV(end,:); bigH];
   
   %% construct gradient based on the enlarged image uNew (big enough s.t. all the necessary indices are available)
   grad_1 = x_big(2:end,2:end) - x_big(1:end-1,2:end);
   grad_2 = x_big(2:end,2:end) - x_big(2:end,1:end-1);
   
   grad = zeros(size(x,1), size(x,2), 2);
   
   grad(:,:,1) = grad_1;
   grad(:,:,2) = grad_2;
   %grad = grad + 1e-6;
   %grad = grad.^(0.5);
   %grad = grad(2:end-1,2:end-1);
   
   %grad = div;
end

