function blob_id(path)
   
    % img = imread(path);

    grayImg = rgb2gray(img); % gray scale for edge detection
    filteredImg = medfilt2(grayImg); % median filter to reduce "salt-and-pepper" noise

    edges = edge(filteredImg, 'Canny'); % find edges in 2D gray scaled img using the 'Canny' algorithm

    filledImg = imfill(edges, 'holes');

    [B, L] = bwboundaries(filledImg, 'noholes'); % finds contours
    imshow(label2rgb(L, @jet, [.5 .5 .5]))

    % Analyze the properties of the identified blobs
     stats = regionprops(L, 'all');

    hold on

    circCount = 1;
    recCount = 1;
    triCount = 1;

    for k = 1:length(B)
        % Obtain the perimeter and area for circularity calculation
        perimeter = stats(k).Perimeter;
        area = stats(k).Area;
        
        % Calculate circularity (for a circle, circularity = 1)
        circularity = 4*pi*area / (perimeter^2);
        
        % Define a tolerance for circularity to account for pixelation
        tolerance = 0.1; % Adjust this value based on your specific needs
        
        % Check if the blob is a circle based on its circularity
        if abs(1 - circularity) <= tolerance
            boundary = B{k};
            
            % Draw the boundary in yellow
            plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 2);
            
            % Plot the centroid in yellow
            centroid = stats(k).Centroid;
            plot(centroid(1), centroid(2), 'y*');
            fprintf("Circle #%d Centroid: (%.2f, %.2f)\n", circCount, stats(k).Centroid(1), stats(k).Centroid(2));
            circCount = circCount + 1;
        else
            % Use MajorAxisLength and MinorAxisLength to identify rectangles
            majorAxisLength = stats(k).MajorAxisLength;
            minorAxisLength = stats(k).MinorAxisLength;

            triangleArea = 0.5 * majorAxisLength * minorAxisLength;

            % Define a tolerance for area comparison
            areaTolerance = 0.3; % Adjust based on your specific needs
            
            % Check if the actual area is close to the calculated "triangle area"
            
            if ~(abs(triangleArea - area) / area <= areaTolerance)
                boundary = B{k};
                plot(boundary(:,2), boundary(:,1), 'm', 'LineWidth', 2); % Draw pink boundary for everything else
                centroid = stats(k).Centroid;
                plot(centroid(1), centroid(2), 'm*'); % Plot centroid in pink
                fprintf("Rectangle #%d Centroid: (%.2f, %.2f)\n", recCount, stats(k).Centroid(1), stats(k).Centroid(2));
                fprintf("Rectangle #%d Orientation: %.2f\n", recCount, stats(k).Orientation);
                recCount = recCount + 1;
            else
                boundary = B{k};
                plot(boundary(:,2), boundary(:,1), 'b', 'LineWidth', 2); % Draw blue boundary for triangles
                centroid = stats(k).Centroid;
                plot(centroid(1), centroid(2), 'b*'); % Plot centroid in pink
                fprintf("Triangle #%d Centroid: (%.2f, %.2f)\n", triCount, stats(k).Centroid(1), stats(k).Centroid(2));
                fprintf("Triangle #%d Orientation: %.2f\n", triCount, stats(k).Orientation);
                recCount = recCount + 1;
            end

            %{
            % eccentricity = stats(k).Eccentricity;
            axisRatio = majorAxisLength / minorAxisLength;
            
            % Use area and perimeter to identify rectangles
            areaPerimeterRatio = area / (perimeter^2);
            disp(areaPerimeterRatio)
            
            % Define tolerance for rectangle identification (adjust as needed)
            areaRatioLowerBound = 0.04; % Minimum ratio for a shape to be considered a rectangle
            areaRatioUpperBound = 0.05; % Maximum ratio for a shape to still be considered a rectangle

            % Define tolerance for rectangle identification (adjust as needed)
            axisRatioLower = 1.2; % Minimum ratio for a shape to be considered a rectangle
            axisRatioUpper = 3; % Maximum ratio for a shape to still be considered a rectangle

            areaPerimeterCheck = areaPerimeterRatio >= areaRatioLowerBound && areaPerimeterRatio <= areaRatioUpperBound;
            axisRatioCheck = axisRatio >= axisRatioLower && axisRatio <= axisRatioUpper;
   
            % Check if the shape is a rectangle based on axis ratio
            if areaPerimeterCheck && axisRatioCheck
                boundary = B{k};
                plot(boundary(:,2), boundary(:,1), 'm', 'LineWidth', 2); % Draw pink boundary
                centroid = stats(k).Centroid;
                plot(centroid(1), centroid(2), 'm*'); % Plot centroid in pink
            end
            %}

        end
            
    end
    hold off;
    
end


