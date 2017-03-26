N = 10000000; %total time steps
delta_t = 0.0001;
n = 100; %number of particles

positions, velocities, deltat, steps, global_potential, local


%method = simple_euler

%method = rk4
%method = backward_euler

%method = simplectic

positions = 
velocities = 

positions = (rand(3,n)-0.5)*3;
positions(1,1:50) = positions(1,1:50)+5;
positions(1,51:100) = positions(1,51:100)-5;
                 


velocities =(rand(3,n)-0.5)*9;

velocities(2,1:50) = velocities(2,1:50)+8;
velocities(2,51:100) = velocities(2,51:100)-8;
                 
global_potential = @(r) -1./r;
local_potential = @(r) 25./r - 1.*r;

for time = 1:N
    x_pos = zeros(n) + positions(1,:);
    x_dist = x_pos-x_pos';
    y_pos = zeros(n) + positions(2,:);
    y_dist = y_pos-y_pos';
    z_pos = zeros(n) + positions(3,:);
    z_dist = z_pos-z_pos';
    dist = (x_dist.^2+y_dist.^2+z_dist.^2).^0.5+I;
    
    abs_dist = (x_pos.^2+y_pos.^2+z_pos.^2).^0.5;
    abs_force_mag = abs_force(abs_dist);
    
    x_hat = x_dist./dist;
    y_hat = y_dist./dist;
    z_hat = z_dist./dist;
    
    abs_x_hat = x_pos./abs_dist;
    abs_y_hat = y_pos./abs_dist;
    abs_z_hat = z_pos./abs_dist;
    
    force_mag = force(dist);
    
    force_mag(logical(I)) = 0;
    
    velocities(1,:) = velocities(1,:) + delta_t.*sum(force_mag.*x_hat);
    velocities(2,:) = velocities(2,:) + delta_t.*sum(force_mag.*y_hat);
    velocities(3,:) = velocities(3,:) + delta_t.*sum(force_mag.*z_hat);
    
    velocities(1,:) = velocities(1,:) + delta_t.*sum(abs_force_mag.*abs_x_hat);
    velocities(2,:) = velocities(2,:) + delta_t.*sum(abs_force_mag.*abs_y_hat);
    velocities(3,:) = velocities(3,:) + delta_t.*sum(abs_force_mag.*abs_z_hat);
    
    positions = positions+velocities.*delta_t;
    
    if mod(time,100) == 0
        scatter3(positions(1,:), positions(2,:), positions(3,:));
        axis([-10,10,-10,10,-10,10]);
        pause(0.001);
        
    end
    
end