function q = data_circle_movie_HW02(dh)

    n = 5; % num of separate frames/iterations

    x_c = 3; 
    y_c = 3;
    r = 3; % radius
    
    q = zeros(n, 5); % final end-effector position matrix
    q(:,1) = nan; % set first column to nan
    q(:,5) = 0; % set last column to 0
   
    % Loop through from i=1 to i=n

    for i = 1:n
        dh.Xe = [x_c - r*cos((2*pi*i)/n), y_c - r*sin((2*pi*i)/n), (2*pi*i)/n]; % First obtain the end effector position using polar coordinates
        dh_RDA = RRR_RDA(dh, 1);  % Then apply RDA to yield the joint angles that cause the end effector
                                  % to point at (3,3)
        q(i, :) = dh_RDA.t_RDA;   % Update the final end-effector position matrix with RDA joint angles
    end


end