function varargout = GUI_Spectrogram(varargin)
% GUI_SPECTROGRAM MATLAB code for GUI_Spectrogram.fig
%      GUI_SPECTROGRAM, by itself, creates a new GUI_SPECTROGRAM or raises the existing
%      singleton*.
%
%      H = GUI_SPECTROGRAM returns the handle to a new GUI_SPECTROGRAM or the handle to
%      the existing singleton*.
%
%      GUI_SPECTROGRAM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_SPECTROGRAM.M with the given input arguments.
%
%      GUI_SPECTROGRAM('Property','Value',...) creates a new GUI_SPECTROGRAM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Spectrogram_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Spectrogram_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Spectrogram

% Last Modified by GUIDE v2.5 14-Oct-2018 10:48:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Spectrogram_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Spectrogram_OutputFcn, ...
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


% --- Executes just before GUI_Spectrogram is made visible.
function GUI_Spectrogram_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Spectrogram (see VARARGIN)

% Choose default command line output for GUI_Spectrogram
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Spectrogram wait for user response (see UIRESUME)
% uiwait(handles.figure1);
load('Metody_eksperymentalne\GUI_Signals\spectre_tmp.mat');

% --- Outputs from this function are returned to the command line.
function varargout = GUI_Spectrogram_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_window_Callback(hObject, eventdata, handles)
% hObject    handle to slider1_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
v = get(hObject,'Value');
set(handles.edit1_window,'string',num2str(v));

% --- Executes during object creation, after setting all properties.
function slider1_window_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1_window (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global slider_min slider_max;
slider_min = 16;
slider_max = 128;

set(hObject,'Min',slider_min);
set(hObject,'Max',slider_max);
set(hObject,'Value',slider_min);
set(hObject,'SliderStep',[ 1/7 0.5 ]);

% --- Executes on slider movement.
function slider2_noverlap_Callback(hObject, eventdata, handles)
% hObject    handle to slider2_noverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
v = get(hObject,'Value');
set(handles.edit2_noverlap,'string',num2str(v));

% --- Executes during object creation, after setting all properties.
function slider2_noverlap_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2_noverlap (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global slider_min slider_max;
slider_min = 16;
slider_max = 128;
set(hObject,'Min',slider_min);
set(hObject,'Max',slider_max);
set(hObject,'Value',slider_min);
set(hObject,'SliderStep',[ 1/7 0.5 ]);

% --- Executes on slider movement.
function slider3_nfft_Callback(hObject, eventdata, handles)
% hObject    handle to slider3_nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
v = get(hObject,'Value');
set(handles.edit3_nfft,'string',num2str(v));

% --- Executes during object creation, after setting all properties.
function slider3_nfft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3_nfft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

global slider_min slider_max;
slider_min = 16;
slider_max = 128;
set(hObject,'Min',slider_min);
set(hObject,'Max',slider_max);
set(hObject,'Value',slider_min);
set(hObject,'SliderStep',[ 1/7 0.5 ]);


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
delete('Metody_eksperymentalne\GUI_Signals\spectre_tmp.mat');
delete(handles.figure1);


% --- Executes during object creation, after setting all properties.
function axes1_spectre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1_spectre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1_spectre
global xs fs;
spectrogram(xs,[],[],[],fs);