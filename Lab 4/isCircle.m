function [isCircle] = isCircle(boundary)

    area = polyarea(boundary(:,2), boundary(:,1));

    perimeter = sum(sqrt(sum(diff(boundary).^2,2)));
    
    circularity = 4 * pi * area / perimeter^2;
    
    % Define tolerance
    tolerance = 0.1;
    
    if abs(circularity - 1) <= tolerance
        isCircle = true;
    else
        isCircle = false;
    end
end