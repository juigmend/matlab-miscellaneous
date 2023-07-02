%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                              %
%                    DOWNLOAD ALL TRACKS OF PLAYLISTS FROM                     %
%                             freemusicarchive.org                             %
%                                                                              %
%                                 2 JULY 2023                                  %
%                                                                              %
%                          Juan Ignacio Mendoza Garay                          %
%                               doctoral student                               %
%                 Department of Music, Art and Culture Studies                 %
%                            University of Jyväskylä                           %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% INFORMATION:

% Tested with:

%     Matlab 9 (R2017b).
%     Firefox 78
%     Mac OS 10.11

% Instructions:

%     First, the user must manually sign in to freemusicarchive.org and the 
%     internet browser has to be open. 

%     Test account at freemusicarchive.org: 
%
%           Email address: sagej33000@devswp.com
%                Password: lowellpercival

%     Edit the values indicated with an arrow like this: <---
%     Run the program, close your eyes and hope for the best.

% ==============================================================================
clear
clc
start_time_program = tic;

% ------------------------------------------------------------------------------
% Set paths, parameters, and options:

path.downloads   = '/Users/my_name/Downloads/';       % <--- default folder where the default browser puts downloaded files, by default
path.dest_parent = '/Users/my_name/Music/New Music/'; % <--- parent folder of the folders where the downloaded files will be transferred to

% delay (lower is faster but it might trip):
param.delay.gnrl = 300;  % <--- execution (ms.) 
param.delay.pgld = 2000; % <--- page load (ms.)
param.delay.scrl = 50;   % <--- row scroll (ms.)
param.delay.fdld = 5;    % <--- file download time limit (s.) 
param.delay.ddlg = 2500; % <--- wait for system download dialog window (ms.) 

% screen position:
param.pos.url = [300,70];   % <--- URL field in browser (horizontal left to right, vertical top to bottom)
param.pos.blk = [940,180];  % <--- empty space
param.pos.dlc = [1260,285]; % <--- download track 
param.pos.agg = [400,760];  % <--- 'I understand and agree' button
param.pos.rfr = [80,80];    % <--- browser's 'refresh page' button

param.scr.first = 23; % <--- scroll down so that first song in the list is at the top of the page 
param.scr.row   = 5;  % <--- scroll amount to scroll down one row 

param.removestr = {'| ',' —'}; % <--- remove characters of artist and song not consistent between webpage and filename 

opts.n_limit = []; % <--- try to download at most this number of files ([] = no limit)

% ..............................................................................
% Specify playlist name and URL:

i_al = 0;

i_al = i_al +1;
plists(i_al).alias  = 'Happy_and_Joyful'; % <--- title of the folder to be created for the files of this playlist
plists(i_al).url    = 'https://freemusicarchive.org/member/lowell-percival/happy-and-joyful/'; % <--- URL of the playlist (also called "mix")

% Add more playlists using the same logic:
% i_al = i_al +1;
% plists(i_al).alias  = '';
% plists(i_al).url    = '';

% ------------------------------------------------------------------------------

% load Java stuff:
import java.awt.Robot;
import java.awt.event.*;

% initialise Java robot object:
bot = Robot;
bot.setAutoDelay(param.delay.gnrl) % sets delay for every subsequent bot instruction

delay_wdld = param.delay.fdld * 2;
n_try_dl = 0;
start_time_dl = tic;

n_all_failed = 0;

