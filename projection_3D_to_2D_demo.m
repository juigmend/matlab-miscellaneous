%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                  Parallel Projection of 3D data to a plane                   %
%                                                                              %
%                                                   Juan Ignacio Mendoza Garay %
%                                                             doctoral student %
%                                   Music Department - University of Jyv?skyl? %
%                                                                  April, 2016 %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% These scripts have been tested with Matlab R2015a

% ==============================================================================
% Description:

% Plot data orthogonally projected to a plane.
% This is useful to render a 2D projection of 3D data, for example to visualize
% motion capture data from an observer's viewpoint.

% Steps 1 to 7 show a method that projects onto a plane tangential to a sphere
% over the data. It requires the input of rotation origin, horizontal angle 
% and elevation.

% Steps 8 to 10 show a method that uses the mcrotate function of the
% Mocap Toolbox (c.f. Burger & Toiviainen, 2013). The data is rotated and then 
% projected to an arbitrary plane. It requires the input of rotation axis, 
% point in the axis and angle around the axis. It can only take rotation of one 
% axis at a time. Rotations in between need separate rotations 
% (e.g. first rotate around one axis and then rotate around another axis).

% ------------------------------------------------------------------------------
% Instructions:

% Go through each cell sequentially and amuse yourself with the code, 
% the figures and the maths behind. A cell is bounded by two percentage signs 
% (%) together.
% Variables that are pointed with an arrow (<---) are most encouraged to be 
% changed.

% ==============================================================================
% Initialisation:

close all
clear
clc

%% ------------------------------------------------------------------------------
% 1) Set space and plot a 3D point of origin (black)

x_lim = [-100,100]; % <--- x limits
y_lim = [-100,100]; % <--- y limits
z_lim = [0,200];    % <--- z limits

fig_1 = figure;
plot3(0,0,0,'.k','markersize',10)
xlim(x_lim)
ylim(y_lim)
zlim(z_lim)
fsize = 18;
xlabel('x','fontsize',fsize)
ylabel('y','fontsize',fsize)
zlabel('z','fontsize',fsize)
axis square
hold on
grid on
set(fig_1, 'WindowStyle', 'docked') 

%% ..............................................................................
% 2) Set and plot a 3D datum point (red)

datum_point = [20 22 30]; % <--- datum point [x y z]
plot3(datum_point(1),datum_point(2),datum_point(3),'.r','markersize',30)

%% ..............................................................................
% 3) Set and plot an arbitrary point of origin (blue)

% arbitrary_origin = [60 60 5];
arbitrary_origin = [-20 0 0]; % <--- arbitrary origin point [x y z]

plot3(arbitrary_origin(1),arbitrary_origin(2),arbitrary_origin(3),'.','markersize',40,'color',[0.6 0.7 1])

%% ..............................................................................
% 4) Set and plot a vector (normal) from the origin and a plane 
%    orthogonal to it (blue).

% The projection of data will be done onto the plane perpendicular to this vector,
% so that the resulting lines connecting original and projected points will be 
% parallel (A.K.A. orthographic). This means that there is no vanishing point 
% dictating perspective.

normal_length = 50; % <--- length (A.K.A. radius) from the arbitrary origin point 
normal_elevation = 45; % <--- elevation (A.K.A. 90? - phi): angle respect to the xy plane  (degrees)
normal_rotation = 90; % <--- rotation (A.K.A. azimuth, theta): angle respect to x axis in the xy plane (degrees)

phi = ((normal_elevation-90)/180)*pi; % convert to radians
theta = -(normal_rotation/180)*pi; % convert to radians

% When the plane is vertical the plane equation (see 5b and 5c) cannot be solved so a very small tilt is added:
if abs(phi) == pi/2
    phi = phi + 1e-10;
end

% 4.a Set and plot a vector (normal) from the origin (blue)
% The measures radius, phi and theta are spherical coordinates, which will be
% converted to cartesian coordinates using trigonometry:
tip_point(1,1) = normal_length * cos(theta) * sin(phi) + arbitrary_origin(1); % x coordinate normal vector's tip
tip_point(1,2) = normal_length * sin(theta) * sin(phi) + arbitrary_origin(2); % y coordinate normal vector's tip
tip_point(1,3) = normal_length              * cos(phi) + arbitrary_origin(3); % z coordinate normal vector's tip
normal_vector = [arbitrary_origin; tip_point];
plot3(normal_vector(:,1),normal_vector(:,2),normal_vector(:,3),'marker','.','markersize',20,'color',[0 0 1],'linewidth',2)

