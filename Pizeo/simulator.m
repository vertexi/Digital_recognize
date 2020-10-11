num_agent = 5;
map_boundary = 40;
lamp_range = 5;
a = ManArray(num_agent, map_boundary, lamp_range);

lamp_x = [];
lamp_y = [];

% draw codes
% figure
% colormap('gray');
% axis equal;
counter = 1000;
while counter>0
    % draw codes
    % a.visualize;

    a.move
    [temp_x temp_y] = a.sample;
    lamp_x = [lamp_x;temp_x];
    lamp_y = [lamp_y;temp_y];
    counter = counter-1;
    % drawnow
end