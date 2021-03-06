function varargout = leastsquare(varargin)
% LEASTSQUARE M-file for leastsquare.fig
%      LEASTSQUARE, by itself, creates a new LEASTSQUARE or raises the existing
%      singleton*.
%
%      H = LEASTSQUARE returns the handle to a new LEASTSQUARE or the handle to
%      the existing singleton*.
%
%      LEASTSQUARE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LEASTSQUARE.M with the given input arguments.
%
%      LEASTSQUARE('Property','Value',...) creates a new LEASTSQUARE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before leastsquare_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to leastsquare_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help leastsquare

% Last Modified by GUIDE v2.5 03-Feb-2011 20:44:31

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @leastsquare_OpeningFcn, ...
                   'gui_OutputFcn',  @leastsquare_OutputFcn, ...
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


% --- Executes just before leastsquare is made visible.
function leastsquare_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to leastsquare (see VARARGIN)

% Choose default command line output for leastsquare
handles.output = hObject;
set(hObject,'toolbar','figure')
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes leastsquare wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = leastsquare_OutputFcn(hObject, eventdata, handles) 
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
[filename,pathname]=uigetfile('*.xlsx','choose the file to import');
if pathname==0
    return
end
file=fullfile(pathname,filename);
u=importdata(file);
handles.initial=u.Sheet1;
x0=get(handles.edit2,'string');
x0=str2double(x0);
y0=get(handles.edit3,'string');
y0=str2double(y0);
handles.cooravvali(1,1:3)=[1,x0,y0];
for i=2:length(handles.initial)+1
    handles.cooravvali(i,1:3)=handles.initial(i-1,1:3);
end
guidata(hObject,handles)
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.xlsx','choose the file to import');
if pathname==0
    return
end
file=fullfile(pathname,filename);
u=importdata(file);
handles.observation=u.Sheet1;
guidata(hObject,handles)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uigetfile('*.xlsx','choose the file to import');
if pathname==0
    return
end
file=fullfile(pathname,filename);
u=importdata(file);
handles.observationerror=u.Sheet1;
guidata(hObject,handles)


function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile('*.txt','save point coordinates');
if pathname==0
    return
