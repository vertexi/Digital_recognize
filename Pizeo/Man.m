classdef Man < handle
    properties(Constant)
        velocity = 1;
        move_direction = {[0,-1],[1,-1],[1,0],[1,1],[0,1],[-1,1],[-1,0],[-1,-1]};
        map_boundary = 40;
    end
    properties
        position %man's position
        package %man's package(contains wheight and package position)
        package_status %a man carry his package
        man_status % sit status
    end
    methods
        function obj = Man()
            %Man's constructor
            obj.position = randi(Man.map_boundary,1,2);
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
            if obj.man_status==0
                % man moving
                if obj.package_status = 1
                    if rand()<0.1
                        obj.man_status = 1;
                        % man sit now
                        obj.package_status = 0;
                        % detach his package
                    else
                        obj.random_move;
                        % you are free! move now!
                    end
                end
            else
                % man is siting
                if rand()<0.1
                    obj.man_status = 0;
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
            end
            
        end
        
        
        
    end
end