close all
clear all
clc
%training on waves1
AB=imread('AB_Waves1.jpg');     
CD=imread('CD_Waves1.jpg');
EF=imread('EF_Waves1.jpg');
ultimateimage=[AB, CD, EF];      %merge images into one
ultbw=rgb2gray(ultimateimage)<200;
ulabel=bwlabel(ultbw);
features1=regionprops(ulabel, "Image", "Centroid", "BoundingBox");


for k=1:length(features1)
    B=features1(k).Image;
    m00=0;
    m01=0;
    m11=0;
    m10=0;
    m02=0;
    m20=0;
    m12=0;
    m21=0;
    m03=0;
    m30=0;
    width = size(B,2);
    height = size(B,1);
    
    for x = [1:width]
        for y = [1:height]
            m00 = m00 + B(y,x)*x^0*y^0;
            m01 = m01 + B(y,x)*x^0*y^1;
            m11 = m11 + B(y,x)*x^1*y^1;
            m10 = m10 + B(y,x)*x^1*y^0;
            m02 = m02 + B(y,x)*x^0*y^2;
            m20 = m20 + B(y,x)*x^2*y^0;
            m12 = m12 + B(y,x)*x^1*y^2;
            m21 = m21 + B(y,x)*x^2*y^1;
            m03 = m03 + B(y,x)*x^0*y^3;
            m30 = m30 + B(y,x)*x^3*y^0;
        end
    end
    
    Xs=m10/m00;
    Ys=m01/m00;
    M20=m20-(m10^2/m00);
    M02=m02-(m01^2/m00);
    M11=m11-(m01*m10/m00);
    M30=m30-3*m20*Xs+2*m10*Xs^2;
    M03=m03-3*m02*Ys+2*m01*Ys^2;
    M21=m21-2*m11*Xs-m20*Ys+2*m01*Xs^2;
    M12=m12-2*m11*Ys-m02*Xs+2*m10*Ys^2;
    features1(k).M20 = M20;
    features1(k).M02 = M02;
    features1(k).M11 = M11;
    features1(k).M30 = M30;
    features1(k).M03 = M03;
    features1(k).M21 = M21;
    features1(k).M12 = M12;

    N00 = 1;
    N01 = 0;
    N10 = 0;
    N20 = M20 / m00^2;
    N02 = M02 / m00^2;
    N12 = M12 / m00^((3/2)+1);
    N21 = M21 / m00^((3/2)+1);
    N03 = M03 / m00^((3/2)+1);
    N30 = M30 / m00^((3/2)+1);
    N11 = M11 / m00^2;

    features1(k).N00=N00;
    features1(k).N01=N01;
    features1(k).N10=N10;
    features1(k).N20=N20;
    features1(k).N02=N02;
    features1(k).N12=N12;
    features1(k).N21=N21;
    features1(k).N03=N03;
    features1(k).N30=N30;
    features1(k).N11=N11;

    I0=N20+N02;
    I1=(N20-N02)^2+4*N11^2;
    I2=(N30-3*N12)^2+(3*N21-N03)^2;
    I3=(N30+N12)^2+(N21+N03)^2;
    I4=(N30-3*N12)*(N30+N12)*[(N30+N12)^2-3*(N21*N03)^2];
    I5=(N20-N02)*[(N30+N12)^2-(N21+N03)^2]+4*N11*(N30+N12)*(N21+N03);

    features1(k).I0=I0;
    features1(k).I1=I1;
    features1(k).I2=I2;
    features1(k).I3=I3;
    features1(k).I4=I4;
    features1(k).I5=I5;
end

figure
xlabel('Feature I1')
ylabel('Feature N12')
zlabel('Feature N03')
title('Fig. 1')
hold on

data=[];
for k=1:length(features1)
    f1 = features1(k).I1;
    f2 = features1(k).N12;
    f3 = features1(k).N03;
    x = features1(k).Centroid(1);
    if x >= 4000 & x <= 5000            %Interval on ultimateimage which describes placement of E letters
       plot3(f1,f2,f3,'xr')
       data(k, : ) = [f1, f2, f3, 1];
    else
       plot3(f1,f2,f3,'og')
       data(k, : ) = [f1, f2, f3, 0];
    end
end

%%
%testing on waves2
AB=imread('AB_Waves2.jpg');            
CD=imread('CD_Waves2.jpg');
EF=imread('EF_Waves2.jpg');
ultimateimage=[AB, CD, EF];
ultbw=rgb2gray(ultimateimage)<200;
ulabel=bwlabel(ultbw);
features1=regionprops(ulabel, "Image", "Centroid", "BoundingBox");

