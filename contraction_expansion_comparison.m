%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%              COMPARISON OF MEASURES FOR CONTRACTION OR EXPANSION             % 
%            OF THE HUMAN BODY FROM POINT-CLOUD MOTION-CAPTURE DATA            %
%                                                                              %
%                                 DECEMBER 2022                                %
%                                                                              %
%                          Juan Ignacio Mendoza Garay                          %
%                               doctoral student                               %
%                 Department of Music, Art and Culture Studies                 %
%                            University of Jyväskylä                           %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ==============================================================================
% INFORMATION

% This program requires:
%   Matlab
%   Mocap Toolbox
%   mcspread

% This program has been tested with:
%   Matlab R2017b
%   Mocap Toolbox v1.5.2

% The Mocap Toolbox v1.5.2 can be downloaded from this webpage:
%   https://gitlab.jyu.fi/juigmend/mocaptoolbox_1_5_2

% Description:
%   Comparison of bodily expansion/contraction using three measures:
%       - sum of distances between markers
%       - sum of distances between markers and centroid
%       - bounding rectangle

% Instructions:
%   Edit the values indicated with an arrow like this: <--- (length of the arrow may vary)
%   Run the program, close your eyes and hope for the best.

% ==============================================================================
% Initialisation:

clc
clear
close all
% restoredefaultpath
start_time = tic;

% ------------------------------------------------------------------------------
% Declare paths, filenames and variables:

      info.toolbox_path = ' '; % <--- folder where the Mocap Toolbox is
      info.project_path = ' '; % <--- folder where the project files are and to save figures

% .............................................................................. 
% Define markers and additional (dotted) lines:

i_skl = 0;

i_skl = i_skl + 1;
info.markers{i_skl} = [... % <--- rows: markers; columns: dimensions (horizontal,vertical)
                       -400,    0 ; %  1) left toe
                        400,    0 ; %  2) right toe
                       -380,    0 ; %  3) left ankle
                        380,    0 ; %  4) right ankle
                       -300,  300 ; %  5) left knee
                        300,  300 ; %  6) right knee
                       -180,  630 ; %  7) left hip
                        180,  630 ; %  8) right hip
                       -200, 1100 ; %  9) left shoulder
                        200, 1100 ; % 10) right shoulder
                       -220,  850 ; % 11) left elbow
                        220,  850 ; % 12) right elbow
                       -210,  600 ; % 13) left wrist
                        210,  600 ; % 14) right wrist
                          0, 1100 ; % 15) neck base
                          0, 1300   % 16) head
                       ];

i_skl = i_skl + 1;
info.markers{i_skl} = [... % <--- rows: markers; columns: dimensions (horizontal,vertical)
                       -400,    0 ; %  1) left toe
                        400,    0 ; %  2) right toe
                       -380,    0 ; %  3) left ankle
                        380,    0 ; %  4) right ankle
                       -300,  300 ; %  5) left knee
                        300,  300 ; %  6) right knee
                       -180,  630 ; %  7) left hip
                        180,  630 ; %  8) right hip
                       -200, 1100 ; %  9) left shoulder
                        200, 1100 ; % 10) right shoulder
                       -400,  870 ; % 11) left elbow
                        400,  870 ; % 12) right elbow
                       -370,  620 ; % 13) left wrist
                        370,  620 ; % 14) right wrist
                          0, 1100 ; % 15) neck base
                          0, 1300   % 16) head
                       ];

info.addlines{i_skl} = [... % <--- additional lines, rows: point; columns: dimensions (horizontal,vertical,index)
                       -400,  870, 1 ; 
                       -190,  870, 1 ;
                        400,  870, 2 ; 
                        190,  870, 2
                       ];
                   
i_skl = i_skl + 1;
info.markers{i_skl} = [... % <--- rows: markers; columns: dimensions (horizontal,vertical)
                       -400,    0 ; %  1) left toe
                        400,    0 ; %  2) right toe
                       -380,    0 ; %  3) left ankle
                        380,    0 ; %  4) right ankle
                       -300,  300 ; %  5) left knee
                        300,  300 ; %  6) right knee
                       -180,  630 ; %  7) left hip
                        180,  630 ; %  8) right hip
                       -200, 1100 ; %  9) left shoulder
                        200, 1100 ; % 10) right shoulder
                       -220, 1350 ; % 11) left elbow
                        220, 1350 ; % 12) right elbow
                       -160, 1600 ; % 13) left wrist
                        160, 1600 ; % 14) right wrist
                          0, 1100 ; % 15) neck base
                          0, 1300   % 16) head
                       ];
                   
