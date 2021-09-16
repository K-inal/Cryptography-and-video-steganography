clear all;
clc
close all
% function ctimg = img_encrypt(img)
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

%%%%----------------------Video to frame

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
 workingDir = 'D:\Mine 20-21\Blowfish_nitte\Blow_fish_nitte\Tosend\Tosend';
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

%----------------------------encode
[namefile,pathname]=uigetfile('*.*','Select a Image');
img = imread([pathname,namefile]);
% img1 = imread([pathname,namefile]);
fin = fopen('output.txt','r');
pt  = fread(fin,[1 16]);
% txt = 'abcd'
delete([pathname,namefile]);
encoded_image = encode(img,pt);
sum1 = sum(sum(encoded_image));
namefile2 = namefile;
imwrite(encoded_image, [pathname,namefile])
imshow(encoded_image);


imageNames = dir(fullfile(workingDir,'test1','*.bmp'));
imageNames = {imageNames.name}';

outputVideo = VideoWriter(fullfile(workingDir,'output1.avi'));
outputVideo.FrameRate = vobj.FrameRate
%disp('frame_rate',vobj.FrameRate)
open(outputVideo)
for ii = 1:length(imageNames)
   img = imread(fullfile(workingDir,'test1',imageNames{ii}));
   writeVideo(outputVideo,img)
end

close(outputVideo)