function [u] = inpainting_MicheleWyss(g,omega,lambda)

% input: g: single gray scaled image
%        omega: mask
% lambda: parameter % output: u: inpainted image


size1 = size(g,1);
size2 = size(g,2);
alpha = 0.01;
u = g; % initial guess


cost_function(1) = (lambda/2) * norm(reshape(omega.*(u-g),size1*size2,1))^2 + norm(reshape(makeGradient(u),size1*size2,1))^2;

iterations = 10000;
for i = 1:iterations
    if (mod(i,1000) == 0)
        i
    end
   
    gradient_term_x = - 2 * [u(:,2:end) u(:,end-1)] + 4*u - 2 * [u(:,2) u(:,1:end-1)];
    gradient_term_y = - 2 * [u(2:end,:); u(end-1,:)] + 4*u - 2 * [u(2,:); u(1:end-1,:)];
    gradient_term = gradient_term_x + gradient_term_y;
    u = u - alpha*(lambda * (omega.*(u-g)) + gradient_term);
    cost_function(i+1) = (lambda/2) * norm(reshape(omega.*(u-g),size1*size2,1))^2 + norm(reshape(makeGradient(u),size1*size2,1))^2;
end
plot(cost_function)
end