function varargout = GUI_Signals(varargin)
% GUI_SIGNALS MATLAB code for GUI_Signals.fig
%      GUI_SIGNALS, by itself, creates a new GUI_SIGNALS or raises the existing
%      singleton*.
%
%      H = GUI_SIGNALS returns the handle to a new GUI_SIGNALS or the handle to
%      the existing singleton*.
%
%      GUI_SIGNALS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SIGNALS.M with the given input arguments.
%
%      GUI_SIGNALS('Property','Value',...) creates a new GUI_SIGNALS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Signals_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Signals_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Signals

% Last Modified by GUIDE v2.5 15-Oct-2018 20:46:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Signals_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Signals_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before GUI_Signals is made visible.
function GUI_Signals_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Signals (see VARARGIN)

% Choose default command line output for GUI_Signals
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Signals wait for user response (see UIRESUME)
% uiwait(handles.figure1);
clear;
clc;

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Signals_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_generate.
function pushbutton1_generate_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_generate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% sygnał
global type tg xg fg fw yw x_scale;
switch type
    case 1 % MAT
        file = uigetfile({'*.mat','Pliki MAT (*.mat)'},'Wczytaj dane');
        load(file);
        tg = t;
        xg = x;
        cla(handles.axes1_tv);
        cla(handles.axes2_widmo);
        
    case 2 % CSV
        file = uigetfile({'*.csv','Pliki CSV (*.csv)'},'Wczytaj dane');
        [ tg, xg ] = importfile(file,';');
        cla(handles.axes1_tv);
        cla(handles.axes2_widmo);
        
    case 3 % TXT
        file = uigetfile({'*.txt','Pliki TXT (*.txt)'},'Wczytaj dane');
        [ tg, xg ] = importfile(file,'\t');
        cla(handles.axes1_tv);
        cla(handles.axes2_widmo);
end

if isequal(file,0)
    return;
else
    fs = 2000; % 2 kHz
    fg = fs;
    ts = tg;
    xs = xg;

    % przebieg czasowy
    axes(handles.axes1_tv);
    plot(ts,xs);
    zoom on;
    xlabel('Czas [s]');
    ylabel('Amplituda');
    set(gca,'fontsize',8);

    % widmo
    n = length(xg);
    y = fft(xg);
    y = y(1:n/2+1);
    y = abs(y);
    y = y/(n/2);
    df = 1/5;
    f = 0:df:fs/2;
    
    % kopia globalna
    fw = f;
    yw = y;
    axes(handles.axes2_widmo);
    % typ wykresu
    if x_scale == 1 % lin
        plot(f,y);
    else % log
        semilogy(f,y);
    end
    zoom on;
    xlabel('Częstotliwość [Hz]');
    ylabel('Amplituda');
    set(gca,'fontsize',8);
    linkaxes([ handles.axes1_tv, handles.axes2_widmo ],'y');

end
% --------------------------------------------------------------------
function menu_Plots_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Plots (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function plots_Spectrogram_Callback(hObject, eventdata, handles)
% hObject    handle to plots_Spectrogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xg fs;
save('Metody_eksperymentalne\GUI_Signals\spectre_tmp.mat','xg','fs');
% figure;
% spectrogram(xs,[],[],[],fs);
GUI_Spectrogram;

% --------------------------------------------------------------------
function plots_PSD_Callback(hObject, eventdata, handles)
% hObject    handle to plots_PSD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xg fs;
save('Metody_eksperymentalne\GUI_Signals\psd_tmp.mat','xg','fs');
% figure;
% pwelch(xs,[],[],[],fs);
GUI_PSD;


% --------------------------------------------------------------------
function menu_File_Callback(hObject, eventdata, handles)
% hObject    handle to menu_File (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_Help_Callback(hObject, eventdata, handles)
% hObject    handle to menu_Help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2_exit.
function pushbutton2_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --------------------------------------------------------------------
function Help_Matlab_Callback(hObject, eventdata, handles)
% hObject    handle to Help_Matlab (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
doc;


% --- Executes when selected object is changed in uibuttongroup1_filetype.
function uibuttongroup1_filetype_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1_filetype 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global type;
switch eventdata.NewValue
    case handles.radiobutton1_mat
        type = 1;
    case handles.radiobutton2_csv
        type = 2;
    case handles.radiobutton3_txt
        type = 3;
end

% --- Import z pliku CSV lub TXT
function [t,x] = importfile(filename, delimiter, startRow, endRow)
%IMPORTFILE Import numeric data from a text file as column vectors.
%   [T,X] = IMPORTFILE(FILENAME,DELIMITER) Reads data from text file FILENAME for the
%   default selection with specified delimiter.
%
%   [T,X] = IMPORTFILE(FILENAME, DELIMITER, STARTROW, ENDROW) Reads data from rows
%   STARTROW through ENDROW of text file FILENAME with specified delimiter.
%
% Example:
%   [t,x] = importfile('signal_csv.csv',';', 2, 201);
%
%    See also TEXTSCAN.

% Auto-generated by MATLAB on 2018/10/13 11:59:53

%% Initialize variables.
if nargin<=3
    startRow = 2;
    endRow = inf;
end

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
    frewind(fileID);
    dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
    for col=1:length(dataArray)
        dataArray{col} = [dataArray{col};dataArrayBlock{col}];
    end
end

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\.]*)+[\,]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\.]*)*[\,]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers=='.');
                thousandsRegExp = '^\d+?(\.\d{3})*\,{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, '.', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = strrep(numbers, '.', '');
                numbers = strrep(numbers, ',', '.');
                numbers = textscan(numbers, '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Allocate imported array to column variable names
t = cell2mat(raw(:, 1));
x = cell2mat(raw(:, 2));


% --- Executes during object creation, after setting all properties.
function uibuttongroup1_filetype_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup1_filetype (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global type;
type = 1;


% --- Executes during object creation, after setting all properties.
function uibuttongroup2_widmo_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uibuttongroup2_widmo_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global x_scale;
x_scale = 1;


% --- Executes when selected object is changed in uibuttongroup2_widmo_scale.
function uibuttongroup2_widmo_scale_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup2_widmo_scale 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global x_scale;
switch eventdata.NewValue
    case handles.radiobutton4_x_lin % liniowa
        x_scale = 1;
    case handles.radiobutton5_x_log % logarytmiczna
        x_scale = 2;
end


% --- Executes on button press in radiobutton5_x_log.
function radiobutton5_x_log_Callback(hObject, eventdata, handles)
global fw yw;
cla(handles.axes2_widmo);
axes(handles.axes2_widmo);
semilogy(fw,yw);

% --- Executes on button press in radiobutton4_x_lin.
function radiobutton4_x_lin_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton4_x_lin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton4_x_lin
global fw yw;
cla(handles.axes2_widmo);
axes(handles.axes2_widmo);
plot(fw,yw);


% --------------------------------------------------------------------
function plots_period_Callback(hObject, eventdata, handles)
% hObject    handle to plots_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xg;
save('Metody_eksperymentalne\GUI_Signals\period_tmp.mat','xg');
GUI_Period;
% figure;
% periodogram(xs);


% --- Executes on button press in pushbutton5_filter.
function pushbutton5_filter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xg fw yw;
assignin('base','xgt',xg);
assignin('base','fwt',fw);
assignin('base','ywt',yw);
GUI_Filter;
