clear;
clc;
close all;
srcFace = 'C:\Users\15545\Desktop\shiliPNG\1034';%被读取文件的存放目录（根据自己需要更改设置）
fileSavePath='C:\Users\15545\Desktop\baocun1\1034';%文件保存目录（根据自己需要更改设置）
src=srcFace;
srcsuffix='.png';%被读取的文件名后缀（根据被读取文件的实际文件类型设置）
srcsuffixSave='.png';%保存文件名后缀（根据自己需要更改设置）
files = dir(fullfile(src, strcat('*', srcsuffix)));
geshu=length(files);  %geshu保存文件个数
for file_i= 1 : length(files)
    disp(file_i);%显示当前处理的文件序号
    srcName = files(file_i).name;
    noSuffixName = srcName(1:end-4);
    srcName1=files(file_i).name;
    pathImgName=sprintf('%s%s%s',src,'\',srcName1);
    ImgSrc=imread(pathImgName);%读入图像
    
[Iout,intensity,fitness,time]=segmentation(ImgSrc(:,:,2),10,'pso');

[m,n]=size(Iout);

for i=1:m
    for j=1:n
        if Iout(i,j)~=intensity(5)& Iout(i,j)~=intensity(6)
            J(i,j)=0;
        else
            J(i,j)=1;%Iout(i,0000000000000000000000000000000000000000000000000000000 j);
        end
    end
end
 
 %保存处理后的文件
savePathName=sprintf('%s%s%s%s',fileSavePath,'\',noSuffixName,srcsuffixSave);
        imwrite(J,savePathName);
end