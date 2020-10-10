classdef Man < handle
    properties(Constant)
        velocity = 1;
        move_direction = {[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]};
    end
    
    properties
        position %man's position
        package %man's package(contains wheight and package position)
        package_status %a man carry his package
        %1 carray the package
        %0 detach the package
        man_status % sit status
        % 0 sit
        % 1 move
        % 2 to get package
        map_boundary;
    end
    methods
        function obj = Man(map_boundary)
            %Man's constructor
            obj.map_boundary = map_boundary;
            obj.position = randi(obj.map_boundary,1,2);
            package.weight = rand()/2;
            package.position = obj.position;
            obj.package = package;
            obj.package_status = 1;
            obj.man_status = 0;
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
                    if rand()<0.1
                        obj.man_status = 0;
                        % man sit now
                    else
                        obj.random_move;
                        % you are free! move now!
                    end
                else
                    % don't have the package now and moving
                    disp(obj.position)
                    disp(obj.package.position)
                    fprintf('\n')
                    if rand()<0.1
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
                if rand()<0.1
                    obj.man_status = 1;
                    % ooh! I can move now!
                    if rand()<0.1
                        obj.package_status = 0;
                        % I don't wanna carry my package
                        obj.random_move;
                        % now move
                    else
                        obj.package_status = 1;
                        % I will carry my package
                        obj.random_move;
                        % now move
                    end
                else
                    % this man want keep siting to kill himself
                    % so do nothing
                end
            elseif obj.man_status==2
                obj.get_package;
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