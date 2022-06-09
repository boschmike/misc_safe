function varargout = GUI_Projekt(varargin)
% GUI_PROJEKT MATLAB code for GUI_Projekt.fig
%      GUI_PROJEKT, by itself, creates a new GUI_PROJEKT or raises the existing
%      singleton*.
%
%      H = GUI_PROJEKT returns the handle to a new GUI_PROJEKT or the handle to
%      the existing singleton*.
%
%      GUI_PROJEKT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_PROJEKT.M with the given input arguments.
%
%      GUI_PROJEKT('Property','Value',...) creates a new GUI_PROJEKT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_Projekt_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_Projekt_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_Projekt

% Last Modified by GUIDE v2.5 26-Jun-2018 14:38:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_Projekt_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_Projekt_OutputFcn, ...
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


% --- Executes just before GUI_Projekt is made visible.
function GUI_Projekt_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_Projekt (see VARARGIN)
set(handles.text2,'BackgroundColor',[0,1,0])
set(handles.text3,'BackgroundColor',[0,1,0])
set(handles.text4,'BackgroundColor',[0,1,0])
set(handles.text5,'BackgroundColor',[0,1,0])
set(handles.togglebutton1,'BackgroundColor',[1,1,1])
set(handles.togglebutton2,'BackgroundColor',[1,1,1])
set(handles.togglebutton3,'BackgroundColor',[1,1,1])
set(handles.togglebutton4,'BackgroundColor',[1,1,1])
set(handles.text2, 'String', 'Stabi getrennt')
set(handles.text3, 'String', 'Pneumatikzylinder inaktiv')
set(handles.text4, 'String', 'Gerade')
set(handles.text5, 'String', 'Schlagloch nicht vorhanden')
set(handles.text6, 'String', '0')
set(handles.text6,'BackgroundColor',[0.5,0.5,0.5])
% Choose default command line output for GUI_Projekt
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_Projekt wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_Projekt_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
neuerSliderWert = get (hObject, 'value')
%set (handles.v1, 'String', neuerSliderWert)
set_param('MODELL_aktiver_Stabi_OPENME/GESCHWINDIGKEIT', 'Value', num2str(neuerSliderWert))
set(handles.text6, 'String', neuerSliderWert)
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
     set(handles.text2,'BackgroundColor',[1,0,0])
     set_param('MODELL_aktiver_Stabi_OPENME/STABIMODE 1', 'Value', '1')
     set(handles.text2, 'String', 'Stabi verbunden')
elseif button_state == get(hObject,'Min')
	set(handles.text2,'BackgroundColor',[0,1,0])
    set_param('MODELL_aktiver_Stabi_OPENME/STABIMODE 1', 'Value', '0')
    set(handles.text2, 'String', 'Stabi getrennt')
    set_param('MODELL_aktiver_Stabi_OPENME/STABIMODE 2', 'Value', '0')
    set(handles.text3, 'String', 'Pneumatikzylinder inaktiv')
    set(handles.text3,'BackgroundColor',[0,1,0])
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
     set(handles.text3,'BackgroundColor',[1,0,0])
     set_param('MODELL_aktiver_Stabi_OPENME/STABIMODE 2', 'Value', '1')
     set_param('MODELL_aktiver_Stabi_OPENME/STABIMODE 1', 'Value', '1')
     set(handles.text2, 'String', 'Stabi verbunden')
     set(handles.text2,'BackgroundColor',[1,0,0])
     set(handles.text3, 'String', 'Pneumatikzylinder aktiv')
elseif button_state == get(hObject,'Min')
	set(handles.text3,'BackgroundColor',[0,1,0])
    set_param('MODELL_aktiver_Stabi_OPENME/STABIMODE 2', 'Value', '0')
    set(handles.text3, 'String', 'Pneumatikzylinder inaktiv')
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton2


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
     set(handles.text4,'BackgroundColor',[1,0,0])
     set_param('MODELL_aktiver_Stabi_OPENME/STRECKE', 'Value', '1')
     set(handles.text4, 'String', 'Kurve')
elseif button_state == get(hObject,'Min')
	set(handles.text4,'BackgroundColor',[0,1,0])
    set_param('MODELL_aktiver_Stabi_OPENME/STRECKE', 'Value', '0')
    set(handles.text4, 'String', 'Gerade')
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
     set(handles.text5,'BackgroundColor',[1,0,0])
     set_param('MODELL_aktiver_Stabi_OPENME/STRECKE1', 'Value', '1')
     set(handles.text5, 'String', 'Schlagloch vorhanden')
elseif button_state == get(hObject,'Min')
	set(handles.text5,'BackgroundColor',[0,1,0])
    set_param('MODELL_aktiver_Stabi_OPENME/STRECKE1', 'Value', '0')
    set(handles.text5, 'String', 'Schlagloch nicht vorhanden')
end
% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
sim('MODELL_aktiver_Stabi_OPENME')
set_param('MODELL_aktiver_Stabi_OPENME/Zeitverlauf','open','on') 
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
