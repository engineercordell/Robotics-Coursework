
% bwboundaries()
% bwlabel( , 8)
% im2bw() % converts 3 layer img to binary
% imcomplement() % reverses black and white
% imfill() % fills holes in images
% imread()
% imshow()
% regionprops , ‘all’ (Useful properties: ‘Centroid’, ‘Area’, ‘Perimeter’, ‘PixelIdxList’,
% ’Circularity’,’MajorAxisLength’,’MinorAxisLength’,’MaxFeretProperties’,’MinFeretProperties’)
% rgb2gray() % converts color to b&w
% clc
% clear all
% figure
% hold on
% hold off
% size()
% length
% 
% cam = webcam
% cam = webcam(devicenumber)
% cam = webcam('cameraname')
% 
% imread()
% rgb2gray()
% im2bw()
% imcomplement()
% imfill()
% 
% 
%        BW = imread('blobs.png');
%               [B,L,N] = bwboundaries(comp_img);
%        figure;
%        imshow(comp_img);
%        hold on;
%        for k = 1:length(B),
%            boundary = B{k};
%            if(k > N)
%                plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
%            else
%                plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
%            end
%        end




% img=imread('trial1.bmp');
% gray_img=rgb2gray(img);
% bin_img=im2bw(gray_img);
% comp_img=imcomplement(bin_img);
% %fill_img=imfill(comp_img);
% label_img=bwlabel(comp_img);
% imshow(label_img)
% bw=label_img;
% 
% 
% 
% stats = regionprops('table',bw,'Centroid',...
%     'MajorAxisLength','MinorAxisLength','circularity','extent')
% 
% N= length(stats.Circularity);
% centers=zeros(N,2);
% diameters=zeros(N);
% count=1;
% 
% for i = 1:N
%     if (stats.Circularity(i) > 0.9 & (stats.Circularity(i) < 2))
%         centers(count,:)=stats.Centroid(i,:);
%         diameters(count) = mean([stats.MajorAxisLength(i) stats.MinorAxisLength(i)],2);
%         radii = diameters/2;
%         count=count+1;
%     end
% end
% 
% centers=centers(1:count-1,:);
% radii=radii(1:count-1,:);
% 
% hold on
% viscircles(centers,radii(:,1));
% hold off

% centers=zeros(N,2);
% diameters=zeros(N);
% count=1;
% vector1=[];
% vector2=[];

img=imread('trial0.bmp');
gray_img=rgb2gray(x);
bin_img=im2bw(gray_img);
comp_img=imcomplement(bin_img);
%fill_img=imfill(comp_img);
%label_img=bwlabel(comp_img);
% imshow(label_img)
bw=comp_img;
bw=imfilter(bw,2);

% img_binary=label_img;



stats = regionprops('table',bw,'Centroid',...
    'MajorAxisLength','MinorAxisLength','circularity','extent','Perimeter','Area','FilledImage','Image')

% 

       imshow(bw);
       hold on;

[B,L,N] = bwboundaries(bw,4);
N= length(stats.Circularity);

for i = 1:N
    if ((stats.Perimeter(i)^2)/(stats.Area(i)) <= 17) & ((stats.Perimeter(i)^2)/(stats.Area(i)) >=14) % rectangle       
           boundary = B{i};
            plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
    elseif ((stats.Extent(i) >= 0.1 & (stats.Extent(i) <= 1)) & (stats.Circularity(i)<=0.8))
            boundary2 = B{i};
            plot(boundary2(:,2), boundary2(:,1), 'r', 'LineWidth', 2);
    end
    
end


centers=zeros(N,2);
diameters=zeros(N);
count=1;

for i = 1:N
    if (stats.Circularity(i) > 0.9 & (stats.Circularity(i) < 2))
        centers(count,:)=stats.Centroid(i,:);
        diameters(count) = mean([stats.MajorAxisLength(i) stats.MinorAxisLength(i)],2);
        radii = diameters/2;
        count=count+1;
    end
end

centers=centers(1:count-1,:);
radii=radii(1:count-1,:);

%hold on
viscircles(centers,radii(:,1),'Color','b');
hold off

% for i = 1:length(B)
%     if (stats.Extent(i) > 0.45 & (stats.Extent(i) < 0.55)) % rectangle       
%            boundary = B{i};
%             plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
% %     else if (stats.Extent(i) > 0.45 & (stats.Extent(i) < 0.55))
% %             boundary2 = B{i};
% %             plot(boundary2(:,2), boundary2(:,1), 'r', 'LineWidth', 2);
%     end
    
% end
% 
% 
%     else if (stats.Extent(i) > 0.95 & (stats.Extent(i) < 1.1))
%               [B,L,N] = bwboundaries(comp_img);
%        for k = 1:length(B),
%            boundary = B{k};
%            if(k > N)
%                plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
%            else
%                plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
%            end
%        end
%     end
% end


% [B,L,N] = bwboundaries(comp_img);
%        figure;
%        imshow(comp_img);

%B1=B;
% B=B(vector)
%        hold on;
%        for k = 1:length(B),
%            boundary = B{k};
%            if(k > N)
%                plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
%            else
%                plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
%            end
%        end

% B2=B;
% B2=B(vector)
%        hold on;
%        for k = 1:length(B2),
%            boundary = B2{k};
%            if(k > N)
%                plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
%            else
%                plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 2);
%            end
%        end