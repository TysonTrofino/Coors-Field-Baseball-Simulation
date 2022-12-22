% FLuid Dynamics Final Project 2021
% University of Colorado, Boulder
% time for eulers equation
dt=.01;
step = .003;

%Check values
check_before_2002 =0;
check_sea_level = 0;
check_after_2002 = 0;
final_check = 0;

% Max y values
max_y_before_2002 = 0;
max_y_after_2002 = 0;
max_y_sea_level = 0;

% gravity (lbs)
gravity_sea_level = 32.174;
gravity_coors = 32.158;

% set up Baseball Field for Plot
fence_distance_coors = 415;
fence_distance_sea_level = 400;
plot_axis = [-25 600 -15 140];

% Initialize variables
Drag_coefficent = .47;
Lift_coefficent = .15;
baseball_mass = 0.3196703; % kg to lbs
spin = (2000/60)*(2*pi);  % 2000 rpm / 60 sec/min
exit_velo_of_baseball_off_bat = 166; %110 MPH to 166 FPS
ang = 30;  % Launch angle of a baseball

 x_pitched_ball = 60;  %Starting x position for the baseball
 y_pitched_ball = 6;    %Starting y position for the baseball
          

% Radius of Baseball
radius_before_2002 = 0.22966/2;
radius_sea_level_and_after = 0.24934/2;

%Cross cut area of a baseball
Area_sea_level_and_after = pi*radius_sea_level_and_after.^2;
Area_before = pi*radius_before_2002.^2;


%Defines the acceleration in the x and y direction
accelx_coors_before_2002 = 0;
accelx_coors_after_2002 = 0;
accelx_sea_level = 0;

accely_coors_before_2002= -gravity_coors;
accely_coors_after_2002= -gravity_coors;
accely_sea_level = -gravity_sea_level;

% Air Density
air_density_anywhere_else = 2.377*10^-3;
air_density_coors = 0.002031648;


% Drag Calculation
Drag_sea_level = (air_density_anywhere_else*Drag_coefficent*Area_sea_level_and_after)/2;
Drag_after = (air_density_coors*Drag_coefficent*Area_sea_level_and_after)/2;
Drag_before = (air_density_coors*Drag_coefficent*Area_before)/2;

% Initial Lift Calculations
Lift_sea_level = (Lift_coefficent*air_density_anywhere_else*(16/3)*pi.^2*radius_sea_level_and_after.^3*spin*radius_sea_level_and_after);
Lift_before = (Lift_coefficent*air_density_coors*(16/3)*pi.^2*radius_before_2002.^3*spin*radius_before_2002);
Lift_after = (Lift_coefficent*air_density_coors*(16/3)*pi.^2*radius_sea_level_and_after.^3*spin*radius_sea_level_and_after);


% Initial Velocities
xvelo_coors_before_2002 = init_velocity_calc(exit_velo_of_baseball_off_bat,cosd(ang));
yvelo_coors_before_2002 = init_velocity_calc(exit_velo_of_baseball_off_bat,sind(ang));

xvelo_coors_after_2002 = init_velocity_calc(exit_velo_of_baseball_off_bat,cosd(ang));
yvelo_coors_after_2002 = init_velocity_calc(exit_velo_of_baseball_off_bat,sind(ang));

xvelo_sea_level = init_velocity_calc(exit_velo_of_baseball_off_bat,cosd(ang));
yvelo_sea_level = init_velocity_calc(exit_velo_of_baseball_off_bat,sind(ang));


figure(1),clf

% Coors Field Before 2002 Plot 
subplot(3,1,1);
hold on
plotfield(plot_axis,fence_distance_coors);
ht=plot(x_pitched_ball,y_pitched_ball,'ro','MarkerSize',1);
title('Coors Field Before 2002');
hold off

% Coors Field After 2002 Plot
subplot(3,1,3);
hold on
plotfield(plot_axis,fence_distance_coors);
hb = plot(x_pitched_ball,y_pitched_ball,'ro','MarkerSize',1);
title('Coors Field After 2002');
hold off

