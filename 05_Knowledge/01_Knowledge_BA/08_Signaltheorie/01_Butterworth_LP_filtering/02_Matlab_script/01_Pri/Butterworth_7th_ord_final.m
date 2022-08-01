
clear all

%% Calculation/plotting tool in order to get the z-function of a defined (butterworth) s-function:
% Theoretical base: Signaltheorie/Anleitung_Versuch_9_Filter.pdf [TU Munich], https://de.wikipedia.org/wiki/Butterworth-Filter and ISO 15037
% Version: working document

%--------------------------------------------------------------------------------------------------------------------------------------------
% FILTER SETUP:

% Passband frequency fD [Hz]:
fD = 3;
wD = fD * 2 * pi();

%--------------------------------------------------------------------------------------------------------------------------------------------
% OUTPUT FILE SETUP:

TsArr_ms = 5 : 5 : 100;                     % (Choseable) array message cycle times
fileNamePrefix = 'BW_Filter_Param_Set';
fileType = '.xml';
outputFolderName = 'BW_Filter_Param_Files';

%--------------------------------------------------------------------------------------------------------------------------------------
% FILTER PARAM FILES PLOT:

% Vary Ts (whole procedure):
for j = 1 : length(TsArr_ms)

% Declarations:

    % Variable s:
    syms s; 

% Calculations:

    % Transfer-function BW 7th order (-3db @ passband-frequency/Durchlassfrequenz):
    H = (1 + s/wD) * (1 + 0.445*s/wD + (s/wD)^2) * (1 + 1.247*s/wD + (s/wD)^2) * (1 + 1.8019*s/wD + (s/wD)^2);

    % Expansion of transfer function :
    h = expand(H);

    % Set polynominalcoefficients in den-vector (Nenner):
    denS = sym2poly(h);

    % Num-vector (Zähler):
    numS = 1;

    % s-function:
    sFcn = tf(numS, denS);

    % z-function á la Tustin-method (incl. discrete timestep):
    zFcn = c2d(sFcn, TsArr_ms(j) / 1000, 'tustin');
    
% Coefficient deployment:     

    % Coefficients pick-out (z-function):
    [numCellZ , denCellZ , Ts] = tfdata(zFcn);
    numZ = [numCellZ{:}];
    denZ = [denCellZ{:}];
    
% Create file name:
fileName = cat(2, outputFolderName, '\',  fileNamePrefix, '_', num2str(TsArr_ms(j)), '_msec', fileType);

% Create class start line:
preClassStartName = '<SignalProcessing_Butterworth_FilterValues_';
postClassStartName = '_msec xmlns:xsi="http://www.w.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">';
classStartLine = cat(2, preClassStartName, num2str(TsArr_ms(j)), postClassStartName);

% Create class end line:
preClassEndName = '</SignalProcessing_Butterworth_FilterValues_';
postClassEndName = '_msec>';
classEndLine = cat(2, preClassEndName, num2str(TsArr_ms(j)), postClassEndName);

% Create cycle time line:
preCycleTimeLine = '<CycleTime_msec>';
postCycleTimeLine = '</CycleTime_msec>';
cycleTimeLine = cat(2, preCycleTimeLine, num2str(TsArr_ms(j)), postCycleTimeLine);

% Deploy to XML-file:

    % Headline (FIX):
    dlmwrite(fileName, '<?xml version="1.0" encoding="UTF-8"?>', 'delimiter', '');
    
    % Class start line:
    dlmwrite(fileName, classStartLine, 'delimiter', '', '-append');
    
    % Cycle time line:
    dlmwrite(fileName, cycleTimeLine, 'delimiter', '', '-append');
    
    % Numerator:
    
        % Numerator start line:
        dlmwrite(fileName, '<Numerators>', 'delimiter', '', '-append');
    
        % Numerator lines (each per loop cycle):
        for k = 1 : length(numZ)
            preNumLine = '<double>';
            postNumLine = '</double>';
            numeratorLine = cat(2, preNumLine, num2str(numZ(k), '%.22f'), postNumLine);
            dlmwrite(fileName, numeratorLine, 'delimiter', '', '-append');
        end
    
        % Numerator end line:
        dlmwrite(fileName, '</Numerators>', 'delimiter', '', '-append');
 
    % Denumerator:
    
        % Denumerator start line:
        dlmwrite(fileName, '<DeNumerators>', 'delimiter', '', '-append');
    
        % Denumerator lines (each per loop cycle):
        for i = 1 : length(denZ)
            preDeNumLine = '<double>';
            postDeNumLine = '</double>';
            denumeratorLine = cat(2, preDeNumLine, num2str(denZ(i), '%.22f'), postDeNumLine);
            dlmwrite(fileName, denumeratorLine, 'delimiter', '', '-append');
        end
    
        % Denumerator end line:
        dlmwrite(fileName, '</DeNumerators>', 'delimiter', '', '-append');
    
    % Class end line:
    dlmwrite(fileName, classEndLine, 'delimiter', '', '-append');
        
end

%--------------------------------------------------------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------------------------------------------------------
% % SINGLE FILTER PROCESSING:
% 
% % Declarations:
% 
%     % Variables:
%     syms s; 
%     Ts_ms = 0.05;
%     
%     % Passband frequency fD [Hz]:
%     fD = 3;
%     wD = fD * 2 * pi();
% 
% % Calculations:
% 
%     % Transfer-function BW 7th order (-3db @ passband-frequency/Durchlassfrequenz):
%     H = (1 + s/wD) * (1 + 0.445*s/wD + (s/wD)^2) * (1 + 1.247*s/wD + (s/wD)^2) * (1 + 1.8019*s/wD + (s/wD)^2);
% 
%     % Expansion of transfer function :
%     h = expand(H);
% 
%     % Set polynominalcoefficients in den-vector (Nenner):
%     denS = sym2poly(h);
% 
%     % Num-vector (Zähler):
%     numS = 1;
% 
%     % s-function:
%     sFcn = tf(numS, denS);
% 
%     % z-function á la Tustin-method (incl. discrete timestep):
%     zFcn = c2d(sFcn, Ts_ms, 'tustin');
%     
% % Coefficient deployment:     
% 
%     % Coefficients pick-out (z-function):
%     [numCellZ, denCellZ, Ts_ms] = tfdata(zFcn);
%     numZ = [numCellZ{:}];
%     denZ = [denCellZ{:}];
%     
% % FILTER DIAGRAM PLOTS:
% 
% % Plot frequency response (Bode-diagram):
% 
%     % Figure setup:
%     opts = bodeoptions('cstprefs');
%     opts.FreqScale = 'linear';
%     opts.MagScale = 'linear';
%     opts.MagUnits = 'abs';
%     opts.FreqUnits = 'Hz';
% 
%     % Plot frequency response (bot functions):
%     figure(1)
%     bode(sFcn, zFcn, opts)
%     grid on
% 
% % Plot step response (s-Function):
% figure(2)
% stepplot(sFcn)