info.addlines{i_skl} = [... % <--- additional lines, rows: point; columns: dimensions (horizontal,vertical,index)
                          0, 1280, 1 ; 
                       -160, 1600, 1 ;
                          0, 1280, 2 ; 
                        160, 1600, 2
                       ];

i_skl = i_skl + 1;
info.markers{i_skl} = [... % <--- rows: markers; columns: dimensions (horizontal,vertical)
                       -400,    0 ; %  1) left toe
                        400,    0 ; %  2) right toe
                       -380,    0 ; %  3) left ankle
                        380,    0 ; %  4) right ankle
                       -300,  300 ; %  5) left knee
                        300,  300 ; %  6) right knee
                       -180,  630 ; %  7) left hip
                        180,  630 ; %  8) right hip
                       -200, 1100 ; %  9) left shoulder
                        200, 1100 ; % 10) right shoulder
                       -580, 1080 ; % 11) left elbow
                        580, 1080 ; % 12) right elbow
                      -1010, 1000 ; % 13) left wrist
                       1010, 1000 ; % 14) right wrist
                          0, 1100 ; % 15) neck base
                          0, 1300   % 16) head
                       ];

info.addlines{i_skl} = [... % <--- additional lines, rows: point; columns: dimensions (horizontal,vertical,index)
                      -1010, 1000, 1 ; 
                       -190, 1000, 1 ;
                       1010, 1000, 2 ; 
                        190, 1000, 2 ;
                       ];

n_skl = length(info.markers);

% .............................................................................. 
% Define connections:

i_skl = 0;

i_skl = i_skl + 1;
info.conn{i_skl} = ... % <-- markers' connections to make skeletons ( row 1 = start, row 2 = end, columns = connections)
                   [ 1 2 3 4 5 6 7 7  8  9  9 10 11 12 15 ; ...
                     3 4 5 6 7 8 8 9 10 10 11 12 13 14 16 ] ;
                 
% .............................................................................. 
% Define visualisation parameters:

vis_param.figsize{1} = [1200,320];  % <--- figure size
vis_param.figsize{2} = [600,320];   % <--- figure size
vis_param.msize      = 8;           % <--- marker size
vis_param.cwidth     = 2;           % <--- connector width
vis_param.skcolor    = 'wkkkk';     % <--- skeleton colours: [background marker connection trace markernumber] ('kwwww') or RGB triplet (5x3)
vis_param.brcolor    = [1,1,1]*0.5; % <--- bounding rectangle, centroid and dotted line colour as RGB triplet
vis_param.brwidth    = 2;           % <--- bounding rectangle and dotted line width
vis_param.plgrid     = [1,n_skl];   % <--- plot grid: rows, columns 
vis_param.fontsize   = 20;          % <--- font size

% ------------------------------------------------------------------------------
if ~exist('paths_added','var')
    addpath(genpath(info.toolbox_path))
    addpath(genpath(info.project_path))
    cd(info.project_path)
    paths_added = true;
end

% ..............................................................................
% visualise skeletons:

ap = mcinitanimpar;
ap.colors = vis_param.skcolor;
ap.msize = vis_param.msize;
ap.cwidth = vis_param.cwidth;
ap.child = 1;
ap.output = [];

ap.limits = [0,0,0,0]; % min x, max x, min y, max y
all_limits{n_skl} = [];