plane_width = 400; % width projected to xy

% 4.b Make a vertical point perpendicular to the normal vector (blue):
perp_point_radius = sqrt(normal_length^2 + (plane_width/8)^2);
perp_point_phi = asin(plane_width/(8*perp_point_radius)) + phi;
perp_points(1,1) = perp_point_radius * cos(theta) * sin(perp_point_phi) + arbitrary_origin(1); % x coordinate 
perp_points(1,2) = perp_point_radius * sin(theta) * sin(perp_point_phi) + arbitrary_origin(2); % y coordinate 
perp_points(1,3) = perp_point_radius              * cos(perp_point_phi) + arbitrary_origin(3); % z coordinate 
perp_vector = [perp_points; tip_point]; 
plot3(perp_vector(:,1),perp_vector(:,2),perp_vector(:,3),'.:','markersize',20,'color',[0 0 1],'linewidth',2)
hold on

% 4.c Make a plane from the perpendicular point to the normal vector, and plot (translucent blue):
tip_point_offset = tip_point - arbitrary_origin;
d = -perp_points(1,:)*tip_point_offset';
plane_corners = zeros(4,1,3);
plane_corners(:,:,1) = reshape(kron([-1, 1; 1,  -1],200),[4,1]) ; % x coordinates
plane_corners(:,:,2) = reshape(repmat([plane_width/2, -plane_width/2],2,1),[4,1]) ; % y coordinates
plane_corners(:,:,3) = (-tip_point_offset(1)*plane_corners(:,:,1) - tip_point_offset(2)*plane_corners(:,:,2) - d)/tip_point_offset(3)... % solve plane equation for z
    ; 
fill3(plane_corners(:,:,1),plane_corners(:,:,2),plane_corners(:,:,3),'b')
alpha(0.1)


%% ..............................................................................
% 5) Plot the data point to a plane orthogonal to the normal vector (green)

tip_point_normalized = tip_point_offset/norm(tip_point_offset); % normalize it, don't criticize it
tip_point_normalized_sqr = tip_point_normalized.'*tip_point_normalized ; 
projected_point_1 = datum_point * ( eye(3) - tip_point_normalized_sqr )...
    + repmat( perp_points(1,:) * tip_point_normalized_sqr, size(datum_point,1), 1 );
plot3(projected_point_1(:,1),projected_point_1(:,2),projected_point_1(:,3),'marker','.','markersize',30,'color',[0 0.7 0],'linewidth',2)

% view([0,89]) % [azimuth, elevation]

%% ..............................................................................
% 6) Make and plot a 3D trajectory (red)

% a sinusoidal signal:
trajectory_length = 50;
amplitude = 10;
frequency = 3;
sin_signal = zeros(trajectory_length,3);
sin_signal(:,1) = [1:trajectory_length];
sin_signal(:,3) = amplitude * sin(frequency * sin_signal(:,1)/(2*pi));
sin_signal = sin_signal + repmat(datum_point,50,1); % offset to macth datum point
plot3(sin_signal(:,1),sin_signal(:,2),sin_signal(:,3),'-r','linewidth',2)

%% ..............................................................................
% 7) Project the trajectory to the orthogonal plane and plot (green)

projected_trajectory_1 = sin_signal * ( eye(3) - tip_point_normalized_sqr )...
    + repmat( perp_points(1,:) * tip_point_normalized_sqr, size(sin_signal,1), 1 );
plot3(projected_trajectory_1(:,1),projected_trajectory_1(:,2),projected_trajectory_1(:,3),'color',[0 0.7 0],'linewidth',2)

%% ..............................................................................
% The next steps require the Mocap Toolbox.
%% ..............................................................................
% 8) Reset plane rotation and elevation arbitrarily to zero. 
%    In a new figure plot the plane (blue) and the sinusoidal trajectory 
%    (translucent red).

addpath '/Users/juigmend/Downloads/MoCapToolbox_v1.5/mocaptoolbox' % add path of Mocap Toolbox