for k=1:length(features1)
    B=features1(k).Image;
    m00=0;
    m01=0;
    m11=0;
    m10=0;
    m02=0;
    m20=0;
    m12=0;
    m21=0;
    m03=0;
    m30=0;
    width = size(B,2);
    height = size(B,1);
    for x = [1:width]
        for y = [1:height]
            m00 = m00 + B(y,x)*x^0*y^0;
            m01 = m01 + B(y,x)*x^0*y^1;
            m11 = m11 + B(y,x)*x^1*y^1;
            m10 = m10 + B(y,x)*x^1*y^0;
            m02 = m02 + B(y,x)*x^0*y^2;
            m20 = m20 + B(y,x)*x^2*y^0;
            m12 = m12 + B(y,x)*x^1*y^2;
            m21 = m21 + B(y,x)*x^2*y^1;
            m03 = m03 + B(y,x)*x^0*y^3;
            m30 = m30 + B(y,x)*x^3*y^0;
        end
    end
    Xs=m10/m00;
    Ys=m01/m00;
    M20=m20-(m10^2/m00);
    M02=m02-(m01^2/m00);
    M11=m11-(m01*m10/m00);
    M30=m30-3*m20*Xs+2*m10*Xs^2;
    M03=m03-3*m02*Ys+2*m01*Ys^2;
    M21=m21-2*m11*Xs-m20*Ys+2*m01*Xs^2;
    M12=m12-2*m11*Ys-m02*Xs+2*m10*Ys^2;
    features1(k).M20 = M20;
    features1(k).M02 = M02;
    features1(k).M11 = M11;
    features1(k).M30 = M30;
    features1(k).M03 = M03;
    features1(k).M21 = M21;
    features1(k).M12 = M12;

    N00 = 1;
    N01 = 0;
    N10 = 0;
    N20 = M20 / m00^2;
    N02 = M02 / m00^2;
    N12 = M12 / m00^((3/2)+1);
    N21 = M21 / m00^((3/2)+1);
    N03 = M03 / m00^((3/2)+1);
    N30 = M30 / m00^((3/2)+1);
    N11 = M11 / m00^2;

    features1(k).N00=N00;
    features1(k).N01=N01;
    features1(k).N10=N10;
    features1(k).N20=N20;
    features1(k).N02=N02;
    features1(k).N12=N12;
    features1(k).N21=N21;
    features1(k).N03=N03;
    features1(k).N30=N30;
    features1(k).N11=N11;

    I0=N20+N02;
    I1=(N20-N02)^2+4*N11^2;
    I2=(N30-3*N12)^2+(3*N21-N03)^2;
    I3=(N30+N12)^2+(N21+N03)^2;
    I4=(N30-3*N12)*(N30+N12)*[(N30+N12)^2-3*(N21*N03)^2];
    I5=(N20-N02)*[(N30+N12)^2-(N21+N03)^2]+4*N11*(N30+N12)*(N21+N03);

    features1(k).I0=I0;
    features1(k).I1=I1;
    features1(k).I2=I2;
    features1(k).I3=I3;
    features1(k).I4=I4;
    features1(k).I5=I5;
end

figure
imshow(ulabel)
errorCount = 0;
hold on
errors=0
for k=1:length(features1)
    f1 = features1(k).I1;
    f2 = features1(k).N12;
    f3 = features1(k).N03;
    data2=data(:, 1:3 )-[f1, f2, f3];       %calculating vector between two points
    data3 = [];
    for j=1 : length(data2)
        data3(j) = sqrt(data2(j, 1)^2 + data2(j, 2)^2 + data2(j, 3)^2);     %calculating distance between two points
    end
    data4 = [data3', data( : ,4)];
    K=5;            %amount of rows(which describe neighbours) that program will sort
    q=topkrows(data4, K, 1, 'ascend');      %1- column in which matrix is sorted ascending, from lowest to highest)
    mq=mode(q( : , 2 )) ;       %calculates most common value and if it's 1, it is specific letter
    x = features1(k).Centroid(1);         %decide if letter is E basing on its placement on image
    if x >= 4000 & x <= 5000
       isE=1;
    else
       isE=0;
    end
    if mq == isE   %if mq is equal to isE, it means that kNN solved it correctly and this specific letter is in fact E
       rectangle('Position', features1(k).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 1);   %marks letters assigned correctly
    else
       rectangle('Position', features1(k).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 1);   %marks letters assigned wrongly
       errors=errors+1                                     %calculates errors
    end
end
effectiveness=(1 - errors / length(features1)) * 100        %checks program efficiency

%%
%testing on waves3
AB=imread('AB_Waves3.jpg');           
CD=imread('CD_Waves3.jpg');
EF=imread('EF_Waves3.jpg');
ultimateimage=[AB, CD, EF];
ultbw=rgb2gray(ultimateimage)<200;
ulabel=bwlabel(ultbw);
features1=regionprops(ulabel, "Image", "Centroid", "BoundingBox");