% Sea Level Plot
subplot(3,1,2);
hold on
plotfield(plot_axis,fence_distance_sea_level);
hm = plot(x_pitched_ball,y_pitched_ball,'ro','MarkerSize',1);
title('Ballparks at Sea Level');

hold off
    

   % Animation to show pitch for all three subplots.
   % All subplots have the same pitch.  Assumming gravity did not effect
   % the pitch in this.
    pause(3);
    while(x_pitched_ball >0)
    x_pitched_ball = baseball_pitch(x_pitched_ball,300,dt);
    y_pitched_ball = baseball_pitch(y_pitched_ball,3/20,1);

   
    set(ht,'Xdata',x_pitched_ball,'Ydata',y_pitched_ball);
    set(hb,'Xdata',x_pitched_ball,'Ydata',y_pitched_ball);
    set(hm,'Xdata',x_pitched_ball,'Ydata',y_pitched_ball);
    
    pause(dt);
    end
    
 % sets x and y equal where the pitch is at home plate
 x_before_2002 = x_pitched_ball;
 y_before_2002 = y_pitched_ball;
    
 x_after_2002 = x_pitched_ball;
 y_after_2002 = y_pitched_ball;
 
 x_sea_level = x_pitched_ball;
 y_sea_level = y_pitched_ball;
    
 dt = .07;
    
while (final_check == 0)
       
    %Calculate the position of the x and y for the coors before 2002
    force_lift_x = force_Lift_Drag(-Lift_before,yvelo_coors_before_2002);
    force_drag_x = force_Lift_Drag(Drag_before,xvelo_coors_before_2002^2);
    
    force_lift_y = force_Lift_Drag(Lift_before,xvelo_coors_before_2002);
    force_drag_y = force_Lift_Drag(Drag_before,yvelo_coors_before_2002^2);

    accelx_coors_before_2002 = acceleration_calculation(force_lift_x,force_drag_x,baseball_mass,gravity_coors,'x');
    accely_coors_before_2002 = acceleration_calculation(force_lift_y,force_drag_y,baseball_mass,gravity_coors,'y');
      
    xvelo_coors_before_2002 = velocity_calculation(xvelo_coors_before_2002, accelx_coors_before_2002, dt);
    yvelo_coors_before_2002 = velocity_calculation(yvelo_coors_before_2002, accely_coors_before_2002, dt);
	
    x_before_2002 = position_calculation(x_before_2002, xvelo_coors_before_2002, accelx_coors_before_2002, dt);
    y_before_2002 = position_calculation(y_before_2002, yvelo_coors_before_2002, accely_coors_before_2002, dt);

    
    % Calculate the position of the x and y for the coors after 2002
    force_lift_x = force_Lift_Drag(-Lift_after,yvelo_coors_after_2002);
    force_drag_x = force_Lift_Drag(Drag_after,xvelo_coors_after_2002^2);
    
    force_lift_y = force_Lift_Drag(Lift_after,xvelo_coors_after_2002);
    force_drag_y = force_Lift_Drag(Drag_after,yvelo_coors_after_2002^2);

    accelx_coors_after_2002 = acceleration_calculation(force_lift_x,force_drag_x,baseball_mass,gravity_coors,'x');
    accely_coors_after_2002 = acceleration_calculation(force_lift_y,force_drag_y,baseball_mass,gravity_coors,'y');
      
    xvelo_coors_after_2002 = velocity_calculation(xvelo_coors_after_2002, accelx_coors_after_2002, dt);
    yvelo_coors_after_2002 = velocity_calculation(yvelo_coors_after_2002, accely_coors_after_2002, dt);
	
    x_after_2002 = position_calculation(x_after_2002, xvelo_coors_after_2002, accelx_coors_after_2002, dt);
    y_after_2002 = position_calculation(y_after_2002, yvelo_coors_after_2002, accely_coors_after_2002, dt);

    
    % Calculate the position of the x and y at sea level
    force_lift_x = force_Lift_Drag(-Lift_sea_level,yvelo_sea_level);
    force_drag_x = force_Lift_Drag(Drag_sea_level,xvelo_sea_level^2);
    
    force_lift_y = force_Lift_Drag(Lift_sea_level,xvelo_sea_level);
    force_drag_y = force_Lift_Drag(Drag_sea_level,yvelo_sea_level^2);

    accelx_sea_level = acceleration_calculation(force_lift_x,force_drag_x,baseball_mass,gravity_sea_level,'x');
    accely_sea_level = acceleration_calculation(force_lift_y,force_drag_y,baseball_mass,gravity_sea_level,'y');
      
    xvelo_sea_level = velocity_calculation(xvelo_sea_level, accelx_sea_level, dt);
    yvelo_sea_level = velocity_calculation(yvelo_sea_level, accely_sea_level, dt);
	
    x_sea_level = position_calculation(x_sea_level, xvelo_sea_level, accelx_sea_level, dt);
    y_sea_level = position_calculation(y_sea_level, yvelo_sea_level, accely_sea_level, dt);
          
           
    %Calculate the max y position for the board
    max_y_before_2002 = maxCalculation(max_y_before_2002,y_before_2002);
    max_y_after_2002 = maxCalculation(max_y_after_2002,y_after_2002);
    max_y_sea_level = maxCalculation(max_y_sea_level,y_sea_level);


    if(y_before_2002>0)
        plotBaseballPosition(1,x_before_2002,y_before_2002,max_y_before_2002,ht);
    else
        check_before_2002 = 1;
    end
    
    if(y_sea_level > 0)
        plotBaseballPosition(2,x_sea_level,y_sea_level,max_y_sea_level,hm);
     else
        check_sea_level = 1;
    end


    if(y_after_2002 > 0)
        plotBaseballPosition(3,x_after_2002,y_after_2002,max_y_after_2002,hb);
    else
        check_after_2002 = 1;
    end
           
    
    pause(.01);
    
    
    if(check_before_2002 == 1 && check_after_2002 == 1 && check_sea_level == 1)
        final_check =1; 
    else
        final_check = 0;
    end
        dt = dt+step;
