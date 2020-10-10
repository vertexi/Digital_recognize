%initialize the simulation map
velocity_agent = 5;
num_agent = 4;
map_length = velocity_agent*8;
%µÿÕº—π¡¶æÿ’Û
map = zeros(map_length);
tile_length = 5;

a = ManArray(10);
while true
    visualize(a, 40);
    a.move
    pause
    drawnow
end