for k=1:length(features1)
    B=features1(k).Image;
    m00=0;
    m01=0;
    m11=0;
    m10=0;
    m02=0;
    m20=0;
    m12=0;
    m21=0;
    m03=0;
    m30=0;
    width = size(B,2);
    height = size(B,1);
    for x = [1:width]
        for y = [1:height]
            m00 = m00 + B(y,x)*x^0*y^0;
            m01 = m01 + B(y,x)*x^0*y^1;
            m11 = m11 + B(y,x)*x^1*y^1;
            m10 = m10 + B(y,x)*x^1*y^0;
            m02 = m02 + B(y,x)*x^0*y^2;
            m20 = m20 + B(y,x)*x^2*y^0;
            m12 = m12 + B(y,x)*x^1*y^2;
            m21 = m21 + B(y,x)*x^2*y^1;
            m03 = m03 + B(y,x)*x^0*y^3;
            m30 = m30 + B(y,x)*x^3*y^0;
        end
    end
    Xs=m10/m00;
    Ys=m01/m00;
    M20=m20-(m10^2/m00);
    M02=m02-(m01^2/m00);
    M11=m11-(m01*m10/m00);
    M30=m30-3*m20*Xs+2*m10*Xs^2;
    M03=m03-3*m02*Ys+2*m01*Ys^2;
    M21=m21-2*m11*Xs-m20*Ys+2*m01*Xs^2;
    M12=m12-2*m11*Ys-m02*Xs+2*m10*Ys^2;
    features1(k).M20 = M20;
    features1(k).M02 = M02;
    features1(k).M11 = M11;
    features1(k).M30 = M30;
    features1(k).M03 = M03;
    features1(k).M21 = M21;
    features1(k).M12 = M12;

    N00 = 1;
    N01 = 0;
    N10 = 0;
    N20 = M20 / m00^2;
    N02 = M02 / m00^2;
    N12 = M12 / m00^((3/2)+1);
    N21 = M21 / m00^((3/2)+1);
    N03 = M03 / m00^((3/2)+1);
    N30 = M30 / m00^((3/2)+1);
    N11 = M11 / m00^2;

    features1(k).N00=N00;
    features1(k).N01=N01;
    features1(k).N10=N10;
    features1(k).N20=N20;
    features1(k).N02=N02;
    features1(k).N12=N12;
    features1(k).N21=N21;
    features1(k).N03=N03;
    features1(k).N30=N30;
    features1(k).N11=N11;

    I0=N20+N02;
    I1=(N20-N02)^2+4*N11^2;
    I2=(N30-3*N12)^2+(3*N21-N03)^2;
    I3=(N30+N12)^2+(N21+N03)^2;
    I4=(N30-3*N12)*(N30+N12)*[(N30+N12)^2-3*(N21*N03)^2];
    I5=(N20-N02)*[(N30+N12)^2-(N21+N03)^2]+4*N11*(N30+N12)*(N21+N03);

    features1(k).I0=I0;
    features1(k).I1=I1;
    features1(k).I2=I2;
    features1(k).I3=I3;
    features1(k).I4=I4;
    features1(k).I5=I5;
end

figure
imshow(ulabel)
errorCount = 0;
hold on
errors=0
for k=1:length(features1)
    f1 = features1(k).I1;
    f2 = features1(k).N12;
    f3 = features1(k).N03;
    data2=data(:, 1:3 )-[f1, f2, f3];       %calculating vector between two points
    data3 = [];
    for j=1 : length(data2)
        data3(j) = sqrt(data2(j, 1)^2 + data2(j, 2)^2 + data2(j, 3)^2);     %calculating distance between two points
    end
    data4 = [data3', data( : ,4)];
    K=5;            %amount of rows(which describe neighbours) that program will sort
    q=topkrows(data4, K, 1, 'ascend');      %1- column in which matrix is sorted ascending, from lowest to highest)
    mq=mode(q( : , 2 )) ;       %calculates most common value and if it's 1, it is specific letter
    x = features1(k).Centroid(1);         %decide if letter is E basing on its placement on image
    if x >= 4000 & x <= 5000
       isE=1;
    else
       isE=0;
    end
    if mq == isE   %if mq is equal to isE, it means that kNN solved it correctly and this specific letter is in fact E
       rectangle('Position', features1(k).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 1);   %marks letters assigned correctly
    else
       rectangle('Position', features1(k).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 1);   %marks letters assigned wrongly
       errors=errors+1                                     %calculates errors
    end
end
effectiveness=(1 - errors / length(features1)) * 100        %checks program efficiency
%%
%testing on waves4
AB=imread('AB_Waves4.jpg');            
CD=imread('CD_Waves4.jpg');
EF=imread('EF_Waves4.jpg');
ultimateimage=[AB, CD, EF];
ultbw=rgb2gray(ultimateimage)<200;
ulabel=bwlabel(ultbw);
features1=regionprops(ulabel, "Image", "Centroid", "BoundingBox");

