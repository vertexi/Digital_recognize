function visualize(ManArray, maplength)
    num_Man = length(ManArray);
    
    position_array = [];
    for n = 1:num_Man
        position_array(n,:) = ManArray(n).Value.position;
    end
    
    colormap('gray');
    
    map_array = zeros(maplength);
    get_index = position_array(:,1)+(position_array(:,2)-1)*maplength;
    map_array(get_index) = 1;
    
    imagesc(map_array,[0 1]);
    axis equal;
end