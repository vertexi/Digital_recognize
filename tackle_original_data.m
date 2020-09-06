temp_imgs = [];
parfor n = 1:30000
    temp = imgs(:,:,n);
    temp_imgs(n,:) = temp(:);
end