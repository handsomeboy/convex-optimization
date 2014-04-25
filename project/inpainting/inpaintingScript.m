
clear all;
close all;
clc;

im = im2single(rgb2gray(imread('hat.jpg')));
im = imresize(im, [250 215]);
% mask
omega = ones(size(im));
omega(175:189,11:114) = 0;
omega(31:65,166:194) = 0;

% create input image
size(im)
size(omega)
% imtool(omega);
g = im.*omega;


lambda = 10000;

uG = inpainting_MicheleWyss(g,omega,lambda);

figure;
disp = [uG, (uG-im).^2; ...
        im, g];
imshow(disp);