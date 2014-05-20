function [u] = inpainting_MicheleWyss(g,omega,lambda)
% input:    g: single gray scaled image
%           omega: mask
%           lambda: parameter 
%
% output: u: inpainted image

% initialize
tau = 0.01;
sigma = 1/0.09;

theta = 0.7;

x = g;
y = g;
x_tilde = x;
debug_pos = 0

%iterations
iter = 10000;
h = waitbar(0,'Iterate...');
for i = 1:iter
   waitbar(i/iter);
   grad_x = makeGradient(x_tilde);
   if (i == debug_pos)
       imtool(grad_x)
   end
   
   y_term = y + sigma*grad_x;
   
   norm = sqrt(sum(sum(y_term.^2)));
   y = (y_term)/max(1, norm);
    
   x_old = x;
   grad_y = makeDiv(y);

   x = (x + tau*grad_y + tau*lambda*(omega.*g)) ./ (1 + tau*lambda*omega);
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
















