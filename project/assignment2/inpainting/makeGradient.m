function [ grad ] = makeGradient( x )
   %% construct bigger x_tilde image with mirrored boundaries
   flipH = flipdim(x,2);
   bigH = [flipH(:,end) x];
   
   flipV = flipdim(bigH,1);
   x_big = [ flipV(end,:); bigH];
   
   %% construct gradient based on the enlarged image uNew (big enough s.t. all the necessary indices are available)
   grad = (x_big(2:end,2:end) - x_big(1:end-1,2:end)).^2 + (x_big(2:end,2:end) - x_big(2:end,1:end-1)).^2;
   
   grad = grad + 1e-6;
   grad = grad.^(0.5);
   %grad = grad(2:end-1,2:end-1);
   
   %grad = div;
end

