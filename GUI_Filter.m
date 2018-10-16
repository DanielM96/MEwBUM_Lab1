function varargout = GUI_Filter(varargin)
% GUI_FILTER MATLAB code for GUI_Filter.fig
%      GUI_FILTER, by itself, creates a new GUI_FILTER or raises the existing
%      singleton*.
%
%      H = GUI_FILTER returns the handle to a new GUI_FILTER or the handle to
%      the existing singleton*.
%
%      GUI_FILTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_FILTER.M with the given input arguments.
%
%      GUI_FILTER('Property','Value',...) creates a new GUI_FILTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Filter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Filter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Filter

% Last Modified by GUIDE v2.5 15-Oct-2018 20:51:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Filter_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Filter_OutputFcn, ...
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


% --- Executes just before GUI_Filter is made visible.
function GUI_Filter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Filter (see VARARGIN)

% Choose default command line output for GUI_Filter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Filter wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global xg yw fw filter_type;
xg = evalin('base','xgt');
yw = evalin('base','ywt');
fw = evalin('base','fwt');
filter_type = 1;

axes(handles.axes1_before);
plot(fw,yw);
title('Sygna³ przed filtracj¹');
zoom on;
xlabel('Czêstotliwoœæ [Hz]');
ylabel('Amplituda');
set(gca,'fontsize',8);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Filter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_cutoff_Callback(hObject, eventdata, handles)
% hObject    handle to edit1_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1_cutoff as text
%        str2double(get(hObject,'String')) returns contents of edit1_cutoff as a double


% --- Executes during object creation, after setting all properties.
function edit1_cutoff_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1_cutoff (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1_filter.
function pushbutton1_filter_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1_filter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter_type xg ff yf;
cutoff = str2double(get(handles.edit1_cutoff,'String'));
isallowed = false;
if ~isnan(cutoff)
    isallowed = true;
else
    msgbox('Musisz podaæ liczbê.','B³¹d','warn');
end

fn = 1000;
if isallowed
    if filter_type == 1 % dolnoprzepustowy
        [ b, a ] = butter(15,cutoff/fn);
    else % górnoprzepustowy
        [ b, a ] = cheby2(15,45,cutoff/fn,'high');
    end
    ys = filter(b,a,xg);

    n = length(xg);
    y = fft(ys);
    y = y(1:n/2+1);
    y = abs(y);
    y = y/(n/2);
    df = 1/5;
    f = 0:df:fn;
    ff = f;
    yf = y;

    axes(handles.axes2_after);
    plot(f,y);
    title('Sygna³ po filtracji');
    zoom on;
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'fontsize',8);
end

% --- Executes on button press in pushbutton2_close.
function pushbutton2_close_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2_close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
delete(handles.figure1);


% --- Executes when selected object is changed in uibuttongroup1_type.
function uibuttongroup1_type_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uibuttongroup1_type 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filter_type;
switch eventdata.NewValue
    case handles.radiobutton1_lowpass % dolnoprzepustowy
        filter_type = 1;
    case handles.radiobutton2_hipass % górnoprzepustowy
        filter_type = 2;
end


% --- Executes on button press in checkbox1_log.
function checkbox1_log_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox1_log
global fw yw ff yf;
logscale = get(hObject,'Value');
if logscale == 0 % lin
    axes(handles.axes1_before);
    plot(fw,yw);
    title('Sygna³ przed filtracj¹');
    zoom on;
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'fontsize',8);
    
    axes(handles.axes2_after);
    plot(ff,yf);
    title('Sygna³ po filtracji');
    zoom on;
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'fontsize',8);
else % log
    axes(handles.axes1_before);
    semilogy(fw,yw);
    title('Sygna³ przed filtracj¹');
    zoom on;
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'fontsize',8);
    
    axes(handles.axes2_after);
    semilogy(ff,yf);
    title('Sygna³ po filtracji');
    zoom on;
    xlabel('Czêstotliwoœæ [Hz]');
    ylabel('Amplituda');
    set(gca,'fontsize',8);
end