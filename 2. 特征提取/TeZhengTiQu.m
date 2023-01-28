clc;clear all;close all;
maindir = 'BQuanBuShuJuYanMo\yang';
subdir  = dir( maindir );
zhaopianjishuqi=0;
renshujishuqi=0;
yin="yin";   %�ܰͽ��Ƿ�ת�ƣ����ԣ�����
yang="yang";
% ӳ���
 image_map = get_image_mapping(16, 'riu2');
for i = 1 : length( subdir )
    renshujishuqi=renshujishuqi+1;
    if( isequal( subdir( i ).name, '.' )||...
        isequal( subdir( i ).name, '..')||...
        ~subdir( i ).isdir)               % �������Ŀ¼������
        continue;
    end
    subdirpath = fullfile( maindir, subdir( i ).name, '*.png' );
    dat = dir( subdirpath ) ;              % ���ļ������Һ�׺Ϊpng���ļ�

    for j = 1 : length( dat )
        zhaopianjishuqi=zhaopianjishuqi+1;     %��Ƭ����������
        disp(zhaopianjishuqi);  
        imagepath = fullfile( maindir, subdir( i ).name, dat( j ).name);

        % ���ļ����� 
        ImgSrc=imread(imagepath);
        
        %��ȡͼ��ҶȾ�������
        stats1 =graycoprops(ImgSrc);    %Contrast�Աȶ�,Correlation�����Energy����Homogeneity�����(ͬ����)
        ent=entropy(ImgSrc);             %�Ҷ�ͼ����
        
        %��ȡͼ������
        means=mean2(ImgSrc);             %ͼ���ƽ��ƫ��
        std2s=std2(ImgSrc);              %��׼��    
        
        %��ȡͼ���ά����
        stats = regionprops('table',ImgSrc,'all'); 
        areas=sum(stats.EquivDiameter);    %���
        radis=sum(stats.EquivDiameter)/2;  %��ͬ�����Բ�İ뾶
        eccentricity=sum(stats.Eccentricity); %��Բ��ƫ�Ķ�
        MajorAxisLength=sum(stats.MajorAxisLength); %��Բ������ĳ���(������Ϊ��λ)�������������ͬ�Ĺ�һ���ڶ����ľأ���Ϊ��������
    
        %��ȡLBP����
        [lbp, im] = get_lbp_feather(ImgSrc, 2, 16, image_map, 'hist');

        %�����ݱ����ڱ���
        T(zhaopianjishuqi,:)= table(stats1.Contrast,stats1.Correlation ,stats1.Energy ,stats1.Homogeneity,means,std2s,areas,radis,eccentricity,MajorAxisLength,lbp,yang);
        %ɾ���������Ϊ0���У�����Ӧ��ģͼ��ȫ��Ϊ��ɫ��ͼ��
        toDelete = T.Var7 ==0 ;           
        T(toDelete,:) = [];
          
    end
     
    
end

   %�������������Ϊ��Ӧ��������
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
    writetable(T,'E:\Desktop\shilishuju\yang\tezheng.txt');      %д����tezheng.txt