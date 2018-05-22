function Imgbw= binarize_Img_threshold(Img,se_background,thresholdaddition)
% this simple matlab function binarizes color or grayscale images and is particularly suited for manuscript images
% input 
%   Img:color or grayscale image
% 	se_background: structuring element, e.g. strel('disk',50) depending on image resolution, script, etc
%	thresholdaddition: real, added to the calculated global threshold of the adjusted image

% output
%	inverted binary image of estimated foreground (script)

% Copyright © 2018 Daniel Stökl Ben Ezra, EPHE, PSL, ALMAnaCH, UMR 8167 Orient et Méditerranée in Paris
% daniel.stoekl@ephe.sorbonne.fr, daniel.stoekl@ephe.psl.eu

%    This program is free software: you can redistribute it and/or modify it under the terms of the GNU Lesser General Public License Version 3 as published by the Free Software Foundation.

%    This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

%    You should have received a copy of the GNU Lesser General Public License along with this program.  If not, see <https://www.gnu.org/licenses/lgpl-3.0.en.html>.

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
% apply global binarization with the user defined threshold
    Imgbw=im2bw(fore_adjusted,grayt+threshold);

    