clc;clear all;close all;
maindir = 'BQuanBuShuJuYanMo\yang';
subdir  = dir( maindir );
zhaopianjishuqi=0;
renshujishuqi=0;
yin="yin";   %淋巴结是否转移，阴性，阳性
yang="yang";
% 映射表
 image_map = get_image_mapping(16, 'riu2');
for i = 1 : length( subdir )
    renshujishuqi=renshujishuqi+1;
    if( isequal( subdir( i ).name, '.' )||...
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % 如果不是目录则跳过
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, '*.png' );
    dat = dir( subdirpath ) ;              % 子文件夹下找后缀为png的文件

    for j = 1 : length( dat )
        zhaopianjishuqi=zhaopianjishuqi+1;     %照片个数计数器
        disp(zhaopianjishuqi);  
        imagepath = fullfile( maindir, subdir( i ).name, dat( j ).name);

        % 对文件操作 
        ImgSrc=imread(imagepath);
        
        %获取图像灰度矩阵特征
        stats1 =graycoprops(ImgSrc);    %Contrast对比度,Correlation互相关Energy能量Homogeneity齐次性(同质性)
        ent=entropy(ImgSrc);             %灰度图像熵
        
        %获取图像特征
        means=mean2(ImgSrc);             %图像的平均偏差
        std2s=std2(ImgSrc);              %标准差    
        
        %获取图像二维特征
        stats = regionprops('table',ImgSrc,'all'); 
        areas=sum(stats.EquivDiameter);    %面积
        radis=sum(stats.EquivDiameter)/2;  %相同面积的圆的半径
        eccentricity=sum(stats.Eccentricity); %椭圆的偏心度
        MajorAxisLength=sum(stats.MajorAxisLength); %椭圆的主轴的长度(以像素为单位)，与区域具有相同的归一化第二中心矩，作为标量返回
    
        %获取LBP特征
        [lbp, im] = get_lbp_feather(ImgSrc, 2, 16, image_map, 'hist');

        %将数据保存在表中
        T(zhaopianjishuqi,:)= table(stats1.Contrast,stats1.Correlation ,stats1.Energy ,stats1.Homogeneity,means,std2s,areas,radis,eccentricity,MajorAxisLength,lbp,yang);
        %删除表中面积为0的行，即对应掩模图像全部为黑色的图像
        toDelete = T.Var7 ==0 ;           
        T(toDelete,:) = [];
          
    end
     
    
end

   %保存表，将列名改为对应的特征名
    T.Properties.VariableNames{'Var1'} = 'Contrast';
    T.Properties.VariableNames{'Var2'} = 'Correlation';
    T.Properties.VariableNames{'Var3'} = 'Energy';
    T.Properties.VariableNames{'Var4'} = 'Homogeneity';
    T.Properties.VariableNames{'Var5'} = 'means';
    T.Properties.VariableNames{'Var6'} = 'std2s';
    T.Properties.VariableNames{'Var7'} = 'areas';
    T.Properties.VariableNames{'Var8'} = 'radis'; 
    T.Properties.VariableNames{'Var9'} = 'eccentricity'; 
    T.Properties.VariableNames{'Var10'} = 'MajorAxisLength';
    T.Properties.VariableNames{'Var11'} = 'LBP';
    T.Properties.VariableNames{'Var12'} = 'zhuanyi';
    writetable(T,'E:\Desktop\shilishuju\yang\tezheng.txt');      %写出表tezheng.txt