function [u] = inpainting_MicheleWyss(g,omega,lambda)
% input:    g: single gray scaled image
%           omega: mask
%           lambda: parameter 
%
% output: u: inpainted image

% initialize
tau = 0.01;
sigma = 10;

theta = 0.5;

x = zeros(size(g));
y = zeros([size(g) 2]);
x_tilde = x;

%iterations
iter = 500;
h = waitbar(0,'Iterate...');
for i = 1:iter
   waitbar(i/iter);
   
   grad_x = makeGradient(x_tilde);
   
   y_term = y + sigma*grad_x;
   
   norm = sqrt(y_term(:,:,1).^2 + y_term(:,:,2).^2);
   y(:,:,1) = y_term(:,:,1)./max(1, norm);
   y(:,:,2) = y_term(:,:,2)./max(1, norm);

   x_old = x;
   div_y = makeDiv(y);
   x = (x + tau*div_y + tau*lambda*(omega.*g)) ./ (1 + tau*lambda*omega);

   x_tilde = x + theta * (x - x_old);
end
close(h);
u = x_tilde;
















