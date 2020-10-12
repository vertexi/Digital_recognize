classdef ManArray

    properties
        Value
        lamp_range
        build_in_random_map
        build_in_status = 0;
    end

    methods

        function obj = ManArray(F, map_boundary, lamp_range, build_in, build_in_random_map)

            if nargin ~= 0

                if build_in == 1
                    obj(1).build_in_status = build_in;

                    if ~exist('build_in_random_map', 'var') || isempty(build_in_random_map)
                        obj(1).build_in_random_map = rand(map_boundary);
                    else

                        if size(build_in_random_map, 1) == map_boundary
                            obj(1).build_in_random_map = build_in_random_map;
                        else
                            error('Wrong initial pressure map occur!')
                        end

                    end

                else
                    obj(1).build_in_random_map = zeros(map_boundary);
                end

                sit_prob_dist = makedist('Normal', 'mu', 0.3, 'sigma', 0.1);
                move_prob_dist = makedist('Normal', 'mu', 0.3, 'sigma', 0.1);
                get_prob_dist = makedist('Normal', 'mu', 0.3, 'sigma', 0.1);
                leave_prob_dist = makedist('Normal', 'mu', 0.3, 'sigma', 0.1);

                for i = 1:F
                    % obj(i).build_in_random_map = obj(1).build_in_random_map;
                    obj(i).Value = Man(map_boundary, sit_prob_dist, move_prob_dist, get_prob_dist, leave_prob_dist);
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

            if obj(1).build_in_status == 1
                map_array = map_array + obj(1).build_in_random_map;
            end

            imagesc(map_array, [0 max(map_array, [], 'all')]);
        end

        function map_array = get_pressure(obj)
            maplength = obj(1).Value.map_boundary;
            num_Man = length(obj);
            position_array = [];

            for n = 1:num_Man
                position_array(n, :) = obj(n).Value.position;
            end

            map_array = zeros(maplength);
            get_index = position_array(:, 1) + (position_array(:, 2) - 1) * maplength;
            map_array(get_index) = 1;

            for n = 1:num_Man
                position_array(n, [1, 2]) = obj(n).Value.package.position;
                position_array(n, 3) = obj(n).Value.package.weight;
            end

            get_index = position_array(:, 1) + (position_array(:, 2) - 1) * maplength;
            map_array(get_index) = map_array(get_index) + position_array(:, 3);

        end

        function map_array = get_man(obj)
            maplength = obj(1).Value.map_boundary;
            num_Man = length(obj);
            position_array = [];

            for n = 1:num_Man
                position_array(n, :) = obj(n).Value.position;
            end

            map_array = zeros(maplength);
            get_index = position_array(:, 1) + (position_array(:, 2) - 1) * maplength;
            map_array(get_index) = 1;
        end

        function [lamp_regions_final, lamp_regions_label] = sample(obj)
            map_array = get_man(obj);

            %divide the whole preesure to several region
            N = obj(1).lamp_range * ones(1, obj(1).Value.map_boundary / obj(1).lamp_range);
            lamp_regions = mat2cell(map_array, N, N);

            lamp_regions = lamp_regions(:);
            len_regions = length(lamp_regions);
            lamp_regions_label = zeros(len_regions, 1);

            for n = 1:len_regions

                if sum(lamp_regions{n}, 'all') > 0
                    lamp_regions_label(n) = 1;
                end

            end

            lamp_regions_final = [];
            map_array = get_pressure(obj);

            if obj(1).build_in_status == 1
                map_array = map_array + obj(1).build_in_random_map;
            end

            lamp_regions = mat2cell(map_array, N, N);

            lamp_regions = lamp_regions(:);

            for n = 1:len_regions
                lamp_regions_final(n, :) = lamp_regions{n}(:);
            end

        end

        function check_prob(obj)
            num_Man = length(obj);

            for n = 1:num_Man

                if (obj(n).Value.sit_possible < 0 || obj(n).Value.sit_possible > 1) || ...
                        (obj(n).Value.move_possible < 0 || obj(n).Value.move_possible > 1) || ...
                        (obj(n).Value.get_pack_possible < 0 || obj(n).Value.get_pack_possible > 1) || ...
                        (obj(n).Value.leave_pack_possible < 0 || obj(n).Value.leave_pack_possible > 1)
                    error('the probility is wrong over the range(0~1)');
                end

            end

        end

    end

end
