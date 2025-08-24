cam = webcam;

while true
    img = snapshot(cam); % Capture a frame
    hsvFrame = rgb2hsv(img); % Convert frame to HSV

    % Apply refined HSV thresholds for blue
    binaryMask = (hsvFrame(:,:,1) >= 100/360 & hsvFrame(:,:,1) <= 140/360) & ...
                 (hsvFrame(:,:,2) >= 50/255 & hsvFrame(:,:,2) <= 255/255) & ...
                 (hsvFrame(:,:,3) >= 50/255 & hsvFrame(:,:,3) <= 255/255);

    % Clean up the binary mask
    cleanedMask = bwareaopen(binaryMask, 50); % Remove small objects
    cleanedMask = imclose(cleanedMask, strel('disk', 5)); % Close small gaps

    % Find blobs in the cleaned binary mask
    [B, L] = bwboundaries(cleanedMask, 'noholes');
    imshow(img); % Display the original frame
    hold on;

    % Filter and draw boundaries based on blob size
    stats = regionprops(L, 'Area', 'BoundingBox');
    for k = 1:length(B)
        if stats(k).Area > 100 % Filter based on size
            boundary = B{k};
            plot(boundary(:,2), boundary(:,1), 'y', 'LineWidth', 2);
            
            % Optional: Draw bounding box
            rectangle('Position', stats(k).BoundingBox, 'EdgeColor', 'r', 'LineWidth', 2);
        end
    end

    hold off;
    drawnow; % Ensure the plot updates are displayed immediately
end

% Clean up
clear('cam'); % Release the webcam