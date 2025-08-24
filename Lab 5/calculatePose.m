%% Georgia Institute of Technology
% George W. Woodruff School of Mechanical Engineering
% ME4451 Robotics Lab 5 - 2D Pose Detection and Tracking

%% Function Description
% This function returns the location and orientation of the robot. by detecting
% the change in location of the template shapes with respect to their original position
% Input: centroids of the robot and the different shapes (template_centroids).
% Output: (position, orientation)
% Note that orientation should be in degrees

% function [position, orientation] = calculatePose(template_centroids)
%     % get the base origin template. This is given to you!
%     template_centroids0 = load('template_centroids0.mat');
%     template_centroids0 = template_centroids0.template_centroids0; % base
% 
%     position = template_centroids(:,1);
% 
%     template_centroids_0 = position - template_centroids0(:, 1); % global
%     template_centroids_i = template_centroids(:, 2:4) - template_centroids0(:, 1);
%     template_centroids_0i = template_centroids0(:, 2:4) - template_centroids0(:, 1);
% 
%     R = (template_centroids_i - template_centroids_0) * pinv(template_centroids_0i);
%     R(3,3) = 1;
% 
%     % R = R;
% 
%     orientation = rotm2eul(R)*180/pi;
% 
%     position = [template_centroids];
% 
%     % ---------------------- TODO for students -------------------------
% 
%     % BONUS : write a scale invariant version by normalizing the distance
%     % from the template to each small shape. So, distance from camera to
%     % robot doesn't matter
% 
%     % ------------------------------------------------------------------
% end

function [position, orientation] = calculatePose(template_centroids)
    template_centroids0 = load('template_centroids0.mat');
    template_centroids0 = template_centroids0.template_centroids0; % base template centroids

    position = template_centroids;

    p_1 = template_centroids(:, 2);
    p_2 = template_centroids(:, 3);
    p_3 = template_centroids(:, 4);
    p_123 = cat(2, p_1, p_2, p_3) - template_centroids0(:, 1);

    p_10 = template_centroids0(:, 2);
    p_20 = template_centroids0(:, 3);
    p_30 = template_centroids0(:, 4);
    p_1230 = cat(2, p_10, p_20, p_30) - template_centroids0(:, 1);

    p = template_centroids(:, 1) - template_centroids0(:, 1); 

    R = (p_123 - p) * pinv(p_1230);

    R(3,3) = 1; % This makes R a 3x3 matrix, suitable for rotm2eul

    orientation = rotm2eul(R, 'ZYX') * 180 / pi;
end