%binarize_Img
function Imgbw= binarize_Img_threshold(Img,se_background,threshold)

    [height_pic, width_pic, colors]=size(Img);
    if colors>1 grayimage=rgb2gray(Img); else grayimage=Img; end
    background = imclose(grayimage,se_background);
    %figure;imshow(background)
    foreground = background-grayimage;
    %figure;imshow(foreground)
    fore_adjusted = imadjust(foreground);
    %figure;imshow(fore_adjusted)
    grayt=graythresh(fore_adjusted);
    Imgbw=im2bw(fore_adjusted,grayt+threshold);
    %figure;imshow(Imgbw);
    %Imgbw2=bwareaopen(Imgbw,50);
    %figure;imshowpair(Imgbw,Imgbw2)
    %figure;imshow(Imgbw2);
    