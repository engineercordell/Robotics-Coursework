%% Georgia Institute of Technology
% George W. Woodruff School of Mechanical Engineering
% ME4451 Robotics Lab 5 - 2D Pose Detection and Tracking

%% Function Description
% Given a feducial image binary, this function returns the locations of the centroids
% of the overall template and the 3 shapes
% Check for poseTracking.m for binarization of each different shapes.
% Input: binary image
% Output: centroid (xy position) of the robot (column 1), triangle (column 2), square (column 3), and
% circle (column 4) as a single matrix. Make sure your columns are in the correct
% order. The bottom row is a dummy row that is necessary to multiply by the rotation matrix later

% function template_centroids = feducialCentroidDetection(img_binary)
% 
%     % get properties
%     shape_blobs = regionprops(img_binary, 'Centroid', 'Area', 'Circularity', 'Perimeter', 'Extent');
% 
%     % metric to get different shapes
%     template_centroids = zeros(3,4);
%     template_centroids(1:2,1) = shape_blobs(1).Centroid; % centroid of the robot/template
% 
%     N = length(shape_blobs);
% 
%     for i = 1:N
% 
%         % ---------------------- TODO for students -------------------------
%         % metrics to identify triangles and squares.
%         m = shape_blobs(i).Circularity;
%         if ((m < 1.1) && (m > 0.9))
%             xyz(1:2,4) = shape_blobs(i).Centroid(1:2);
%         elseif ((shape_blobs(i).Perimeter^2)/(16*shape_blobs(i).Area) <= 1.05) & ((shape_blobs(i).Perimeter^2)/(16*shape_blobs(i).Area) >=0.95) % square
%             xyz(1:2,3)=shape_blobs(i).Centroid(1:2);
%         elseif ((shape_blobs(i).Extent >= 0.48 & (shape_blobs(i).Extent <= 0.53)) & (shape_blobs(i).Circularity <=0.7))
%             xyz(1:2,2)=shape_blobs(i).Centroid(1:2);
%         end
% 
%         % % ------------------------------------------------------------------
%         % 
%         % % Centroid of the circle, this is given to you.
%         % circularity = shape_blobs(i).Circularity;
%         % if((circularity < 1.1) && (circularity > 0.9))
%         %     template_centroids(1:2,4) = shape_blobs(i).Centroid;
%         % end
% 
%     end 
% 
% end

function template_centroids = feducialCentroidDetection(img_binary)
    
    % get properties
    s = regionprops('table', img_binary, 'Centroid', 'Area', 'Circularity', 'Perimeter','Extent');

    % metric to get different shapes
    template_centroids = zeros(3,4);
    template_centroids(1:2,1) = s.Centroid(1,1:2); % centroid of the robot

    N=length(s.Circularity);

    for i = 1:N
        m = s.Circularity(i);
        if((m < 1.1) & (m > 0.9))
            template_centroids(1:2,4) = s.Centroid(i,1:2);
            % plot(s.Centroid(i,1:2));
        elseif ((s.Perimeter(i)^2)/(16*s.Area(i)) <= 1.05) & ((s.Perimeter(i)^2)/(16*s.Area(i)) >=0.95) % square
            template_centroids(1:2,3)=s.Centroid(i,1:2);
            % plot(s.Centroid(i,1:2));
        elseif ((s.Extent(i) >= 0.48 & (s.Extent(i) <= 0.53)) & (s.Circularity(i) <=0.7))
            template_centroids(1:2,2)=s.Centroid(i,1:2);
            % plot(s.Centroid(i,1:2));'
        end
    end 

    s2 = table2array(s(:, 2))';
    template_centroids = template_centroids(1:2, :);

    diffMat = setdiff(s2, template_centroids);

    mask = find(template_centroids(1:2, :) == 0)';
    % template_centroids = template_centroids(1:2, :);
    template_centroids(mask) = diffMat;
    % template_centroids(:, end) = [];
    template_centroids = [template_centroids; 0 0 0 0];
    
end