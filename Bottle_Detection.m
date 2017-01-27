%% Siddhartha Dhiman

%% Clearing Workspace
clc;
clear all;
close all;

%% Read Image
I = imread('Q1.tif');
figure, imshow(I), axis image, title('Original Image')

%% Apply Gaussian Filter for Noise Removal
ave = fspecial('gaussian',3,1);
I_ave = imfilter(I, ave);
figure, imshow(I_ave), axis image, title('Noise Removal by Gaussian Filter');

%% Define Coordinates of Rectangle Encompassing Each Bottle
Bottle1 = [74.5 0.5 122 341];
Bottle2 = [195.5 0.5 120 341];
Bottle3 = [315.5 0.5 118 341];
Bottle_Matrix = [Bottle1; Bottle2; Bottle3];

%% Crop Image
I_crop1 = imcrop(I_ave, Bottle1);
I_crop2 = imcrop(I_ave, Bottle2);
I_crop3 = imcrop(I_ave, Bottle3);

%% Threshold Each Bottle
thresh1 = multithresh(I_crop1, 2);
seg_crop1 = imquantize(I_crop1, thresh1,[0 1 0]);
thresh2 = multithresh(I_crop2, 2);
seg_crop2 = imquantize(I_crop2, thresh2,[0 1 0]);
thresh3 = multithresh(I_crop3, 2);
seg_crop3 = imquantize(I_crop3, thresh3,[0 1 0]);

%% Plot Thresholded Bottle
figure;
subplot(131), imshow(seg_crop1), axis image, title('Water in Bottle 1');
subplot(132), imshow(seg_crop2), axis image, title('Water in Bottle 2');
subplot(133), imshow(seg_crop3), axis image, title('Water in Bottle 3');

%% Compute Area of Liqid in Each Bottle
Area1 = struct2cell(regionprops(seg_crop1 ,'Area'));
Area2 = struct2cell(regionprops(seg_crop2, 'Area'));
Area3 = struct2cell(regionprops(seg_crop3, 'Area'));

%% Calculate Average Area of Liquid
Area_Matrix = cell2mat(horzcat(Area1, Area2, Area3));
Area_ave = mean(Area_Matrix);

%% Loop Function to Detect Partially Empty Bottles
for i = 1:3
   if Area_Matrix(i) < Area_ave
       figure, imshow(I), axis image, title(['Bottle ' num2str(i) ' is Partially Filled'])
       hold on
       rectangle('Position', Bottle_Matrix(i,:), 'Curvature', 0.4, 'EdgeColor', 'r', 'LineWidth', 3);
       hold off
   end
end