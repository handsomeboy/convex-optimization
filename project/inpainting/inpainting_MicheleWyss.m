function [u] = inpainting_MicheleWyss(g,omega,lambda)

% input: g: single gray scaled image
%        omega: mask
% lambda: parameter % output: u: inpainted image

alpha = 0.0001;
delta = 1e-6;
u = g; % initial guess

iterations = 100;
cost = zeros(1,iterations);
h = waitbar(0,'Iterate...');
for i = 1:iterations
   waitbar(i/iterations)   
   %% construct bigger u image with mirrored boundaries
    uNew = zeros(size(u) + [4 4]);
    uNew(3:end-2,3:end-2) = u; % the indices from 3 to end-2 will contain the original image

    uNew(2,3:end-2) = u(2,:);
    uNew(1,3:end-2) = u(1,:);

    uNew(end-1,3:end-2) = u(end-1,:);
    uNew(end,3:end-2) = u(end-2,:);

    uNew(:,2) = uNew(:,4);
    uNew(:,1) = uNew(:,5);

    uNew(:,end-1) = uNew(:,end-3);
    uNew(:,end) = uNew(:,end-4);
    
   %% construct tau based on the enlarged image uNew (big enough s.t. all the necessary indices are available)
   tau = (uNew(3:end,2:end-1) - uNew(2:end-1,2:end-1)).^2 + (uNew(2:end-1,3:end) - uNew(2:end-1,2:end-1)).^2;
   deriv_for_cost_function = sum(sum(tau(2:end-1,2:end-1).^(0.5)));
   tau = tau + delta;
   tau = tau.^(0.5);
 

   %% gradient term
   gradient_term_1 = (2*uNew(3:end-2,3:end-2) - uNew(4:end-1,3:end-2)  - uNew(3:end-2,4:end-1))./tau(2:end-1,2:end-1);
   gradient_term_2 = (uNew(3:end-2,3:end-2) - uNew(2:end-3,3:end-2))./tau(1:end-2,2:end-1);
   gradient_term_3 = (uNew(3:end-2,3:end-2) - uNew(3:end-2,2:end-3))./tau(2:end-1,1:end-2);
   
   gradient_term = gradient_term_1 + gradient_term_2 + gradient_term_3;

   %% update u
   u = u - alpha*(lambda * (omega.*(u-g)) + gradient_term);
   
   %% compute cost function
   cost(i) = lambda/2 * sum(sum((omega.*((u-g).^2))))+deriv_for_cost_function;
   
end
close(h); 
plot(cost);
end