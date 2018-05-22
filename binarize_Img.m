function Imgbw= binarize_Img(Img,se_background)
% this simple function binarizes color or grayscale images and is particularly suited for manuscript images
% input 
%   Img:color or grayscale image
% 	se_background: structuring element, e.g. strel('disk',50) depending on image resolution, script, etc
% output
%	inverted binary image of estimated foreground (script)

% Daniel Stökl Ben Ezra, EPHE, PSL, ALMAnaCH, ULR 8167 Orient et Méditerranée in Paris
% daniel.stoekl@ephe.sorbonne.fr, daniel.stoekl@ephe.psl.eu

% transform color to grayscale image. 
% if you want to use a specific channel only just submit that channel as Img
    [~, ~, colors]=size(Img);
    if colors>1 grayimage=rgb2gray(Img); else grayimage=Img; end
% morphological transformation to reduce foreground and arrive at background image (parchment, paper, papyrus, etc)
    background = imclose(grayimage,se_background);
% deduce the graylevel image from the background to arrive at inverted foreground (script)
    foreground = background-grayimage;
% adjust image intensity values to improve contrast
    fore_adjusted = imadjust(foreground);
% calculate threshold for this adjusted foreground
    grayt=graythresh(fore_adjusted);
% apply global binarization 
    Imgbw=im2bw(fore_adjusted,grayt);
    