%% Georgia Institute of Technology
% George W. Woodruff School of Mechanical Engineering
% ME4451 Robotics Lab 5 - 2D Pose Detection and Tracking
% Dr. Anirban Mazumdar

%% Detection
image = 'base1.PNG';
img_rbg  = imread(image);
img_gray = rgb2gray(img_rbg);
img_binary  = imbinarize(img_gray);
img_binary  = imcomplement(img_binary);

% for detection. ex.
template_centroids = feducialCentroidDetection(img_binary);
[position, orientation] = calculatePose(template_centroids);

%% Tracking
% ---------------------- TODO for students -------------------------
n_frames = 20;
pause_duration = 0.25;
for ii = 1:n_frames
    
    % get the image from camera
    img=snapshot(cam);
    img_gray = rgb2gray(img);
    img_binary  = imbinarize(img_gray);
    img_binary_pic  = imcomplement(img_binary);

    template_pic = feducialCentroidDetection(img_binary_pic);
    

    % process for ever
    pause(pause_duration);
end