# -
Intelligent diagnosis of lymph node metastasis in rectal cancer

内容说明：

1.直肠肿瘤分割。 首先转为二值图像，然后使用8邻域区域生长算法，提取特征使用特征进一步分割得到掩模图像。最后使用DICE评价系数评价结果。

2.分割得到的掩模图像。由于上传文件大小限制，所给内容为B题示例数据中的5位病人的arterial phase的CT图像经过分割算法得到的结果。

3.特征提取。特征提取函数，分别对示例图像和所有图像进行特征提取，得到总共包含Contrast,Correlation,Energy,Homogeneity,means,std2s,areas,radis,eccentricity,MajorAxisLength,LBP和zhuanyi12个特征。其中，LBP特征包含18个数值。

4提取得到的特征。由特征提取程序提取得到的特征，得到总共包含Contrast,Correlation,Energy,Homogeneity,means,std2s,areas,radis,eccentricity,MajorAxisLength,LBP和zhuanyi12个特征。其中，LBP特征包含18个数值。

5.基于提取的特征使用分类器分类。使用FineKNN算法和BaggedTrees8算法对提取到的特征进行分类。

6.神经网络程序。使用AlexNet对掩模图像进行特征提取。使用AlexNet对掩膜图像进行迁移学习
