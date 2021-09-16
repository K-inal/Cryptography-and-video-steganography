function varargout = main1234(varargin)
% MAIN1234 MATLAB code for main1234.fig
%      MAIN1234, by itself, creates a new MAIN1234 or raises the existing
%      singleton*.
%
%      H = MAIN1234 returns the handle to a new MAIN1234 or the handle to
%      the existing singleton*.
%
%      MAIN1234('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN1234.M with the given input arguments.
%
%      MAIN1234('Property','Value',...) creates a new MAIN1234 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main1234_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main1234_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main1234

% Last Modified by GUIDE v2.5 10-Jun-2021 09:23:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main1234_OpeningFcn, ...
                   'gui_OutputFcn',  @main1234_OutputFcn, ...
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


% --- Executes just before main1234 is made visible.
function main1234_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main1234 (see VARARGIN)

% Choose default command line output for main1234
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main1234 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main1234_OutputFcn(hObject, eventdata, handles) 
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
global m1
[key,pbox,sbox] = Genrate();
fin = fopen('input.txt','r');

fout = fopen('output.txt','w');
 pt  = fread(fin,[1 16])
 disp(pt)
% 
ct = Blow_text(pt,pbox,sbox);
cl = ct(1:4);
cr = ct(5:8);
n =3;c =1;
ml = cl(1:2);
mr = cr(1:2);
while(n <= 4 )
ml = vertcat(ml,cl(n:n+1));
mr = vertcat(mr,cr(n:n+1));
n =n+2;
end
m1 = pt;
disp(ml)
disp(mr)
fwrite(fout,ct);
fprintf('Encrytion Completed');
fclose(fin);
fclose(fout);
% save m1
f = warndlg('Completed Text Encryption','Alert');

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('Select a video');
[namefile,pathname]=uigetfile('*.*','Select a video');


if namefile~=0
   vname = sprintf('%s%s',pathname,namefile);
    disp('Input file has been selected.');    
else
    error('No valid file has been selected.');
end
% vname = 'Roof1.avi';
vobj = VideoReader(vname);
f1=size(vobj);
 Frames=vobj.NumberOfFrames;

ii=1;
 workingDir = 'C:\Users\khush\Downloads\Tosend(1)\Tosend';
mkdir(workingDir,'test1')
 FDetect = vision.CascadeObjectDetector;
for i = 1:Frames-1
    a0=read(vobj,i);
    a0=imresize(a0,[256 256]);
    a0 = rgb2gray(a0);
    
     
filename = [sprintf('Frame%3d',ii) '.bmp'];
fullname = fullfile(workingDir,'test1',filename)
imwrite(a0,fullname)

   ii = ii+1;
end

% f = warndlg('Completed Video to Frame Convertion','Alert');

global namefile2
% [namefile,pathname]=uigetfile('*.*','Select a Image');
% img = imread([pathname,namefile]);
img = imread('test1\Frame  1.bmp');
workingDir = 'C:\Users\khush\OneDrive\Desktop\main_proh\Tosend';
fin = fopen('output.txt','r');
pt  = fread(fin,[1 16]);
% txt = 'abcd'
%delete([pathname,namefile]);
encoded_image = encode(img,pt);
sum1 = sum(sum(encoded_image));
namefile2 = namefile;
imwrite(encoded_image, 'test1/Frame  1.bmp')
%imshow(encoded_image);
namefile2 = 'Frame  1.bmp';

imageNames = dir(fullfile(workingDir,'test1','*.bmp'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,'output1.avi'));
outputVideo.FrameRate = 30;
open(outputVideo)
for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,'test1',imageNames{ii}));
   writeVideo(outputVideo,img)
end

close(outputVideo)
f = warndlg('Completed Text Encryption into Selected Frame and converted into video','Alert');

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namefile11
 rmdir('test1','s')
load fin1

disp('Select a video');
[namefile,pathname]=uigetfile('*.*','Select a video');
namefile22 = string(namefile)
namefile11 = string(namefile11)

ff = strcmp( namefile22,namefile11)

if ff == 0
if namefile~=0
   vname = sprintf('%s%s',pathname,namefile);
    disp('Input file has been selected.');    
else
    error('No valid file has been selected.');
end
namefile
if namefile == 'output1.avi'
vobj = VideoReader(vname);

   
f1=size(vobj);
 Frames=vobj.NumberOfFrames;

ii=1;
 workingDir = 'C:\Users\khush\OneDrive\Desktop\main_proh\Tosend';
mkdir(workingDir,'test2')
 FDetect = vision.CascadeObjectDetector;
for i = 1:Frames-1
    a0=read(vobj,i);
    a0=imresize(a0,[256 256]);
    a0 = rgb2gray(a0);
    
     
filename = [sprintf('Frame%3d',ii) '.bmp'];
fullname = fullfile(workingDir,'test2',filename)
imwrite(a0,fullname)

   ii = ii+1;
end

f = warndlg('Encrypted Video to frame conversion Completed','Alert');
else
    cp1 = 'Do not select same video'
    set(handles.edit1, 'String', cp1);
    msg = 'Error occurred.';
    error(msg)
end

else 
    cp1 = 'Do not select same video'
    set(handles.edit1, 'String', cp1);
    msg = 'Error occurred.';
    error(msg)
end

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global namefile2
global m1
% [namefile,pathname]=uigetfile('*.*','Select a Image');
% img = imread([pathname,namefile]);

img = imread('test2/Frame  1.bmp')
namefile = 'Frame  1.bmp';
string(namefile)
if namefile == namefile2;


dec_fout = fopen('dec_output.txt','w');
%delete([pathname,namefile])
decode_text1 = decode(img);
fwrite(dec_fout,decode_text1);
%ml = pt;
% pt  = fread(fin,[1 16]);


%---------------------Text Decrypt_Blow_fish--------------------

[key,pbox,sbox] = Genrate();
fin = fopen('dec_output.txt','r');
fout = fopen('final_output.txt','w');
%rimg = reshape(img,1,[]);
% ctimg = zeros(size(rimg));
count = 1;

pt  = fread(fin,[1 8]);
              
ct = Blow_dtext(pt,pbox,sbox);
    cl = ct(1:4);
    cr = ct(5:8);
     n =3;c =1;
     ml = cl(1:2);
     mr = cr(1:2);
     while(n <= 4 )
        ml = vertcat(ml,cl(n:n+1));
        mr = vertcat(mr,cr(n:n+1));
        n =n+2;
     end
    cp11 = m1
    cp1 = char(m1)
    fwrite(fout,cp11);

    set(handles.edit1, 'String', cp1);
    
    

fprintf('Decrytion Completed');
fclose(fin);
fclose(fout);

else
    disp('Entered image not matching')
    cp1 = 'Entered image not matching';
    set(handles.edit1, 'String', cp1);
    msg = 'Error occurred.';
    error(msg)
    
 end
f = warndlg('Frame Decryption Completed','Alert');
rmdir('test2','s')% --- Executes on button press in pushbutton6.



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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
close all
clear all