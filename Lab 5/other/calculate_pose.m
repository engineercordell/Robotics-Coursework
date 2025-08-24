%% Georgia Institute of Technology
% George W. Woodruff School of Mechanical Engineering
% ME4451 Robotics Lab 5 - 2D Pose Detection and Tracking

%% Function Description
% This function returns the location and orientation of the robot.
% Input: centroids of the robot and the different shapes (xyz).
% Output: (position, orientation)
% Note that orientation should be in degrees

function [pos, eul] = calculate_pose(xyz)
    % get the base origin template. This is given to you!
    template_base = load('template_centroids0.mat');
    base_xyz = template_base.xyz_base;
    
    pos = xyz(:,1); %co-ordinates of bounding box of fig
    

    xyz_0 = pos-base_xyz(:,1);
    xyz_i = xyz(:,2:4) - base_xyz(:,1);
    xyz_0i = base_xyz(:,2:4)-base_xyz(:,1);

    R = (xyz_i - xyz_0) * pinv(xyz_0i);

    R(3,3)=1;

    R=R;

%     eul=asin(R(2,1))*180/pi;

    eul=rotm2eul(R)*180/pi;

    pos=[xyz];

    
    % ---------------------- TODO for students -------------------------
    % BONUS : write a scale invariant version by normalizing the distance
    % from the template to each small shape. So, distance from camera to
    % robot doesn't matter

    
    
    % ------------------------------------------------------------------

end