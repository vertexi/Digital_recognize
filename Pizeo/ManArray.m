classdef ManArray
    properties
        Value
        lamp_range
    end
    methods
        function obj = ManArray(F, map_boundary, lamp_range)
            if nargin ~= 0
                for i = 1:F
                    obj(i).Value = Man(map_boundary);
                    obj(i).lamp_range = lamp_range;
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
        
        
        function visualize(obj)
            map_array = get_pressure(obj);
            imagesc(map_array, [0 max(map_array,[],'all')]);
        end

        function map_array = get_pressure(obj)
            maplength = obj(1).Value.map_boundary;
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
            
        end

        function map_array = get_man(obj)
            maplength = obj(1).Value.map_boundary;
            num_Man = length(obj);
            position_array = [];
            for n = 1:num_Man
                position_array(n,:) = obj(n).Value.position;
            end
            map_array = zeros(maplength);
            get_index = position_array(:,1)+(position_array(:,2)-1)*maplength;
            map_array(get_index) = 1;
        end
        
        function [lamp_regions_final, lamp_regions_label] = sample(obj)
            map_array = get_man(obj);

            %divide the whole preesure to several region
            N = obj(1).lamp_range*ones(1,obj(1).Value.map_boundary/obj(1).lamp_range);
            lamp_regions = mat2cell(map_array, N, N);

            lamp_regions = lamp_regions(:);
            len_regions = length(lamp_regions);
            lamp_regions_label = zeros(len_regions,1);
            for n = 1:len_regions
                if sum(lamp_regions{n},'all')>0
                    lamp_regions_label(n) = 1;
                end
            end
            lamp_regions_final = [];
            for n = 1:len_regions
                lamp_regions_final(n, :) = lamp_regions{n}(:);
            end
        end
    end
end