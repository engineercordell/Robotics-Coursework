%% Georgia Institute of Technology
% George W. Woodruff School of Mechanical Engineering
% ME4451 Robotics Lab 5 - 2D Pose Detection and Tracking
% Dr. Anirban Mazumdar

% Detection
%convert the image to grayscale

% image = 'base4.PNG';
% img_rbg  = imread(image);
% img_gray = rgb2gray(img_rbg);
% 
% img_binary  = imbinarize(img_gray);
% img_binary  = imcomplement(img_binary);
% 
% % for detection. ex.
% xyz = feducial_xyz(img_binary);
% [pos, ori] = calculate_pose(xyz)

% %% Tracking
cam=webcam;
origin_pic=snapshot(cam);

img_gray = rgb2gray(origin_pic);

img_binary  = imbinarize(img_gray);
img_binary_origin  = imcomplement(img_binary);

%got the binary cam pic

xyz_origin=feducial_xyz(img_binary_origin);
%apply feducial func

%imshow(img_binary_origin)
% ---------------------- TODO for students -------------------------
while(true)

img=snapshot(cam);
img_gray = rgb2gray(img);

img_binary  = imbinarize(img_gray);
img_binary_pic  = imcomplement(img_binary);

xyz_pic=feducial_xyz(img_binary_pic); %apply feducial func

%apply calculate pos relative to origin pic

%[pos ori] = calculate_pose_cam(xyz_pic,xyz_origin)
imshow(img_binary_pic)
hold on

bw=img_binary_pic;

stats = regionprops('table',bw,'Centroid','MajorAxisLength','MinorAxisLength',...
    'circularity','extent','Perimeter','Area');

s=stats;

[B,L,N] = bwboundaries(bw,4);

N= length(stats.Circularity);

for i = 1:N
    if ((stats.Perimeter(i)^2)/(16*stats.Area(i)) <= 1.05) & ((stats.Perimeter(i)^2)/(16*stats.Area(i)) >=0.95) % square       
           boundary = B{i};
            plot(boundary(:,2), boundary(:,1), 'g', 'LineWidth', 4);
    elseif (stats.Extent(i) >= 0.48 & (stats.Extent(i) <= 0.53))  %& (stats.Circularity(i) <= 0.7))
            boundary2 = B{i};
            plot(boundary2(:,2), boundary2(:,1), 'r', 'LineWidth', 4);
    end
    
end

%plot circle boundary

% N= length(stats.Circularity);
centers=zeros(N,2);
diameters=zeros(N);
count=1;

for i = 1:N
    if (stats.Circularity(i) >= 0.9 & (stats.Circularity(i) <= 2))
        centers(count,:)=stats.Centroid(i,:);
        diameters(count) = mean([stats.MajorAxisLength(i) stats.MinorAxisLength(i)],2);
        radii = diameters/2;
        count=count+1;
    end
end

centers=centers(1:count-1,:);
radii=radii(1:count-1,:);

viscircles(centers,radii(:,1),'Color','b');
%hold off


%draw boundaries using boundary func from prev lab



    
end