for i_skl = 1:n_skl
    
    all_limits{i_skl} = [0,0,0,0]; % min x, max x, min y, max y
    
    i_limits = 1;

    for i_dim = [1,2] % x, y
        
        this_minmax = minmax(info.markers{i_skl}(:,i_dim)');

        end_col = (i_dim * 2);
        all_limits{i_skl}(end_col-1:end_col) = this_minmax;
        
        for i_mm = [1,2] % min, max
             
            if (i_mm == 1) && ( this_minmax(i_mm) < ap.limits(i_limits) )
                
                ap.limits(i_limits) = this_minmax(i_mm);
                
            elseif (i_mm == 2) && ( this_minmax(i_mm) > ap.limits(i_limits) )
                
                ap.limits(i_limits) = this_minmax(i_mm);
            end
            
            i_limits = i_limits + 1;
        end
    end
end

scores = zeros(3,n_skl);
the_alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
skl_lbls{n_skl} = [];

figh{1} = figure('Position',[0,0,vis_param.figsize{1}]);

for i_skl = 1:n_skl
    
    these_3D_markers = [ info.markers{i_skl}(:,1), zeros(size(info.markers{i_skl},1),1), info.markers{i_skl}(:,2) ];
    these_data = these_3D_markers';
    
    if length(info.conn) == length(info.conn)
        ap.conn = info.conn{1}';
        ap.conncolors = repmat( ap.colors(3) , 1, size(info.conn{1},2) );
    else
        ap.conn = info.conn{i_skl}';
        ap.conncolors = repmat( ap.colors(3) , 1, size(info.conn{i_skl},2) );
    end
    
    mc_data = mcinitstruct('MoCap data', these_data(:)' );

    sp_h = subplot(vis_param.plgrid(1),vis_param.plgrid(2),i_skl);
    mcplotframe( mc_data, 1, ap);
    
    i_score = 0;
    
    % . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    % sum of distances between markers:
    i_score = i_score + 1;
    scores(i_score,i_skl) = mcspread(mc_data);
    
    % . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    % sum of distances between markers and centroid:
    i_score = i_score + 1;
    this_centroid = mean(info.markers{i_skl});
    this_sum = 0;
    for i_mk = 1:mc_data.nMarkers
        
        this_sum = this_sum + norm( [ this_centroid ; info.markers{i_skl}(i_mk,:) ] );
    end
    scores(i_score,i_skl) = this_sum;

    hold on
    plot(this_centroid(1),this_centroid(2),'*','MarkerSize',20,'LineWidth',vis_param.brwidth,'Color',vis_param.brcolor)
    
    
    % . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    % bounding rectangle:
    i_score = i_score + 1;
    scores(i_score,i_skl) = ( abs(diff(all_limits{i_skl}(1:2))) ) * ( abs(diff(all_limits{i_skl}(3:4))) ); 
        
    X = all_limits{i_skl}([1,1,2,2,1]);
    Y = all_limits{i_skl}([3,4,4,3,3]);
    line(X,Y,'LineWidth',vis_param.brwidth,'Color',vis_param.brcolor);
    
    
    skl_lbls{i_skl} = the_alphabet(i_skl);
    text(sp_h.XLabel.Position(1),sp_h.XLabel.Position(2),skl_lbls{i_skl},'FontSize',vis_param.fontsize)   
    
    % . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    % plot additional (dotted) lines:
    
    if ~isempty( info.addlines{i_skl} )
        
        n_lines = max( info.addlines{i_skl}(:,3) );
        
        for i_line = 1:n_lines
            
            ii_line = info.addlines{i_skl}(:,3) == i_line;

            X = info.addlines{i_skl}(ii_line,1);
            Y = info.addlines{i_skl}(ii_line,2);
            
            line(X,Y,'LineStyle',':','LineWidth',vis_param.brwidth,'Color',vis_param.brcolor);
        end
    end
end

scores_rs = zeros(3,n_skl);
for i_s = 1:3
    scores_rs(i_s,:) = rescale( scores(i_s,:)) + 1; % normalise it, don't criticise it
end

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% Comparison table:

comparison_table = array2table(round(scores_rs,2));
comparison_table.Properties.VariableNames = skl_lbls;
comparison_table.Properties.RowNames = {'sum all distances','sum dist. to cent.','bounding rectangle'};

disp(comparison_table)

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% Bar chart:

xtixk_lbl_str = {'  sum all \newlinedistances','sum distances\newline   to centroid','bounding\newlinerectangle'};
gray_gradient = rescale(1:n_skl,0.4,0.9);
gray_gradient = flip(gray_gradient);
cmap = repmat(gray_gradient',1,3);

figh{2} = figure('Position',[0,vis_param.figsize{1}(2),vis_param.figsize{2}])
handle_bar = bar(scores_rs);

set(gca,'XTickLabel',xtixk_lbl_str,'FontSize',vis_param.fontsize,'YLim',[0.5,2])
set( handle_bar , {'FaceColor'},{cmap(1,:),cmap(2,:),cmap(3,:),cmap(4,:)}.')

legend(skl_lbls,'Location','bestoutside')

% . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
% Save figs:

for i_fig = [1,2]
    
    print(figh{i_fig},sprintf('%s/Fig_%i',info.project_path,i_fig),'-dpng','-r300')
end

% ------------------------------------------------------------------------------
% Report computation time:

seconds_elapsed = toc(start_time);
HH = floor(seconds_elapsed / 3600);
seconds_elapsed = seconds_elapsed - HH * 3600;
MM = floor(seconds_elapsed / 60);
SS = seconds_elapsed - MM * 60;
fprintf('completed in %02d:%02d:%02.0f (hours:minutes:seconds)\n',HH,MM,SS)