for k=1:length(features1)
    B=features1(k).Image;
    m00=0;
    m01=0;
    m11=0;
    m10=0;
    m02=0;
    m20=0;
    m12=0;
    m21=0;
    m03=0;
    m30=0;
    width = size(B,2);
    height = size(B,1);
    for x = [1:width]
        for y = [1:height]
            m00 = m00 + B(y,x)*x^0*y^0;
            m01 = m01 + B(y,x)*x^0*y^1;
            m11 = m11 + B(y,x)*x^1*y^1;
            m10 = m10 + B(y,x)*x^1*y^0;
            m02 = m02 + B(y,x)*x^0*y^2;
            m20 = m20 + B(y,x)*x^2*y^0;
            m12 = m12 + B(y,x)*x^1*y^2;
            m21 = m21 + B(y,x)*x^2*y^1;
            m03 = m03 + B(y,x)*x^0*y^3;
            m30 = m30 + B(y,x)*x^3*y^0;
        end
    end
    Xs=m10/m00;
    Ys=m01/m00;
    M20=m20-(m10^2/m00);
    M02=m02-(m01^2/m00);
    M11=m11-(m01*m10/m00);
    M30=m30-3*m20*Xs+2*m10*Xs^2;
    M03=m03-3*m02*Ys+2*m01*Ys^2;
    M21=m21-2*m11*Xs-m20*Ys+2*m01*Xs^2;
    M12=m12-2*m11*Ys-m02*Xs+2*m10*Ys^2;
    features1(k).M20 = M20;
    features1(k).M02 = M02;
    features1(k).M11 = M11;
    features1(k).M30 = M30;
    features1(k).M03 = M03;
    features1(k).M21 = M21;
    features1(k).M12 = M12;

    N00 = 1;
    N01 = 0;
    N10 = 0;
    N20 = M20 / m00^2;
    N02 = M02 / m00^2;
    N12 = M12 / m00^((3/2)+1);
    N21 = M21 / m00^((3/2)+1);
    N03 = M03 / m00^((3/2)+1);
    N30 = M30 / m00^((3/2)+1);
    N11 = M11 / m00^2;

    features1(k).N00=N00;
    features1(k).N01=N01;
    features1(k).N10=N10;
    features1(k).N20=N20;
    features1(k).N02=N02;
    features1(k).N12=N12;
    features1(k).N21=N21;
    features1(k).N03=N03;
    features1(k).N30=N30;
    features1(k).N11=N11;

    I0=N20+N02;
    I1=(N20-N02)^2+4*N11^2;
    I2=(N30-3*N12)^2+(3*N21-N03)^2;
    I3=(N30+N12)^2+(N21+N03)^2;
    I4=(N30-3*N12)*(N30+N12)*[(N30+N12)^2-3*(N21*N03)^2];
    I5=(N20-N02)*[(N30+N12)^2-(N21+N03)^2]+4*N11*(N30+N12)*(N21+N03);

    features1(k).I0=I0;
    features1(k).I1=I1;
    features1(k).I2=I2;
    features1(k).I3=I3;
    features1(k).I4=I4;
    features1(k).I5=I5;
end

figure
imshow(ulabel)
errorCount = 0;
hold on
errors=0
for k=1:length(features1)
    f1 = features1(k).I1;
    f2 = features1(k).N12;
    f3 = features1(k).N03;
    data2=data(:, 1:3 )-[f1, f2, f3];       %calculating vector between two points
    data3 = [];
    for j=1 : length(data2)
        data3(j) = sqrt(data2(j, 1)^2 + data2(j, 2)^2 + data2(j, 3)^2);     %calculating distance between two points
    end
    data4 = [data3', data( : ,4)];
    K=5;            %amount of rows(which describe neighbours) that program will sort
    q=topkrows(data4, K, 1, 'ascend');      %1- column in which matrix is sorted ascending, from lowest to highest)
    mq=mode(q( : , 2 )) ;       %calculates most common value and if it's 1, it is specific letter
    x = features1(k).Centroid(1);         %decide if letter is E basing on its placement on image
    if x >= 4000 & x <= 5000
       isE=1;
    else
       isE=0;
    end
    if mq == isE   %if mq is equal to isE, it means that kNN solved it correctly and this specific letter is in fact E
       rectangle('Position', features1(k).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 1);   %marks letters assigned correctly
    else
       rectangle('Position', features1(k).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 1);   %marks letters assigned wrongly
       errors=errors+1                                     %calculates errors
    end
end
effectiveness=(1 - errors / length(features1)) * 100        %checks program efficiency