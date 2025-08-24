%% Georgia Institute of Technology
% George W. Woodruff School of Mechanical Engineering
% ME4451 Robotics Lab 5 - 2D Pose Detection and Tracking

%% Function Description
% Given a feducial image binary, this function returns the locations. 
% Check for poseTracking.m for binarization of each different shapes.
% Input: binary image
% Output: centroid (xyz position) of the robot, triangle, square, and
% circle as a single matrix. Make sure your columns are in the correct
% order.

%input an image with white figures in a black background

function [xyz] = feducial_xyz(img_binary)
    
    % get properties
    s = regionprops('table', img_binary, 'Centroid', 'Area', 'Circularity', 'Perimeter','Extent');

    % metric to get different shapes
    xyz = zeros(3,4);
    xyz(1:2,1) = s.Centroid(1,1:2); % centroid of the robot

    N=length(s.Circularity);
    
    for i = 1:N
        m = s.Circularity(i);
        if((m < 1.1) & (m > 0.9))
            xyz(1:2,4) = s.Centroid(i,1:2);
        elseif ((s.Perimeter(i)^2)/(16*s.Area(i)) <= 1.05) & ((s.Perimeter(i)^2)/(16*s.Area(i)) >=0.95) % square
            xyz(1:2,3)=s.Centroid(i,1:2);
        elseif ((s.Extent(i) >= 0.48 & (s.Extent(i) <= 0.53)) & (s.Circularity(i) <=0.7))
            xyz(1:2,2)=s.Centroid(i,1:2);
        end
        
    end 
    
end