function varargout = GUI_Period(varargin)
% GUI_PERIOD MATLAB code for GUI_Period.fig
%      GUI_PERIOD, by itself, creates a new GUI_PERIOD or raises the existing
%      singleton*.
%
%      H = GUI_PERIOD returns the handle to a new GUI_PERIOD or the handle to
%      the existing singleton*.
%
%      GUI_PERIOD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PERIOD.M with the given input arguments.
%
%      GUI_PERIOD('Property','Value',...) creates a new GUI_PERIOD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Period_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Period_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Period

% Last Modified by GUIDE v2.5 15-Oct-2018 19:33:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Period_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Period_OutputFcn, ...
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


% --- Executes just before GUI_Period is made visible.
function GUI_Period_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Period (see VARARGIN)

% Choose default command line output for GUI_Period
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Period wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load('Metody_eksperymentalne\GUI_Signals\period_tmp.mat');
axes(handles.axes1_period);
periodogram(xg,[],[]);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Period_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1_close.
function pushbutton1_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% msgbox('Zamykamy');
delete('Metody_eksperymentalne\GUI_Signals\period_tmp.mat');
delete(handles.figure1);


% --- Executes during object creation, after setting all properties.
function axes1_period_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1_period (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1_period
global xg;
axes(hObject);
periodogram(xg,[],[]);


% --- Executes on button press in checkbox1_hamming.
function checkbox1_hamming_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1_hamming (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1_hamming
global xg w nfft;
v = get(hObject,'Value');
if v == 1
    w = hamming(length(xg));
else
    w = [];
end
axes(handles.axes1_period);
periodogram(xg,w,nfft);

% --- Executes on button press in checkbox2_nfft.
function checkbox2_nfft_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2_nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox2_nfft
global xg w nfft;
v = get(hObject,'Value');
if v == 1
    nfft = length(xg);
else
    nfft = [];
end
axes(handles.axes1_period);
periodogram(xg,w,nfft);
