function grad = makeGradient(img)

gradient_x = [img(:,2:end) img(:,end-1)] - [img(:,2) img(:,1:end-1)];
gradient_y = [img(2:end,:); img(end-1,:)] - [img(2,:); img(1:end-1,:)];
grad = (gradient_x + gradient_y)./2;
