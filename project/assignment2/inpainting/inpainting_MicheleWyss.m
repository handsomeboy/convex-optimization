function [u] = inpainting_MicheleWyss(g,omega,lambda)
% input:    g: single gray scaled image
%           omega: mask
%           lambda: parameter 
%
% output: u: inpainted image

% initialize parameters according to description in the report.
tau = 0.01;
sigma = 1/0.09;

theta = 0.5;

x = g;
y = ones([size(g) 2]);
x_tilde = x;

% iterate
iter = 2000;
h = waitbar(0,'Iterate...');
cost = zeros(iter,1);
for i = 1:iter
   waitbar(i/iter);
   
   % primal update y^{n+1}
   grad_x = makeGradient(x_tilde);
   
   y_term = y + sigma*grad_x;
   
   norm = sqrt(y_term(:,:,1).^2 + y_term(:,:,2).^2);
   y(:,:,1) = y_term(:,:,1)./max(1, norm);
   y(:,:,2) = y_term(:,:,2)./max(1, norm);

   % keep x for extragradient step
   x_old = x;
   
   % dual update x^{n+1}
   div_y = makeDiv(y);
   x = (x + tau*div_y + tau*lambda*(omega.*g)) ./ (1 + tau*lambda*omega);

   % compute leading points from extragradient step (see [CP11], Section
   % 3.1)
   x_tilde = x + theta * (x - x_old);

   % compute cost function (calculate ||grad(x_tilde)|| according to report of
   % assignment 1
   total_var = (x_tilde([2:end end],1:end) - x_tilde(1:end,1:end)).^2 + (x(1:end,[2:end end]) - x(1:end,1:end)).^2;
   deriv_for_cost_function = sum(sum(total_var.^(0.5)));
   cost(i) = lambda/2 * sum(sum((omega.*((x_tilde-g).^2))))+deriv_for_cost_function;
end
close(h);
plot(cost);
u = x_tilde;
















