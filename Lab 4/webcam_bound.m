cam = webcam


for i = 1:100
    x=snapshot(cam);
    
[BW, masked_img]=createMask2(x);
imshow(x)
[B,L] = bwboundaries(BW);
hold on
% img=x(B);
%     for x = 1:length(B)

if length(B)>1
    boundary = B{1};

    plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 5);
end
%     end
hold off

    
end