end
    
    
    
function velocity = init_velocity_calc(exit_velo_of_baseball_off_bat, angle)
    velocity = exit_velo_of_baseball_off_bat*angle;

end

%These are very simple functions but they are used so calculations do not
%get duplicated and are easier to change over time.

% Calcualte the postion of the baseball during the pitch
function axis_Location = baseball_pitch(axis, coefficent, dt)

axis_Location = axis - coefficent*dt;

end

% Force of lift or drag.  The appropriate velocity if calcualted above and
% factored in
function force = force_Lift_Drag(lift_or_drag_value,velocity)
    force = lift_or_drag_value*velocity;

end             

% projectile motion acceleration calculation 
function acceleration = acceleration_calculation(lift,drag,baseball_mass,gravity,x_or_y)
    if(x_or_y == 'x')
        acceleration = (lift-drag)/(baseball_mass/gravity);
    else
        acceleration = (lift-drag - baseball_mass)/(baseball_mass/gravity);
    end

end

% projectile motion velocity calculation
function velocity = velocity_calculation(velo, accel, dt)
    velocity = velo + accel*dt;
end

% projectile motion position calculation
function position = position_calculation(pos, velo, accel, dt)
    position = pos + velo*dt + (1/2)*accel*dt.^2;
end

% Max calculation
function max_y = maxCalculation(max_y,y)
    if(max_y<y)
        max_y = y;
    end
end

% Plot the baseball after the batter hit the ball
function plotBaseballPosition(subplot_pos,x_pos,y_pos,y_max,handleVal)
    subplot(3,1,subplot_pos);
    hold on
    plot(x_pos,y_pos,'ko','MarkerSize',.2);
    projectileBoard(x_pos,y_max);
    hold off
    set(handleVal,'Xdata',x_pos,'Ydata',y_pos);
end

