function [ div ] = makeDiv( x )
   %% construct bigger x_tilde image with mirrored boundaries
   flipH = flipdim(x,2);
   bigH = [flipH(:,end) x];
   
   flipV = flipdim(bigH,1);
   x_big = [ flipV(end,:); bigH];
   
   div = (x_big(2:end,2:end) - x_big(1:end-1,2:end)) + (x_big(2:end,2:end) - x_big(2:end,1:end-1));
   div = abs(div);
end

