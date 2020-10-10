%initialize the simulation map
velocity_agent = 5;
num_agent = 4;
map_length = velocity_agent*8;
%µÿÕº—π¡¶æÿ’Û
map = zeros(map_length);
tile_length = 5;

a = ManArray(5, 40);

figure
colormap('gray');
axis equal;
while true
    a.visualize(40);
    a.move
    drawnow
end