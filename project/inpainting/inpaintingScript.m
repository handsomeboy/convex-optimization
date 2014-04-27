
clear all;
% close all;
clc;

im = im2single(rgb2gray(imread('Figures/hat.jpg')));
im = imresize(im, [250 215]); % not needed for grumpycat.jpeg
% mask
omega = ones(size(im));
omega(175:189,11:114) = 0;
omega(31:65,166:194) = 0;

% create input image
size(im)
size(omega)
% imtool(omega);
g = im.*omega;


lambda = 500;

% for lambda = 10:10:1990
[uG, cost] = inpainting_MicheleWyss(g,omega,lambda);
% ssd = sum(sum((uG-im).^2));
%     ssd(lambda) = sum(sum((uG-im).^2));
%     lambda
% end
% vec = [10:10:1990];
% plot(vec,ssd(10:10:1990));


% figure;
% hold on;
% plot(ssd); title('Grumpy cat'); xlabel('\lambda'); ylabel('SSD');
% [min,idx] = min(ssd);
% plot(idx,0:100);

% figure;
% disp = [uG, (uG-im).^2; ...
%         im, g];
% imshow(disp);
% plot(cost_la);
imtool(uG)