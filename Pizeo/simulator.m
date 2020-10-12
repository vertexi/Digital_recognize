num_agent = 40;
map_boundary = 40;
lamp_range = 5;
bulid_in = 0;
bulid_in_random_map = repmat([ones(1,map_boundary);0.5*ones(1,map_boundary)], map_boundary/2, 1);
a = ManArray(num_agent, map_boundary, lamp_range, bulid_in, bulid_in_random_map);
a.check_prob

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