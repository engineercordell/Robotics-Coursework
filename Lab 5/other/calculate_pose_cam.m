function [pos, eul] = calculate_pose_cam(xyz,xyz_origin)
    % get the base origin template. This is given to you!
   % template_base = load('template_base.mat');
    base_xyz = xyz_origin;
    
    pos = xyz(:,1); %co-ordinates of bounding box of fig
    

    xyz_0 = pos-base_xyz(:,1);
    xyz_i = xyz(:,2:4) - base_xyz(:,1);
    xyz_0i = base_xyz(:,2:4)-base_xyz(:,1);

    R = (xyz_i - xyz_0) * pinv(xyz_0i);

    R(3,3)=1;

    R=R';

%     eul=asin(R(2,1))*180/pi;

    eul=rotm2eul(R)*180/pi;

    pos=[xyz];

    
    % ---------------------- TODO for students -------------------------
    % BONUS : write a scale invariant version by normalizing the distance
    % from the template to each small shape. So, distance from camera to
    % robot doesn't matter

    
    
    % ------------------------------------------------------------------

end