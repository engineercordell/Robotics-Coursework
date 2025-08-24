function points = path_circle(center, r, n)

    x_c = center(1); 
    y_c = center(2);
    
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