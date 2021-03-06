function varargout = resection(varargin)
% RESECTION M-file for resection.fig
%      RESECTION, by itself, creates a new RESECTION or raises the existing
%      singleton*.
%
%      H = RESECTION returns the handle to a new RESECTION or the handle to
%      the existing singleton*.
%
%      RESECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESECTION.M with the given input arguments.
%
%      RESECTION('Property','Value',...) creates a new RESECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before resection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to resection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help resection

% Last Modified by GUIDE v2.5 04-Jan-2011 01:39:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @resection_OpeningFcn, ...
                   'gui_OutputFcn',  @resection_OutputFcn, ...
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


% --- Executes just before resection is made visible.
function resection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to resection (see VARARGIN)

% Choose default command line output for resection
handles.output = hObject;
set(hObject,'toolbar','figure')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes resection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = resection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.choosing=0
handles.counter=0
guidata(hObject,handles)
set(handles.text6,'string','first enter the file of points')
hold off

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.choosing=1
handles.counter=0
guidata(hObject,handles)
set(handles.text6,'string','first enter the file of points')
hold off

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if handles.counter==0
[filename,pathname]=uigetfile('*.txt','choose the file to load')
filename=fullfile(pathname,filename)
handles.coor=load(filename)
guidata(hObject,handles)
set(handles.text6,'string','now choose the file of your observations')
end
if handles.counter==1
[filename,pathname]=uigetfile('*.txt','choose the file to load')
filename=fullfile(pathname,filename)
handles.obser=load(filename)
guidata(hObject,handles)
set(handles.pushbutton4,'enable','on')
end
handles.counter=1
guidata(hObject,handles)

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
for i=1:length(handles.coor)
   for j=1:length(handles.coor) 
    if i~=j
        handles.obser(i,j)=pi*handles.obser(i,j)/180
        guidata(hObject,handles)
    end
   end
end
if handles.choosing==0
    shomarandeh=0
for i=1:(length(handles.coor)-1)
    if handles.obser(i,i)~=0&&handles.obser(i+1,i+1)~=0
        distance=sqrt((handles.coor(i+1,1)-handles.coor(i,1))^2+(handles.coor(i+1,2)-handles.coor(i,2))^2)
        cosine=(handles.obser(i,i)^2+handles.obser(i+1,i+1)^2-distance^2)/(2*handles.obser(i,i)*handles.obser(i+1,i+1))
        teta=acos(cosine)
        sinus=handles.obser(i+1,i+1)*sin(teta)/distance
        sigma=asin(sinus)
        if handles.obser(i+1,i+1)^2>handles.obser(i,i)^2+distance^2
            if sigma>0
                sigma=pi-sigma
            end
            if sigma<0
                sigma=-pi-sigma
            end
        end
        if sigma<0
            sigma=2*pi+sigma
        end
        g=gizman(handles.coor(i+1,1)-handles.coor(i,1),handles.coor(i+1,2)-handles.coor(i,2))
        gizz=g-sigma
        x0(i,1)=handles.coor(i,1)+handles.obser(i,i)*sin(gizz)
        y0(i,1)=handles.coor(i,2)+handles.obser(i,i)*cos(gizz)
    end
end
shomarandeh=shomarandeh+1
x_avvalieh(shomarandeh,1)=sum(x0)/length(x0)
y_avvalieh(shomarandeh,1)=sum(y0)/length(y0)
    if handles.obser(i,i+1)~=0&&handles.obser(i+1,i)~=0
        if handles.obser(i,i+1)>pi
            handles.obser(i,i+1)=2*pi-handles.obser(i,i+1)
            parcham=0
        end
        if handles.obser(i+1,i)>pi
            handles.obser(i+1,i)=2*pi-handles.obser(i+1,i)
            parcham=1
        end
        handles.obser
        teta=pi-(handles.obser(i,i+1)+handles.obser(i+1,i))
        distance=sqrt((handles.coor(i+1,1)-handles.coor(i,1))^2+(handles.coor(i+1,2)-handles.coor(i,2))^2)
        l=distance*sin(handles.obser(i+1,i))/sin(teta)
        if parcham==0
            handles.obser(i,i+1)==2*pi-handles.obser(i,i+1)
        end
        if parcham==1
            handles.obser(i+1,i)=2*pi-handles.obser(i+1,i)
        end
        g=gizman(handles.coor(i+1,1)-handles.coor(i,1),handles.coor(i+1,2)-handles.coor(i,2))
        gizz=g-handles.obser(i,i+1)
        x0(i,1)=handles.coor(i,1)+l*sin(gizz)
        y0(i,1)=handles.coor(i,2)+l*cos(gizz)
    end
    shomarandeh=shomarandeh+1
    x_avvalieh(shomarandeh,1)=sum(x0)/length(x0)
    y_avvalieh(shomarandeh,1)=sum(y0)/length(y0)
    x0=sum(x_avvalieh)/length(x_avvalieh)
    y0=sum(y_avvalieh)/length(y_avvalieh)

    k=1
