function varargout = comformal1(varargin)
% COMFORMAL1 M-file for comformal1.fig
%      COMFORMAL1, by itself, creates a new COMFORMAL1 or raises the existing
%      singleton*.
%
%      H = COMFORMAL1 returns the handle to a new COMFORMAL1 or the handle to
%      the existing singleton*.
%
%      COMFORMAL1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMFORMAL1.M with the given input arguments.
%
%      COMFORMAL1('Property','Value',...) creates a new COMFORMAL1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before comformal1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to comformal1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help comformal1

% Last Modified by GUIDE v2.5 02-Jan-2011 12:37:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @comformal1_OpeningFcn, ...
                   'gui_OutputFcn',  @comformal1_OutputFcn, ...
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


% --- Executes just before comformal1 is made visible.
function comformal1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to comformal1 (see VARARGIN)

% Choose default command line output for comformal1
handles.output = hObject;
set(hObject,'toolbar','figure')
global matrix counter txt u v
counter=1
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes comformal1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = comformal1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


function pushbutton1_Callback(hObject, eventdata, handles)

global matrix counter txt u v
[n,p]=uigetfile('*.tif');
a=[p,n];
imread(a);
imshow(a);



function pushbutton2_Callback(hObject, eventdata, handles)

global matrix counter txt u v
[v,u]=ginput(1);
matrix(counter,1)=u;
matrix(counter,2)=v;
counter=counter+1;


function pushbutton3_Callback(hObject, eventdata, handles)

global matrix counter txt u v
set(handles.uitable1,'data',matrix);

function pushbutton4_Callback(hObject, eventdata, handles)
global matrix counter txt u v
format long;
for i=1:length(matrix)
    a(2*i-1,1:4)=[matrix(i,1)/1000,-matrix(i,2)/1000,1,0];
    a(2*i,1:4)=[matrix(i,2)/1000,matrix(i,1)/1000,0,1];
end
x=txt(:,1);
y=txt(:,2);
for i=1:length(x)
    l(2*i-1,1)=x(i);
    l(2*i,1)=y(i);
end

q=inv(a'*a)*a'*l
for i=1:length(x)
   xcom(i)=[matrix(i,1)/1000,-matrix(i,2)/1000,1,0]*q;
   ycom(i)=[matrix(i,2)/1000,matrix(i,1)/1000,0,1]*q;
end
m=[xcom',ycom']
set(handles.uitable2,'data',m)








function pushbutton5_Callback(hObject, eventdata, handles)

global matrix counter txt u v
format long;
for i=1:length(matrix)
    a(2*i-1,1:6)=[matrix(i,1)/1000,-matrix(i,2)/1000,1,0,0,0];
    a(2*i,1:6)=[0,0,0,matrix(i,2)/1000,matrix(i,1)/1000,1];
end
x=txt(:,1);
y=txt(:,2);
for i=1:length(x)
    l(2*i-1,1)=x(i);
    l(2*i,1)=y(i);
end

q=inv(a'*a)*a'*l
for i=1:length(x)
   xcom(i)=[matrix(i,1)/1000,-matrix(i,2)/1000,1,0,0,0]*q;
   ycom(i)=[0,0,0,matrix(i,2)/1000,matrix(i,1)/1000,1]*q;
end
m=[xcom',ycom']
set(handles.uitable3,'data',m)



function pushbutton6_Callback(hObject, eventdata, handles)

global matrix counter txt u v
x=txt(:,1);
y=txt(:,2);
for i=1:length(x)
    l(2*i-1,1)=x(i);
    l(2*i,1)=y(i);
end
for i=1:length(matrix)
    a(2*i-1,1:8)=[matrix(i,1)/1000,matrix(i,2)/1000,1,0,0,0,-x(i)*matrix(i,1)/1000,-x(i)*matrix(i,2)/1000];
    a(2*i,1:8)=[0,0,0,matrix(i,2)/1000,matrix(i,1)/1000,1,-y(i)*matrix(i,1)/1000,-y(i)*matrix(i,2)/1000];
end


q=inv(a'*a)*a'*l
for i=1:length(x)
   xcom(i)=[matrix(i,1)/1000,matrix(i,2)/1000,1,0,0,0,-x(i)*matrix(i,1)/1000,-x(i)*matrix(i,2)/1000]*q;
   ycom(i)=[0,0,0,matrix(i,2)/1000,matrix(i,1)/1000,1,-y(i)*matrix(i,1)/1000,-y(i)*matrix(i,2)/1000]*q;
end
u=[xcom',ycom']
set(handles.uitable4,'data',u)


function edit1_Callback(hObject, eventdata, handles)
global matrix counter txt u v

function edit1_CreateFcn(hObject, eventdata, handles)
global matrix counter txt u v
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function pushbutton9_Callback(hObject, eventdata, handles)
global matrix counter txt u v
[o,q]=uigetfile('*.txt')
d=[q,o]
txt=load(d)
