function [ div ] = makeDiv( x )
   term1 = makeGradient(x(:,:,1));
   term1 = term1(:,:,1);
   
   term2 = makeGradient(x(:,:,2));
   term2 = term2(:,:,2);
   
   div = term1 + term2;   
end

