function [div] = makeDiv(x)
% input:    x is a MxNx2-matrix. In the case of this project, 
%           it contains the gradient of an MxN gray scale image.
%
% output:   div is a MxN-matrix containing the divergence. 
%           In the case of this project it contains 
%           d^2/dx^2 + d^2/dy^2
   term1 = makeGradient(x(:,:,1));
   term1 = term1(:,:,1);
      
   term2 = makeGradient(x(:,:,2));
   term2 = term2(:,:,2);

   div = term1 + term2; 
end

