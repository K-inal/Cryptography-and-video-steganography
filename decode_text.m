load fin1
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

%--------------------------------select frame------------

[namefile,pathname]=uigetfile('*.*','Select a Image');
img = imread([pathname,namefile]);

sum2 = sum(sum(img));

if namefile == namefile2;

% txt = 'abcd'
dec_fout = fopen('dec_output.txt','w');
delete([pathname,namefile])
decode_text1 = decode(img);
fwrite(dec_fout,decode_text1);
ml = pt;
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

   
    
    

fprintf('Decrytion Completed');
fclose(fin);
fclose(fout);

else
    disp('Entered image not matching')
 end