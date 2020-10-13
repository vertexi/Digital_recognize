num_agent = 400;
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
% //TODO 内置多种预定的压力图和对应的标签 比如全是包裹 一排全是 一列全是 对角线全是包裹 等等为0的情况
% 尝试 动态调整 人的数量 来使整个模型的样本 更具有普适性 和 适应性
% 动态调整 各个概率产出的样本 比如 喜欢丢包在椅子上 不喜欢去拿椅子
% 试加入 人员离开教室 和 不带包加入教室的模拟方案 即增加离开教室概率 和 加入教室概率