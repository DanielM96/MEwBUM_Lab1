function varargout = GUI_PSD(varargin)
% GUI_PSD MATLAB code for GUI_PSD.fig
%      GUI_PSD, by itself, creates a new GUI_PSD or raises the existing
%      singleton*.
%
%      H = GUI_PSD returns the handle to a new GUI_PSD or the handle to
%      the existing singleton*.
%
%      GUI_PSD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PSD.M with the given input arguments.
%
%      GUI_PSD('Property','Value',...) creates a new GUI_PSD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_PSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_PSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_PSD

% Last Modified by GUIDE v2.5 15-Oct-2018 18:59:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_PSD_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_PSD_OutputFcn, ...
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


% --- Executes just before GUI_PSD is made visible.
function GUI_PSD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_PSD (see VARARGIN)

% Choose default command line output for GUI_PSD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_PSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load('Metody_eksperymentalne\GUI_Signals\psd_tmp.mat');
axes(handles.axes1_psd);
pwelch(xg,[],[],[],fs);

% --- Outputs from this function are returned to the command line.
function varargout = GUI_PSD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes during object creation, after setting all properties.
function slider1_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global slider_min slider_max v_window;
slider_min = 32;
slider_max = 256;
v_window = slider_min;

set(hObject,'Min',slider_min);
set(hObject,'Max',slider_max);
set(hObject,'Value',slider_min);
set(hObject,'SliderStep',[ 1/14 0.5 ]);


% --- Executes on slider movement.
function slider1_window_Callback(hObject, eventdata, handles)
% hObject    handle to slider1_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global v_window v_overlap v_nfft xg fs;
v = get(hObject,'Value');
v_window = v;
set(handles.edit1_window,'string',num2str(v));
axes(handles.axes1_psd);
pwelch(xg,v,v_overlap,v_nfft,fs);


% --- Executes on slider movement.
function slider2_noverlap_Callback(hObject, eventdata, handles)
% hObject    handle to slider2_noverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global v_noverlap v_window v_nfft fs xg;
v = get(hObject,'Value');
v_noverlap = v;
set(handles.edit2_noverlap,'string',num2str(v));
axes(handles.axes1_psd);
pwelch(xg,v_window,v,v_nfft,fs);

% --- Executes during object creation, after setting all properties.
function slider2_noverlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2_noverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global slider_min slider_max v_noverlap;
slider_min = 16;
slider_max = 240;
v_noverlap = slider_min;

set(hObject,'Min',slider_min);
set(hObject,'Max',slider_max);
set(hObject,'Value',slider_min);
set(hObject,'SliderStep',[ 1/14 0.5 ]);

% --- Executes on slider movement.
function slider3_nfft_Callback(hObject, eventdata, handles)
% hObject    handle to slider3_nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global v_nfft v_window v_noverlap fs xg;
v = get(hObject,'Value');
v_nfft = v;
set(handles.edit3_nfft,'string',num2str(v));
axes(handles.axes1_psd);
pwelch(xg,v_window,v_noverlap,v,fs);

% --- Executes during object creation, after setting all properties.
function slider3_nfft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3_nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global slider_min slider_max v_nfft;
slider_min = 32;
slider_max = 256;
v_nfft = slider_min;

set(hObject,'Min',slider_min);
set(hObject,'Max',slider_max);
set(hObject,'Value',slider_min);
set(hObject,'SliderStep',[ 1/14 0.5 ]);


function edit1_window_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_window as text
%        str2double(get(hObject,'String')) returns contents of edit1_window as a double


% --- Executes during object creation, after setting all properties.
function edit1_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_noverlap_Callback(hObject, eventdata, handles)
% hObject    handle to edit2_noverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2_noverlap as text
%        str2double(get(hObject,'String')) returns contents of edit2_noverlap as a double


% --- Executes during object creation, after setting all properties.
function edit2_noverlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2_noverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_nfft_Callback(hObject, eventdata, handles)
% hObject    handle to edit3_nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3_nfft as text
%        str2double(get(hObject,'String')) returns contents of edit3_nfft as a double


% --- Executes during object creation, after setting all properties.
function edit3_nfft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3_nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1_close.
function pushbutton1_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% msgbox('Zamykamy');
delete('Metody_eksperymentalne\GUI_Signals\psd_tmp.mat');
delete(handles.figure1);


% --- Executes during object creation, after setting all properties.
function axes1_psd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1_psd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1_psd
global xg fs;
axes(hObject);
pwelch(xg,[],[],[],fs);


% --- Executes on button press in pushbutton2_redraw.
function pushbutton2_redraw_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_redraw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xg fs v_window v_noverlap v_nfft;
cla(handles.axes1_psd,'reset');
axes(handles.axes1_psd);
pwelch(xg,v_window,v_noverlap,v_nfft,fs);


% --- Executes on button press in pushbutton1_null.
function pushbutton1_null_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_null (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xg fs;
axes(handles.axes1_psd);
pwelch(xg,[],[],[],fs);