% A mocap structure is the output of the function mcread, which reads 
% motion-capture files in different formats. Since the data used here is 
% synthetic, there is no point in using the mcread function, so a mocap structure
% is made from scratch including the sinusoidal trajectory data:
sin_signal_struct.type = 'MoCap data';
sin_signal_struct.filename = 'sin_signal';
sin_signal_struct.nFrames = size(sin_signal,1);
sin_signal_struct.nCameras = []; 
sin_signal_struct.nMarkers = 1;
sin_signal_struct.freq = 10;
sin_signal_struct.nAnalog = 0;
sin_signal_struct.anaFreq = [];
sin_signal_struct.timederOrder = 0; % position data
sin_signal_struct.markerName = {'foo'};
sin_signal_struct.data = sin_signal; 
sin_signal_struct.analogdata = [];
sin_signal_struct.other = ['this is a 3D sinusoidal trajectory to be projected onto a plane'];
% for the purpose of this demo all fields but .nFrames and .data could have any value

fig_2 = figure;
plot3(0,0,0,'.k','markersize',10)
xlim(x_lim)
ylim(y_lim)
zlim(z_lim)
fsize = 18;
xlabel('x','fontsize',fsize)
ylabel('y','fontsize',fsize)
zlabel('z','fontsize',fsize)
axis square
hold on
grid on
set(fig_2, 'WindowStyle', 'docked') 

fill3(reshape(kron([-1, 1; 1,  -1],x_lim(2)),[4,1]),repmat(y_lim(2),4,1),[0;0;z_lim(2);z_lim(2)],'b') % plot static plane
alpha(0.1)
plot3(sin_signal(:,1),sin_signal(:,2),sin_signal(:,3),'-','linewidth',2,'color',[1 0.8 0.8]) % plot sinusoidal trajectory in light red

%% ..............................................................................
% 9) Rotate the sinusouidal trajectory and plot (red). The trajectory is rotated
%    around an arbitrary axis (blue).

rotation_angle = -60; % <--- rotation angle (A.K.A. theta, in degrees)
rotation_axis = [0 0 1]; % <--- rotation axis (e.g., rotate around z is rotation_axis = [0 0 1])
% The method works well only when the input rotation axis is one of the axis (e.g. [1 0 0], [0 1 0]).
% Other values (e.g. [1 1 0], [0 0 2]) will distort the trajectory.

rotation_axis_point = []; % <--- point in the rotation axis (if none, it will use the centroid of the trajectory)

if isempty(rotation_axis_point) == 1
    rotation_axis_point = median(sin_signal); % this is just to plot the blue line, it is not passed to mcrotate
    rotated_trajectory = mcrotate(sin_signal_struct,rotation_angle,rotation_axis); % rotate respect to the trajectory's centroid
else
    rotated_trajectory = mcrotate(sin_signal_struct,rotation_angle,rotation_axis,rotation_axis_point); % rotate respect to the rotation axis offset by the point
    plot3(rotation_axis_vector(:,1),rotation_axis_vector(:,2),rotation_axis_vector(:,3),'.:','markersize',20,'color',[0 0 1],'linewidth',2) % plot rotation axis point
end
rotation_axis_vector = [ ([x_lim(1),y_lim(1),z_lim(1)].*rotation_axis+rotation_axis_point.*(1 - rotation_axis)); [x_lim(2),y_lim(2),z_lim(2)].*rotation_axis+rotation_axis_point.*(1 - rotation_axis) ];
plot3(rotation_axis_vector(:,1),rotation_axis_vector(:,2),rotation_axis_vector(:,3),'.:','markersize',20,'color',[0 0 1],'linewidth',2) % plot rotation axis
plot3(rotated_trajectory.data(:,1),rotated_trajectory.data(:,2),rotated_trajectory.data(:,3),'-r','linewidth',2) % plot rotated trajectory in red

%% ..............................................................................
% 10) Project the sinusouidal trajectory onto the plane and plot (green)

projected_trajectory_2 = [rotated_trajectory.data(:,1), repmat(y_lim(2),sin_signal_struct.nFrames,1), rotated_trajectory.data(:,3)];
plot3(projected_trajectory_2(:,1),projected_trajectory_2(:,2),projected_trajectory_2(:,3),'color',[0 0.7 0],'linewidth',2)

% axis tight