end
file2=fullfile(pathname,filename);
fid=fopen(file2,'w');
myvar = handles.cooravvali;
fprintf(fid,'point number X Y\r\n\r\n\r\n');
fprintf(fid,'%0.0f-- %6.4f-- %6.4f\r\n\r\n',myvar');
fclose(fid);

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile('*.txt','save absolute error ellipse parameters');
if pathname==0
    return
end
file4=fullfile(pathname,filename);
fid=fopen(file4,'w');
myvar = handles.absoluteparameters';
fprintf(fid,'pointnumber--major diameter--minor diameter--angle of major diameter with x axis--angle of minor diameter with x axis--eccentricity--area\r\n\r\n\r\n');
fprintf(fid,'%0.0f-- %6.4f-- %6.4f-- %6.4f-- %6.4f-- %6.4f-- %6.4f\r\n\r\n',myvar);
fclose(fid);
% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
count1=1;
for count2=1:length(handles.observationerror)
    for count3=count2+1:length(handles.observationerror)
        if handles.observationerror(count2,count3)~=0
            khata(count1,1)=(handles.observationerror(count2,count3))^(-2);
            count1=count1+1;
        end
    end
end
for count4=1:length(khata)
    vazn(count4,count4)=khata(count4,1);
end
k=1;
for i=1:length(handles.observation)
    for j=i+1:length(handles.observation)
        if handles.observation(i,j)~=0
            L(k,1)=handles.observation(i,j);
            lcap(k,1)=sqrt((handles.cooravvali(j,2)-handles.cooravvali(i,2))^2+(handles.cooravvali(j,3)-handles.cooravvali(i,3))^2);
            dl(k,1)=L(k,1)-lcap(k,1);
            for counter=2:length(handles.cooravvali)
               if counter==j
                   A(k,2*(counter-1)-1)=(handles.cooravvali(j,2)-handles.cooravvali(i,2))/lcap(k,1);
                   A(k,2*(counter-1))=(handles.cooravvali(j,3)-handles.cooravvali(i,3))/lcap(k,1);
               end
               if counter==i
                   A(k,2*(counter-1)-1)=-(handles.cooravvali(j,2)-handles.cooravvali(i,2))/lcap(k,1);
                   A(k,2*(counter-1))=-(handles.cooravvali(j,3)-handles.cooravvali(i,3))/lcap(k,1);
               end
               if counter~=i&&counter~=j
                   A(k,2*(counter-1)-1)=0;
                   A(k,2*(counter-1))=0;

               end
            end
               k=k+1;
         end
     end
end
q=get(handles.edit4,'string');
w=str2num(q);
e=w(1,1)+w(1,2)/60+w(1,3)/3600;
L(k,1)=e*pi/180;
lcap(k,1)=gizman(handles.cooravvali(2,2)-handles.cooravvali(1,2),handles.cooravvali(2,3)-handles.cooravvali(1,3));
dl(k,1)=L(k,1)-lcap(k,1);
A(k,1)=(handles.cooravvali(2,3)-handles.cooravvali(1,3))/((handles.cooravvali(2,2)-handles.cooravvali(1,2))^2+(handles.cooravvali(2,3)-handles.cooravvali(1,3))^2);
A(k,2)=-(handles.cooravvali(2,2)-handles.cooravvali(1,2))/((handles.cooravvali(2,2)-handles.cooravvali(1,2))^2+(handles.cooravvali(2,3)-handles.cooravvali(1,3))^2);
gizerror=get(handles.edit6,'string');
gizkhata=str2double(gizerror);
gizkhata=gizkhata/206264.8062;
vazn(k,k)=gizkhata^(-2);
DX=((A'*vazn*A)^(-1))*A'*vazn*dl;
for i=2:length(handles.cooravvali)
    handles.cooravvali(i,2)=handles.cooravvali(i,2)+DX(2*(i-1)-1,1);
    handles.cooravvali(i,3)=handles.cooravvali(i,3)+DX(2*(i-1),1);
    guidata(hObject,handles)
end
v=A*DX-dl;
sigmasefrdo=(v'*vazn*v)/(k-2*length(handles.initial));
sigmaxx=sigmasefrdo*((A'*vazn*A)^(-1));
vazn=sigmasefrdo*vazn;
er=get(handles.edit5,'string');
er=str2double(er);
for i=1:length(DX)
    E(i,1)=er;
    sefr(i,1)=0;
end
greater=abs(DX)>=E;
while isequal(greater,sefr)==0
    k=1;
for i=1:length(handles.observation)
    for j=i+1:length(handles.observation)
        if handles.observation(i,j)~=0
            L(k,1)=handles.observation(i,j);
            lcap(k,1)=sqrt((handles.cooravvali(j,2)-handles.cooravvali(i,2))^2+(handles.cooravvali(j,3)-handles.cooravvali(i,3))^2);
            dl(k,1)=L(k,1)-lcap(k,1);
            for counter=2:length(handles.cooravvali)
               if counter==j
                   A(k,2*(counter-1)-1)=(handles.cooravvali(j,2)-handles.cooravvali(i,2))/lcap(k,1);
                   A(k,2*(counter-1))=(handles.cooravvali(j,3)-handles.cooravvali(i,3))/lcap(k,1);
               end
               if counter==i
                   A(k,2*(counter-1)-1)=-(handles.cooravvali(j,2)-handles.cooravvali(i,2))/lcap(k,1);
                   A(k,2*(counter-1))=-(handles.cooravvali(j,3)-handles.cooravvali(i,3))/lcap(k,1);
               end
               if counter~=i&&counter~=j
                   A(k,2*(counter-1)-1)=0;
                   A(k,2*(counter-1))=0;

               end
            end
               k=k+1;
         end
     end
end
L(k,1)=e*pi/180;
lcap(k,1)=gizman(handles.cooravvali(2,2)-handles.cooravvali(1,2),handles.cooravvali(2,3)-handles.cooravvali(1,3));
dl(k,1)=L(k,1)-lcap(k,1);
A(k,1)=(handles.cooravvali(2,3)-handles.cooravvali(1,3))/((handles.cooravvali(2,2)-handles.cooravvali(1,2))^2+(handles.cooravvali(2,3)-handles.cooravvali(1,3))^2);
A(k,2)=-(handles.cooravvali(2,2)-handles.cooravvali(1,2))/((handles.cooravvali(2,2)-handles.cooravvali(1,2))^2+(handles.cooravvali(2,3)-handles.cooravvali(1,3))^2);
DX=(A'*vazn*A)^(-1)*A'*vazn*dl;
for i=2:length(handles.cooravvali)
    handles.cooravvali(i,2)=handles.cooravvali(i,2)+DX(2*(i-1)-1,1);
    handles.cooravvali(i,3)=handles.cooravvali(i,3)+DX(2*(i-1),1);
    guidata(hObject,handles)
end
v=A*DX-dl;
sigmasefrdo=(v'*vazn*v)/(k-2*length(handles.initial));
sigmaxx=sigmasefrdo*((A'*vazn*A)^(-1));
vazn=sigmasefrdo*vazn;
greater=abs(DX)>=E;
end
plot(handles.cooravvali(1,2),handles.cooravvali(1,3),'g^')
hold on
X=handles.cooravvali(2:length(handles.cooravvali),2);
Y=handles.cooravvali(2:length(handles.cooravvali),3);
plot(X,Y,'r*') 
for i=1:length(handles.cooravvali)
    for j=i+1:length(handles.cooravvali)
        x=[handles.cooravvali(i,2);handles.cooravvali(j,2)];
        y=[handles.cooravvali(i,3);handles.cooravvali(j,3)];
        line(x,y)
    end
end
sigmaxx

for i=2:length(handles.cooravvali)
    ellipse=[sigmaxx(2*(i-1)-1,2*(i-1)-1) sigmaxx(2*(i-1)-1,2*(i-1));sigmaxx(2*(i-1),2*(i-1)-1) sigmaxx(2*(i-1),2*(i-1))];
    [v,d]=eig(ellipse);
    if d(1,1)>d(2,2)
        semimajordiameter=sqrt(d(1,1));
        semiminordiameter=sqrt(d(2,2));
        majordiameter=2*semimajordiameter;
        minordiameter=2*semiminordiameter;
        angleofmajorwithxaxis=gizman(v(2,1),v(1,1));
        angleofmajorwithxaxistodegree=180*angleofmajorwithxaxis/pi;
        angleofminorwithxaxis=gizman(v(2,2),v(1,2));
        angleofminorwithxaxistodegree=180*angleofminorwithxaxis/pi;
        area=pi*sqrt(semimajordiameter*semiminordiameter);
        ecc=axes2ecc(semimajordiameter,semiminordiameter);
        [elat,elon]=ellipse1(handles.cooravvali(i,2),handles.cooravvali(i,3),[semimajordiameter ecc],angleofmajorwithxaxistodegree);
        plot(elat,elon)
        handles.absoluteparameters(i-1,1:7)=[i majordiameter minordiameter angleofmajorwithxaxistodegree angleofminorwithxaxistodegree ecc area];
        guidata(hObject,handles)
    end
    if d(2,2)>d(1,1)
        semimajordiameter=sqrt(d(2,2));
        semiminordiameter=sqrt(d(1,1));
        majordiameter=2*semimajordiameter;
        minordiameter=2*semiminordiameter;
        angleofmajorwithxaxis=gizman(v(2,2),v(1,2));
        angleofmajorwithxaxistodegree=180*angleofmajorwithxaxis/pi;
        angleofminorwithxaxis=gizman(v(2,1),v(1,1));
        angleofminorwithxaxistodegree=180*angleofminorwithxaxis/pi;
        area=pi*sqrt(semimajordiameter*semiminordiameter);
        ecc=axes2ecc(semimajordiameter,semiminordiameter);
        [elat,elon]=ellipse1(handles.cooravvali(i,2),handles.cooravvali(i,3),[semimajordiameter ecc],angleofmajorwithxaxistodegree);
        plot(elat,elon)
        handles.absoluteparameters(i-1,1:7)=[i majordiameter minordiameter angleofmajorwithxaxistodegree angleofminorwithxaxistodegree ecc area];
        guidata(hObject,handles)
    end
end
k=1;
for i=1:length(handles.cooravvali)
    for j=i+1:length(handles.cooravvali)
        if i==1
            sigma=[0 0 0 0;0 0 0 0;0 0 sigmaxx(2*(j-1)-1,2*(j-1)-1) sigmaxx(2*(j-1)-1,2*(j-1));0 0 sigmaxx(2*(j-1),2*(j-1)-1) sigmaxx(2*(j-1),2*(j-1))];
            z=[-1 0 1 0;0 -1 0 1];
            beyzi=z*sigma*z';
            x_mid=(handles.cooravvali(i,2)+handles.cooravvali(j,2))/2;
            y_mid=(handles.cooravvali(i,3)+handles.cooravvali(j,3))/2;
            plot(x_mid,y_mid,'b*')
            [v,d]=eig(beyzi);
                if d(1,1)>d(2,2)
                    semimajordiameter=sqrt(d(1,1));
                    semiminordiameter=sqrt(d(2,2));
                    majordiameter=2*semimajordiameter;
                    minordiameter=2*semiminordiameter;
                    angleofmajorwithxaxis=gizman(v(2,1),v(1,1));
                    angleofmajorwithxaxistodegree=180*angleofmajorwithxaxis/pi;
                    angleofminorwithxaxis=gizman(v(2,2),v(1,2));
                    angleofminorwithxaxistodegree=180*angleofminorwithxaxis/pi;
                    area=pi*sqrt(semimajordiameter*semiminordiameter);
                    ecc=axes2ecc(semimajordiameter,semiminordiameter);
                    [elat,elon]=ellipse1(x_mid,y_mid,[semimajordiameter ecc],angleofmajorwithxaxistodegree);
                    plot(elat,elon)
                    handles.relativeparameters(k,1:10)=[i j x_mid y_mid majordiameter minordiameter angleofmajorwithxaxistodegree angleofminorwithxaxistodegree ecc area];
                    k=k+1;
                    guidata(hObject,handles)
                end
                if d(2,2)>d(1,1)
                    semimajordiameter=sqrt(d(2,2));
                    semiminordiameter=sqrt(d(1,1));
                    majordiameter=2*semimajordiameter;
                    minordiameter=2*semiminordiameter;
                    angleofmajorwithxaxis=gizman(v(2,2),v(1,2));
                    angleofmajorwithxaxistodegree=180*angleofmajorwithxaxis/pi;
                    angleofminorwithxaxis=gizman(v(2,1),v(1,1));
                    angleofminorwithxaxistodegree=180*angleofminorwithxaxis/pi;
                    area=pi*sqrt(semimajordiameter*semiminordiameter);
                    ecc=axes2ecc(semimajordiameter,semiminordiameter);
                    [elat,elon]=ellipse1(x_mid,y_mid,[semimajordiameter ecc],angleofmajorwithxaxistodegree);
                    plot(elat,elon)
                    handles.relativeparameters(k,1:10)=[i j x_mid y_mid majordiameter minordiameter angleofmajorwithxaxistodegree angleofminorwithxaxistodegree ecc area];
                    k=k+1;
                    guidata(hObject,handles)
                end
        end
        if i~=1
            sigma=[sigmaxx(2*(i-1)-1,2*(i-1)-1) sigmaxx(2*(i-1)-1,2*(i-1)) sigmaxx(2*(i-1)-1,2*(j-1)-1) sigmaxx(2*(i-1)-1,2*(j-1));sigmaxx(2*(i-1),2*(i-1)-1) sigmaxx(2*(i-1),2*(i-1)) sigmaxx(2*(i-1),2*(j-1)-1) sigmaxx(2*(i-1),2*(j-1));sigmaxx(2*(j-1)-1,2*(i-1)-1) sigmaxx(2*(j-1)-1,2*(i-1)) sigmaxx(2*(j-1)-1,2*(j-1)-1) sigmaxx(2*(j-1)-1,2*(j-1));sigmaxx(2*(j-1),2*(i-1)-1) sigmaxx(2*(j-1),2*(i-1)) sigmaxx(2*(j-1),2*(j-1)-1) sigmaxx(2*(j-1),2*(j-1))];
            z=[-1 0 1 0;0 -1 0 1];
            beyzi=z*sigma*z';
            x_mid=(handles.cooravvali(i,2)+handles.cooravvali(j,2))/2;
            y_mid=(handles.cooravvali(i,3)+handles.cooravvali(j,3))/2;
            plot(x_mid,y_mid,'b*')
            [v,d]=eig(beyzi);
                if d(1,1)>d(2,2)
                    semimajordiameter=sqrt(d(1,1));
                    semiminordiameter=sqrt(d(2,2));
                    majordiameter=2*semimajordiameter;
                    minordiameter=2*semiminordiameter;
                    angleofmajorwithxaxis=gizman(v(2,1),v(1,1));
                    angleofmajorwithxaxistodegree=180*angleofmajorwithxaxis/pi;
                    angleofminorwithxaxis=gizman(v(2,2),v(1,2));
                    angleofminorwithxaxistodegree=180*angleofminorwithxaxis/pi;
                    area=pi*sqrt(semimajordiameter*semiminordiameter);
                    ecc=axes2ecc(semimajordiameter,semiminordiameter);
                    [elat,elon]=ellipse1(x_mid,y_mid,[semimajordiameter ecc],angleofmajorwithxaxistodegree);
                    plot(elat,elon)
                    handles.relativeparameters(k,1:10)=[i j x_mid y_mid majordiameter minordiameter angleofmajorwithxaxistodegree angleofminorwithxaxistodegree ecc area];
                    k=k+1;
                    guidata(hObject,handles)
                end
                if d(2,2)>d(1,1)
                    semimajordiameter=sqrt(d(2,2));
                    semiminordiameter=sqrt(d(1,1));
                    majordiameter=2*semimajordiameter;
                    minordiameter=2*semiminordiameter;
                    angleofmajorwithxaxis=gizman(v(2,2),v(1,2));
                    angleofmajorwithxaxistodegree=180*angleofmajorwithxaxis/pi;
                    angleofminorwithxaxis=gizman(v(2,1),v(1,1));
                    angleofminorwithxaxistodegree=180*angleofminorwithxaxis/pi;
                    area=pi*sqrt(semimajordiameter*semiminordiameter);
                    ecc=axes2ecc(semimajordiameter,semiminordiameter);
                    [elat,elon]=ellipse1(x_mid,y_mid,[semimajordiameter ecc],angleofmajorwithxaxistodegree);
                    plot(elat,elon)
                    handles.relativeparameters(k,1:10)=[i j x_mid y_mid majordiameter minordiameter angleofmajorwithxaxistodegree angleofminorwithxaxistodegree ecc area];
                    k=k+1;
                    guidata(hObject,handles)
                end
        end
    end
end
    




function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,pathname]=uiputfile('*.txt','save relative error ellipse parameters');
if pathname==0
    return
end
file5=fullfile(pathname,filename);
fid=fopen(file5,'w');
myvar = handles.relativeparameters';
fprintf(fid,'firstpoint--second point--x_center--y_center--major diameter--minor diameter--angle of major diameter with x axis--angle of minor diameter with x axis--eccentricity--area\r\n\r\n\r\n');
fprintf(fid,'%0.0f-- %0.0f-- %6.4f-- %6.4f-- %6.4f-- %6.4f-- %6.4f-- %6.4f-- %6.4f-- %6.4f\r\n\r\n',myvar);
fclose(fid);
