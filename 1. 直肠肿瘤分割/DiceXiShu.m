% test all segmentation metric functions
SEG = imread('C:\Users\15545\Desktop\qiegelaoshi\1034\20081.png');
GT = imread('C:\Users\15545\Desktop\B题\15224420925u\B题示例数据\CT影像\1034\arterial phase\20081_mask.png');

% binarize
SEG = im2bw(SEG, 0.1);
GT = im2bw(GT, 0.1);

dr = Dice_Ratio(SEG, GT);
dr
function dr = Dice_Ratio(SEG, GT)
    % SEG, GT are the binary segmentation and ground truth areas, respectively.
    % dice ratio
    dr = 2*double(sum(uint8(SEG(:) & GT(:)))) / double(sum(uint8(SEG(:))) + sum(uint8(GT(:))));
end