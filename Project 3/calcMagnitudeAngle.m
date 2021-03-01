function [ mag, ang ] = calcMagnitudeAngle( S )
  % use Prewitt Cross/Mask
  gx=sum(S(3,:))-sum(S(1,:));
  gy=sum(S(:,3))-sum(S(:,1));
  mag = sqrt(gx^2+gy^2);
  ang = atan2(gy, gx); % or atan2(gy/gx) or atan2d(gy,gx)
end