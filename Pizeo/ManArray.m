classdef ManArray
    properties
        Value
    end
    methods
        function obj = ManArray(F)
            if nargin ~= 0
                for i = 1:F
                    obj(i).Value = Man;
                end
            end
        end
        
        function move(obj)
            if nargin ~= 0
                num = length(obj);
                for i = 1:num
                    obj(i).Value.move;
                end
            end
        end
        
        
        function visualize(obj, maplength)
            num_Man = length(obj);
            
            position_array = [];
            for n = 1:num_Man
                position_array(n,:) = obj(n).Value.position;
            end
            
            map_array = zeros(maplength);
            get_index = position_array(:,1)+(position_array(:,2)-1)*maplength;
            map_array(get_index) = 1;
            
            
            for n = 1:num_Man
                position_array(n,[1,2]) = obj(n).Value.package.position;
                position_array(n,3) = obj(n).Value.package.weight;
            end
            get_index = position_array(:,1)+(position_array(:,2)-1)*maplength;
            map_array(get_index) = map_array(get_index)+position_array(:,3);
            
            imagesc(map_array, [0 max(map_array,[],'all')]);
        end
        
    end
end