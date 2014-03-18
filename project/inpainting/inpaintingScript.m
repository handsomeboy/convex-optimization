
clear all;
close all;
clc;

im = im2single(rgb2gray(imread('grumpycat.jpeg')));

% mask
omega = ones(size(im));
omega(195:209,31:134) = 0;
omega(31:65,166:194) = 0;

% create input image
g = im.*omega;


lambda = 100;

uG = inpainting_MicheleWyss(g,omega,lambda);

figure;
disp = [uG, (uG-im).^2; ...
        im, g];
imshow(disp);