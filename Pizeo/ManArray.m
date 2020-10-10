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
        
        
    end
end