%%
[X,cmap] = imread('corn.tif');
RGB = ind2rgb(X,cmap);
% B = reshape(A, 390000, 3);
% mu = mean(B);
% B = B - mean(B);
% sigma = std(B);
% B = B./sigma;
% 
% [u s v] = svd(B);
% new_img = u()
figure;
A = RGB;
image(A);
B = A(:,:,1);
[u s v] = svd(double(B));
num = 20;
new_img_1 = u(:,1:num)*s(1:num,1:num)*v(:,1:num)';
s1 = s;
figure;
imshow(new_img_1);

B = A(:,:,2);
[u s v] = svd(double(B));
new_img_2 = u(:,1:num)*s(1:num,1:num)*v(:,1:num)';
s2 = s;
figure;
imshow(new_img_2);

B = A(:,:,3);
[u s v] = svd(double(B));
s3 = s;
new_img_3 = u(:,1:num)*s(1:num,1:num)*v(:,1:num)';
figure;
imshow(new_img_3);
%%
new_img = [];
new_img(:,:,1) = [new_img_1];
new_img(:,:,2) = [new_img_2];
new_img(:,:,3) = [new_img_3];
figure;
imshow(new_img);