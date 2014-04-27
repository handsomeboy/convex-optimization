
clear all;
close all;
clc;

im = im2single(rgb2gray(imread('Figures/hat.jpg')));
im = imresize(im, [250 215]); % not needed for grumpycat.jpeg

% mask
omega = ones(size(im));
omega(175:189,11:114) = 0;
omega(31:65,166:194) = 0;

% create input image
g = im.*omega;

% apply inpainting method
lambda = 53;
uG = inpainting_MicheleWyss(g,omega,lambda);

% display results
figure;
disp = [uG, (uG-im).^2; ...
        im, g];
imshow(disp);