function giz=gizman(dx,dy)
if dx==0&&dy>0
    giz=0;
elseif dx>0&&dy>0
    giz=atan(abs(dx/dy));
elseif dx>0&&dy==0
    giz=pi/2;
elseif dx>0&&dy<0
    giz=pi-atan(abs(dx/dy));
elseif dx==0&&dy<0
    giz=pi;
elseif dx<0&&dy<0
    giz=atan(abs(dx/dy))+pi;
elseif dx<0&&dy==0
    giz=3*pi/2;
else
    giz=2*pi-atan(abs(dx/dy));
end
end