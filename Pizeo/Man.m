classdef Man < handle
    properties(Constant)
        velocity = 1;
        move_direction = {[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]};
    end
    
    properties
        position %man's position
        weight; %man's weight
        package %man's package(contains wheight and package position)
        package_status %a man carry his package
        sit_possible %man wanna sit possibility
        move_possible %when a man sit, the possibility he wanna move
        get_pack_possible %when man moving without package, the possiblity of he wanna get package
        leave_pack_possible %the possibility that when the man leaving he don't wanna get package
        leave_room_possible % the man wanna leave this room possible
        back_room_possible
        %1 carray the package
        %0 detach the package
        man_status % sit status
        % 0 sit
        % 1 move
        % 2 to get package
        % 3 leave the room
        map_boundary;
    end
    methods
        function obj = Man(map_boundary, sit_prob_dist, move_prob_dist, get_prob_dist, leave_prob_dist, leave_room_prob_dist, back_room_prob_dist)
            %Man's constructor
            obj.map_boundary = map_boundary;
            obj.position = randi(obj.map_boundary,1,2);
            obj.weight = 0.4 + 0.4.*rand(); % human weight 40~80kg
            package.weight = obj.weight*(0.05 + 0.1.*rand()); % package weight 5~15%*human weight
            package.position = obj.position;
            obj.package = package;
            obj.package_status = 1;
            obj.man_status = 0;
            
            while true
                temp = sit_prob_dist.random;
                if temp > 0 && temp < 1
                    obj.sit_possible = temp;
                    break;
                end
            end
            temp = [];
            while true
                temp = move_prob_dist.random;
                if temp > 0 && temp < 1
                    obj.move_possible = temp;
                    break;
                end
            end
            temp = [];
            while true
                temp = get_prob_dist.random;
                if temp > 0 && temp < 1
                    obj.get_pack_possible = temp;
                    break;
                end
            end
            temp = [];
            while true
                temp = leave_prob_dist.random;
                if temp > 0 && temp < 1
                    obj.leave_pack_possible = temp;
                    break;
                end
            end
            temp = [];
            while true
                temp = leave_room_prob_dist.random;
                if temp > 0 && temp < 1
                    obj.leave_room_possible = temp;
                    break;
                end
            end
            temp = [];
            while true
                temp = back_room_prob_dist.random;
                if temp > 0 && temp < 1
                    obj.back_room_possible = temp;
                    break;
                end
            end
            temp = [];
        end
        
        
        
        function random_move(obj)
            %change the man's position
            obj_pos = obj.position;
            while true
                temp = ceil(rand()*8); %generate a random integer(1~8)
                update_pos = obj_pos+obj.move_direction{temp};
                if (update_pos(1)<(obj.map_boundary+1)&&update_pos(2)<(obj.map_boundary+1)&&update_pos(1)>0&&update_pos(2)>0)
                    obj.position = update_pos;
                    % if the man carry a package update the package
                    % position simu;taneously
                    if obj.package_status==1
                        obj.package.position = obj.position;
                    end
                    break;
                end
            end
        end
        % now man can moving with or without package
        % and can sit on a floor detach the package
        % I wanna the man can leave for a second and get a chance to get
        % his package.
        function move(obj)
            if obj.man_status==1
                % man moving
                if obj.package_status == 1
                    % get the package and moving
                    if rand()<obj.sit_possible
                        obj.man_status = 0;
                        % man sit now
                    else
                        obj.random_move;
                        % you are free! move now!
                    end
                else
                    % don't have the package now and moving
                    if rand()<obj.get_pack_possible
                        obj.man_status = 2;
                        %now I wanna get the package
                        obj.move;
                        %step to get the package
                    else
                        obj.random_move;
                    end
                end
            elseif obj.man_status==0
                % man is siting
                if rand()<obj.move_possible
                    if rand()<obj.leave_pack_possible
                        obj.package_status = 0;
                        % I don't wanna carry my package 
                    else
                        obj.package_status = 1;
                        % I will carry my package
                    end
                    if rand()<obj.leave_room_possible
                        obj.man_status = 3;
                        % now step by step leaving the room
                        obj.move;
                    else
                        obj.man_status = 1;
                        % ooh! I can move now!
                        obj.random_move;
                        % now move
                    end
                else
                    % this man want keep siting to kill himself
                    % so do nothing
                end
            elseif obj.man_status==2
                obj.get_package;
            elseif obj.man_status==3
                obj.leave_room;
            end
        end
        
        function leave_room(obj)
            if rand()<obj.back_room_possible
                obj.man_status = 1;
            end
        end


        function get_package(obj)
            % step by step get the man's package as soon as possible
            obj_pos = obj.position;
            package_pos = obj.package.position;
            orig_distance = sum((package_pos-obj_pos).^2);
            % detect the position matches the package position
            if orig_distance == 0
                obj.package_status = 1;
                % get the package
                obj.man_status = 1;
                obj.random_move;
                % decide to do something else
                return
            end
            % decide to do a better path to get the package
            while true
                temp = ceil(rand()*8); %generate a random integer(1~8)
                update_pos = obj_pos+obj.move_direction{temp};
                update_distance = sum((package_pos-update_pos).^2);
                if (update_distance<orig_distance&&update_pos(1)<(obj.map_boundary+1)&&update_pos(2)<(obj.map_boundary+1)&&update_pos(1)>0&&update_pos(2)>0)
                    obj.position = update_pos;
                    break;
                end
            end
        end
        
    end
end