for i_al = 1:length(plists)
    
    plists(i_al).failed = 0;    
    destination_path = [path.dest_parent,plists(i_al).alias,'/'];
    
    if ~isfolder(destination_path)
        mkdir(path.dest_parent,plists(i_al).alias) 
    end
    
    if i_al > 1
        disp(' ')
    end
    disp(['Playlist ''',plists(i_al).alias,''''])
    
    bot.mouseMove(param.pos.url(1),param.pos.url(2)) % go to URL field in browser

    bot.mousePress(InputEvent.BUTTON1_MASK); % activate URL field in browser
    bot.mouseRelease(InputEvent.BUTTON1_MASK);
       
    clipboard('copy',plists(i_al).url)
    
    bot.keyPress(KeyEvent.VK_META) % select all
    bot.keyPress(KeyEvent.VK_A)
    bot.keyRelease(KeyEvent.VK_META)
    bot.keyRelease(KeyEvent.VK_A)
    
    bot.keyPress(KeyEvent.VK_META) % paste url to URL field
    bot.keyPress(KeyEvent.VK_V)
    bot.keyRelease(KeyEvent.VK_META)
    bot.keyRelease(KeyEvent.VK_V)
    bot.keyPress(KeyEvent.VK_ENTER)
    bot.keyRelease(KeyEvent.VK_ENTER)

    bot.delay(param.delay.pgld) % wait for page to load

    bot.mouseMove(param.pos.blk(1),param.pos.blk(2)) % go to empty space
    
    bot.mousePress(InputEvent.BUTTON1_MASK); % activate page
    bot.mouseRelease(InputEvent.BUTTON1_MASK);
    
    bot.keyPress(KeyEvent.VK_META) % select all
    bot.keyPress(KeyEvent.VK_A)
    bot.keyRelease(KeyEvent.VK_META)
    bot.keyRelease(KeyEvent.VK_A)
    
    bot.keyPress(KeyEvent.VK_META) % copy content of page
    bot.keyPress(KeyEvent.VK_C)
    bot.keyRelease(KeyEvent.VK_META)
    bot.keyRelease(KeyEvent.VK_C)

    page_content = clipboard('paste');
    iv_cr = regexp(page_content,'\n'); % index of carriage returns
    playlist_info = []; % initialise playlist information
    i_cr = find(iv_cr > strfind(page_content,'Duration'),1); % end of header
    keep_going_1 = true;
    
    while keep_going_1
        
        this_track_info = page_content( iv_cr(i_cr) : iv_cr(i_cr + 1) );
        this_track_info = split(this_track_info,' by ');
        keep_going_1 = length(this_track_info) == 2; % if length is 1, then it is the end of the list
        
        if keep_going_1
            
            this_track    = this_track_info{1}(2:end);
            this_artist   = this_track_info{2}(1:end-1);
            playlist_info = [ playlist_info ; {this_track,this_artist}];
            
            keep_going_2 = true;
            while keep_going_2
                
                this_str = page_content( iv_cr(i_cr) : iv_cr(i_cr +1));
                keep_going_2 = ~contains(this_str,':') || ( length(this_str) ~= 7 ); % durations (e.g., 02:22) indicate end of line
                i_cr = i_cr +1;
            end
        end
    end

    % . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
    
    for i_track = 1:size(playlist_info,1)

        bot.mousePress(InputEvent.BUTTON1_MASK); % click to activate page
        bot.mouseRelease(InputEvent.BUTTON1_MASK);
        
        bot.mouseMove(param.pos.dlc(1),param.pos.dlc(2)) % go to download click position
        bot.mouseWheel( -param.scr.first ) % scroll to first in the list
        
        if i_track > 1
            
            bot.setAutoDelay(param.delay.scrl)
            
            for i_num = 2:i_track % scroll one row at a time (all at once won't work)
                
                bot.mouseWheel( -param.scr.row )
            end
        end

        bot.delay(param.delay.gnrl)
        bot.delay(param.delay.gnrl)
        
        bot.mousePress(InputEvent.BUTTON1_MASK); % activate screen
        bot.mouseRelease(InputEvent.BUTTON1_MASK);
        
        bot.mousePress(InputEvent.BUTTON1_MASK); % click download button
        bot.mouseRelease(InputEvent.BUTTON1_MASK);

        bot.setAutoDelay(param.delay.gnrl)
        bot.delay(param.delay.gnrl)
        
        bot.mouseMove(param.pos.agg(1),param.pos.agg(2)) % go to 'I understand and agree' button
                
        bot.mousePress(InputEvent.BUTTON1_MASK); % activate screen
        bot.mouseRelease(InputEvent.BUTTON1_MASK);
        
        bot.mousePress(InputEvent.BUTTON1_MASK); % click button
        bot.mouseRelease(InputEvent.BUTTON1_MASK);

        bot.delay(param.delay.ddlg)
        
        bot.keyPress(KeyEvent.VK_ENTER) % select 'OK' in download system dialog window
        bot.keyRelease(KeyEvent.VK_ENTER)

        % remove unwanted characters:
        this_track  = playlist_info{i_track,1};
        this_artist = playlist_info{i_track,2};
        for i_rem = 1:length(param.removestr)
            
            this_track  = erase(this_track,param.removestr{i_rem});
            this_artist = erase(this_artist,param.removestr{i_rem});
        end

        % check if file has been downloaded:
        safety_count = 0;
        download_failed = true; % start assuming that the download has failed
        while download_failed
            
            pause(0.5)
            dl_dir_snapshot = dir([path.downloads,'*.mp3']);
            
            for i_dlds = 1:length(dl_dir_snapshot)

                if     contains(dl_dir_snapshot(i_dlds).name,this_track)...
                    && contains(dl_dir_snapshot(i_dlds).name,this_artist)
                    
                    this_dl_fn = dl_dir_snapshot(i_dlds).name;
                    download_failed = false; 
                end
            end
            
            safety_count = safety_count + 1; 
            if safety_count >= delay_wdld
                break
            end
        end

        if ~download_failed
            
            full_dl_fn = [ path.downloads , this_dl_fn ] ;
            movefile( full_dl_fn  , [ destination_path , this_dl_fn ] );
        end   

        if download_failed
            
            disp([ ' Download failed for ''', ...
                   playlist_info{i_track,2},' - ',playlist_info{i_track,1}, ...
                   '''.' ])
            plists(i_al).failed = plists(i_al).failed + 1;
            
            bot.mouseMove(param.pos.rfr(1),param.pos.rfr(2))
            bot.mousePress(InputEvent.BUTTON1_MASK); % click refresh (on browser)
            bot.mouseRelease(InputEvent.BUTTON1_MASK);
        end
        
        n_try_dl = n_try_dl + 1;
        if ~isempty(opts.n_limit) && (n_try_dl == opts.n_limit)
            disp(' ')
            disp('Download tries limit reached.')
            seconds_per_dl = toc(start_time_dl)/n_try_dl;
            HH = floor(seconds_per_dl / 3600);
            seconds_per_dl = seconds_per_dl - HH * 3600;
            MM = floor(seconds_per_dl / 60);
            SS = seconds_per_dl - MM * 60;
            fprintf('Mean dowload time: %02d:%02.0f (minutes:seconds)\n',MM,SS)
            return
        end
        
        bot.delay(param.delay.pgld) % wait for page to load
        
        bot.mouseMove(param.pos.url(1),param.pos.url(2)) % go to URL field in browser
        
        bot.mousePress(InputEvent.BUTTON1_MASK); % activate URL field in browser
        bot.mouseRelease(InputEvent.BUTTON1_MASK);
        
        clipboard('copy',plists(i_al).url)
        
        bot.keyPress(KeyEvent.VK_META) % select all
        bot.keyPress(KeyEvent.VK_A)
        bot.keyRelease(KeyEvent.VK_META)
        bot.keyRelease(KeyEvent.VK_A)
        
        bot.keyPress(KeyEvent.VK_META) % paste url to URL field
        bot.keyPress(KeyEvent.VK_V)
        bot.keyRelease(KeyEvent.VK_META)
        bot.keyRelease(KeyEvent.VK_V)
        bot.keyPress(KeyEvent.VK_ENTER)
        bot.keyRelease(KeyEvent.VK_ENTER)
        
        bot.delay(param.delay.pgld) % wait for page to load
        
        bot.setAutoDelay(param.delay.gnrl)
        bot.mouseMove(param.pos.blk(1),param.pos.blk(2)) % go to empty space
    end
end

if plists(i_al).failed == 0
    disp(' No failed downloads :)')
else
    n_all_failed = n_all_failed + plists(i_al).failed;
end

disp(' ')
if n_all_failed
    fprintf('Total failed downloads = %i \n',n_all_failed)
end

% ------------------------------------------------------------------------------
% Report computation time:

seconds_per_dl = toc(start_time_dl)/n_try_dl;
HH = floor(seconds_per_dl / 3600);
seconds_per_dl = seconds_per_dl - HH * 3600;
MM = floor(seconds_per_dl / 60);
SS = seconds_per_dl - MM * 60;
fprintf('Mean dowload time: %02d:%02.0f (minutes:seconds)\n',MM,SS)

seconds_elapsed = toc(start_time_program);
HH = floor(seconds_elapsed / 3600);
seconds_elapsed = seconds_elapsed - HH * 3600;
MM = floor(seconds_elapsed / 60);
SS = seconds_elapsed - MM * 60;
fprintf('Completed in %02d:%02d:%02.0f (hours:minutes:seconds)\n',HH,MM,SS)