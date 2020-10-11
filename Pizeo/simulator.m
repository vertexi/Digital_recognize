num_agent = 5;
map_boundary = 40;
a = ManArray(num_agent, map_boundary);

figure
colormap('gray');
axis equal;
while true
    a.visualize;
    a.move
    drawnow
end