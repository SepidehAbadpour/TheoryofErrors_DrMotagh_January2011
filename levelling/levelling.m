function varargout = levelling(varargin)
% LEVELLING M-file for levelling.fig
%      LEVELLING, by itself, creates a new LEVELLING or raises the existing
%      singleton*.
%
%      H = LEVELLING returns the handle to a new LEVELLING or the handle to
%      the existing singleton*.
%
%      LEVELLING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEVELLING.M with the given input arguments.
%
%      LEVELLING('Property','Value',...) creates a new LEVELLING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before levelling_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to levelling_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help levelling

% Last Modified by GUIDE v2.5 01-Jan-2011 21:39:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @levelling_OpeningFcn, ...
                   'gui_OutputFcn',  @levelling_OutputFcn, ...
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


% --- Executes just before levelling is made visible.
function levelling_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to levelling (see VARARGIN)

% Choose default command line output for levelling
handles.output = hObject;
handles.plotting=0

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes levelling wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = levelling_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.txt','choose the file')
file=fullfile(pathname,filename)
handles.elevation=load(file)
guidata(hObject,handles)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.txt','choose the file')
file=fullfile(pathname,filename)
handles.length=load(file)
guidata(hObject,handles)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

height=get(handles.edit1,'string')
height=str2num(height)
for i=1:length(handles.elevation)
    if handles.elevation(1,i)~=0
        handles.elevation(1,i)=handles.elevation(1,i)+height
    end
end
for i=1:length(handles.elevation)
    if handles.elevation(i,1)~=0
        handles.elevation(i,1)=handles.elevation(i,1)-height
    end
end
counter=0
for i=1:length(handles.elevation)
    for j=1:length(handles.elevation)
        if handles.elevation(i,j)~=0
            counter=counter+1
            if i==1
                A(counter,j-1)=1
                L(counter,1)=handles.elevation(i,j)
            elseif j==1
                A(counter,i-1)=-1
                L(counter,1)=handles.elevation(i,j)
            else
                A(counter,i-1)=-1
                A(counter,j-1)=1
                L(counter,1)=handles.elevation(i,j)
            end
                
        end
    end
end
counter=1
for i=1:length(handles.length)
    for j=1:length(handles.length)
        if handles.length(i,j)~=0
            p=1/handles.length(i,j)
            W(counter,counter)=p
            counter=counter+1
            
        end
    end
end
X=((A'*W*A)^(-1))*A'*W*L
set(handles.uitable1,'data',X)

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[x,y]=ginput(1)
plot(x,y,'*')
hold on

m=handles.plotting
m=m+1
handles.plotting=num2str(handles.plotting)
text(x,y,handles.plotting)
handles.plotting=str2num(handles.plotting)