for i=1:length(handles.coor)
    for j=1:length(handles.coor)
    if i==j&&handles.obser(i,j)~=0
        l(k,1)=sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
        dl(k,1)=handles.obser(i,j)-l(k,1)
        moshtag(k,1)=(x0-handles.coor(i,1))/sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
        moshtag(k,2)=(y0-handles.coor(i,2))/sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
        k=k+1
    end
    if i~=j&&handles.obser(i,j)~=0
        l(k,1)=gizman(handles.coor(j,1)-handles.coor(i,1),handles.coor(j,2)-handles.coor(i,2))-gizman(x0-handles.coor(i,1),y0-handles.coor(i,2))
       if l(k,1)<0
           l(k,1)=2*pi+l(k,1)
       end
        dl(k,1)=handles.obser(i,j)-l(k,1)
        moshtag(k,1)=-(y0-handles.coor(i,2))/((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
        moshtag(k,2)=(x0-handles.coor(i,1))/((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
        k=k+1
    end
    end
end
DX=((moshtag'*moshtag)^(-1))*moshtag'*dl
x0=x0+DX(1,1)
y0=y0+DX(2,1)
e=get(handles.edit1,'string')
e=str2double(e)
E=[e;e]
sss=abs(DX)>=E
while(abs(DX)>=E)
    
k=1
for i=1:length(handles.coor)
    for j=1:length(handles.coor)
    if i==j&&handles.obser(i,j)~=0
        l(k,1)=sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
        dl(k,1)=handles.obser(i,j)-l(k,1)
        moshtag(k,1)=(x0-handles.coor(i,1))/l(k,1)
        moshtag(k,2)=(y0-handles.coor(i,2))/l(k,1)
        k=k+1
    end
    if i~=j&&handles.obser(i,j)~=0
        l(k,1)=gizman(handles.coor(j,1)-handles.coor(i,1),handles.coor(j,2)-handles.coor(i,2))-gizman(x0-handles.coor(i,1),y0-handles.coor(i,2))
        if l(k,1)<0
            l(k,1)=2*pi+l(k,1)
        end
        dl(k,1)=handles.obser(i,j)-l(k,1)
        moshtag(k,1)=-(y0-handles.coor(i,2))/(l(k,1)^2)
        moshtag(k,2)=(x0-handles.coor(i,1))/(l(k,1)^2)
        k=k+1
    end
    end  
end

DX=((moshtag'*moshtag)^(-1))*moshtag'*dl
x0=x0+DX(1,1)
y0=y0+DX(2,1)  
SSS=abs(DX)>=E
end

end
if handles.choosing==1
    shomarandeh=0
     for i=1:(length(handles.coor)-2)
         if handles.obser(i,i+1)~=0&&handles.obser(i+1,i+2)~=0
             zavieh=gizman(handles.coor(i+2,1)-handles.coor(i+1,1),handles.coor(i+2,2)-handles.coor(i+1,2))-gizman(handles.coor(i,1)-handles.coor(i+1,1),handles.coor(i,2)-handles.coor(i+1,2))
             if zavieh<0
                 zavieh=2*pi+zavieh
             end
             G=2*pi-(handles.obser(i,i+1)+handles.obser(i+1,i+2)+zavieh)
             distance1=sqrt((handles.coor(i+1,1)-handles.coor(i,1))^2+(handles.coor(i+1,2)-handles.coor(i,2))^2)
             distance2=sqrt((handles.coor(i+2,1)-handles.coor(i+1,1))^2+(handles.coor(i+2,2)-handles.coor(i+1,2))^2)
             h=(distance2*sin(handles.obser(i,i+1)))/(distance1*sin(handles.obser(i+1,i+2)))
             angle=atan(sin(G)/(h+cos(G)))
             otherangle=pi-(handles.obser(i+1,i+2)+angle)
             distance3=distance2*sin(otherangle)/sin(handles.obser(i+1,i+2))
             az=gizman(handles.coor(i+1,1)-handles.coor(i+2,1),handles.coor(i+1,2)-handles.coor(i+2,2))
             azimuth=az+angle
             x0(i,1)=handles.coor(i+2,1)+distance3*sin(azimuth)
             y0(i,1)=handles.coor(i+2,2)+distance3*cos(azimuth)
         end
     end
     shomarandeh=shomarandeh+1
     x_avvalieh(shomarandeh,1)=sum(x0)/length(x0)
     y_avvalieh(shomarandeh,1)=sum(y0)/length(y0)
     for i=1:(length(handles.coor)-1)
         if handles.obser(i,i)~=0&&handles.obser(i+1,i+1)~=0
         distance=sqrt((handles.coor(i+1,1)-handles.coor(i,1))^2+(handles.coor(i+1,2)-handles.coor(i,2))^2)
        cosine=(handles.obser(i,i)^2+handles.obser(i+1,i+1)^2-distance^2)/(2*handles.obser(i,i)*handles.obser(i+1,i+1))
        teta=acos(cosine)
        sinus=handles.obser(i+1,i+1)*sin(teta)/distance
        sigma=asin(sinus)
        if handles.obser(i+1,i+1)^2>handles.obser(i,i)^2+distance^2
            if sigma>0
                sigma=pi-sigma
            end
            if sigma<0
                sigma=-pi-sigma
            end
        end
        if sigma<0
            sigma=2*pi+sigma
        end
        g=gizman(handles.coor(i+1,1)-handles.coor(i,1),handles.coor(i+1,2)-handles.coor(i,2))
        gizz=g-sigma
        x0(i,1)=handles.coor(i,1)+handles.obser(i,i)*sin(gizz)
        y0(i,1)=handles.coor(i,2)+handles.obser(i,i)*cos(gizz)
        end
     end
     shomarandeh=shomarandeh+1
     x_avvalieh(shomarandeh,1)=sum(x0)/length(x0)
     y_avvalieh(shomarandeh,1)=sum(y0)/length(y0)
     x0=sum(x_avvalieh)/length(x_avvalieh)
     y0=sum(y_avvalieh)/length(y_avvalieh)
     k=1
     for i=1:length(handles.coor)
         for j=1:length(handles.coor)
            if i==j&&handles.obser(i,j)~=0
               l(k,1)=sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
               dl(k,1)=handles.obser(i,j)-l(k,1)
               moshtag(k,1)=(x0-handles.coor(i,1))/sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
               moshtag(k,2)=(y0-handles.coor(i,2))/sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
               k=k+1
            end
             if i~=j&&handles.obser(i,j)~=0
                 l(k,1)=gizman(handles.coor(i,1)-x0,handles.coor(i,2)-y0)-gizman(handles.coor(i+1,1)-x0,handles.coor(i+1,2)-y0)
                 if l(k,1)<0
                     l(k,1)=2*pi+l(k,1)
                 end
                 dl(k,1)=handles.obser(i,j)-l(k,1)
                 moshtag(k,1)=(-(handles.coor(i,2)-y0)/((handles.coor(i,1)-x0)^2+(handles.coor(i,2)-y0)^2))+((handles.coor(i+1,2)-y0)/((handles.coor(i+1,1)-x0)^2+(handles.coor(i+1,2)-y0)^2))
                 moshtag(k,2)=((handles.coor(i,1)-x0)/((handles.coor(i,1)-x0)^2+(handles.coor(i,2)-y0)^2))-((handles.coor(i+1,1)-x0)/((handles.coor(i+1,1)-x0)^2+(handles.coor(i+1,2)-y0)^2))
                 k=k+1
             end
        end
     end
DX=((moshtag'*moshtag)^(-1))*moshtag'*dl
x0=x0+DX(1,1)
y0=y0+DX(2,1)
e=get(handles.edit1,'string')
e=str2double(e)
E=[e;e]
SSS=abs(DX)>=E
 while(abs(DX)>=E)
       k=1
     for i=1:length(handles.coor)
         for j=1:length(handles.coor)
            if i==j&&handles.obser(i,j)~=0
               l(k,1)=sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
               dl(k,1)=handles.obser(i,j)-l(k,1)
               moshtag(k,1)=(x0-handles.coor(i,1))/sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
               moshtag(k,2)=(y0-handles.coor(i,2))/sqrt((x0-handles.coor(i,1))^2+(y0-handles.coor(i,2))^2)
               k=k+1
            end
             if i~=j&&handles.obser(i,j)~=0
                 l(k,1)=gizman(handles.coor(i,1)-x0,handles.coor(i,2)-y0)-gizman(handles.coor(i+1,1)-x0,handles.coor(i+1,2)-y0)
                 if l(k,1)<0
                     l(k,1)=2*pi+l(k,1)
                 end
                 dl(k,1)=handles.obser(i,j)-l(k,1)
                 moshtag(k,1)=(-(handles.coor(i,2)-y0)/((handles.coor(i,1)-x0)^2+(handles.coor(i,2)-y0)^2))+((handles.coor(i+1,2)-y0)/((handles.coor(i+1,1)-x0)^2+(handles.coor(i+1,2)-y0)^2))
                 moshtag(k,2)=((handles.coor(i,1)-x0)/((handles.coor(i,1)-x0)^2+(handles.coor(i,2)-y0)^2))-((handles.coor(i+1,1)-x0)/((handles.coor(i+1,1)-x0)^2+(handles.coor(i+1,2)-y0)^2))
                 k=k+1
             end
        end
     end
DX=((moshtag'*moshtag)^(-1))*moshtag'*dl
x0=x0+DX(1,1)
y0=y0+DX(2,1)
SSS=abs(DX)>=E
 end       
end         
set(handles.text3,'string',x0)
set(handles.text5,'string',y0)
X=handles.coor(:,1)
Y=handles.coor(:,2)
plot(X,Y,'b*')
hold on
plot(x0,y0,'g*')
