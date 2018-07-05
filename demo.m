
clc;close all;clear all;addpath(genpath('./'));
%%
filename = 'test.jpg';
L = (im2double(imread(filename)));

post = false;

para.lambda = 0.15;
para.sigma = 2;
para.gamma = 0.8;
tic
[I, T_ini,T_ref] = LIME(L,para);
toc

figure(1);imshow(L);title('Input');
figure(2);imshow(I);title('LIME');
figure(3);imshow(T_ini,[]);colormap hot;title('Initial T');
figure(4);imshow(T_ref,[]);colormap hot;title('Refined T');
%% Post Processing
if post
YUV = rgb2ycbcr(I);
Y = YUV(:,:,1);

sigma_BM3D = 50;
[~, Y_d] = BM3D(Y,Y,sigma_BM3D,'lc',0);

I_d = ycbcr2rgb(cat(3,Y_d,YUV(:,:,2:3)));
I_f = (I).*repmat(T_ref,[1,1,3])+I_d.*repmat(1-T_ref,[1,1,3]);

figure(5);imshow(I_d);title('Denoised ');
figure(6);imshow(I_f);title('Recomposed');
end
