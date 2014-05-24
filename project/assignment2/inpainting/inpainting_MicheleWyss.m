function [u] = inpainting_MicheleWyss(g,omega,lambda)
% input:    g: single gray scaled image
%           omega: mask
%           lambda: parameter 
%
% output: u: inpainted image

% initialize
tau = 0.1;
sigma = 1/0.08;

theta = 0.5;

x = g;
y = zeros(size(g,1), size(g,2), 2);
x_tilde = x;
debug_pos = 1

%iterations
iter = 100;
h = waitbar(0,'Iterate...');
for i = 1:iter
   waitbar(i/iter);
   grad_x = makeGradient(x_tilde);
     
   if (i == debug_pos)
       imtool(grad_x(:,:,1));
       imtool(grad_x(:,:,2));
       imtool(grad_x(:,:,1) + grad_x(:,:,2));
   end
   
   y_term = y + sigma*grad_x;
   
   norm = sqrt(y_term(:,:,1).^2 + y_term(:,:,2).^2);
   y(:,:,1) = y_term(:,:,1)./max(1, norm);
   y(:,:,2) = y_term(:,:,2)./max(1, norm);
   
   x_old = x;
   div_y = makeDiv(y);

   x = (x + tau*div_y + tau*lambda*(omega.*g)) ./ (1 + tau*lambda*omega);
   if (i == debug_pos)
       diff = abs(x-x_old);
       imtool(diff);
   end
   x_tilde = x + theta * (x - x_old);
   
   if (i == debug_pos)
       imtool(x_tilde);
   end
   
end
close(h);
u = x_tilde;
















