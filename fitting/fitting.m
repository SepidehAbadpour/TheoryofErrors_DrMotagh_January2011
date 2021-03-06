function varargout = fitting(varargin)
% FITTING M-file for fitting.fig
%      FITTING, by itself, creates a new FITTING or raises the existing
%      singleton*.
%
%      H = FITTING returns the handle to a new FITTING or the handle to
%      the existing singleton*.
%
%      FITTING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FITTING.M with the given input arguments.
%
%      FITTING('Property','Value',...) creates a new FITTING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fitting_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fitting_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fitting

% Last Modified by GUIDE v2.5 31-Jan-2011 10:37:37
global counter n matrix

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fitting_OpeningFcn, ...
                   'gui_OutputFcn',  @fitting_OutputFcn, ...
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


% --- Executes just before fitting is made visible.
function fitting_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fitting (see VARARGIN)
global counter n matrix
% Choose default command line output for fitting
set(hObject,'toolbar','figure');
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fitting wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fitting_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global counter n matrix
clear global
% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global counter n matrix
% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double
counter=0
input=str2num(get(handles.edit1,'string'));
n=input
 if n==0
     msgboxtext='you have not entered the degree of the polyfit';
     msgbox(msgboxtext,'Error','error');
    set(handles.pushbutton3,'enable','off')
    set(handles.pushbutton5,'enable','off')
end
if n~=0
    set(handles.pushbutton3,'enable','on')
    set(handles.pushbutton5,'enable','on')
end
guidata(hObject,handles);

% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
global counter n matrix
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global counter n matrix
m=length(matrix);
for i=1:m
    for j=0:n
        A(i,j+1)=matrix(i,1)^j;
    end
    L(i,1)=matrix(i,2);
end
X=((A'*A)^(-1))*A'*L;
x1=matrix(:,1);
y1=matrix(:,2);
syms x
for i=n:-1:0
    Y(i+1,1)=(X(i+1,1))*x^i;
end
y=sum(Y)
k=string(y)
set(handles.text2,'string',k)
set(handles.uitable1,'data',matrix)

x=min(x1):0.001:max(x1);
y=eval(y);
plot(x,y,'g')

% --- Executes on button press in pushbutton2.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global counter n matrix
set(handles.pushbutton3,'enable','off')
[x,y]=ginput(1)
counter=counter+1
plot (x,y,'b*')
hold on
matrix(counter,1)=x
matrix(counter,2)=y
if length(matrix)>=n+2
    set(handles.pushbutton1,'enable','on')
end
% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global counter n matrix
set(handles.pushbutton2,'enable','off')
[filename,pathname]=uigetfile('*.txt','choose the file to load')
loaddataname=fullfile(pathname,filename)
matrix=load(loaddataname)
set(handles.uitable1,'data',matrix)
if length(matrix)>=n+2
    set(handles.pushbutton1,'enable','on')
    x1=matrix(:,1)
    y1=matrix(:,2)
    plot(x1,y1,'*b')
    hold on
else
     msgboxtext='number of points in the text file should be more than (degree+2)';
     msgbox(msgboxtext,'Error','error');
end
