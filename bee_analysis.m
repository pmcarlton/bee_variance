## octave code for analyzing images:

```{octave}
pkg load image 		% requires 'image' toolbox from octave-forge ("pkg install -forge image" if you don't have it)
g=glob("rescaled*"); 	% matches each filename we made earlier with "convert"
a=uint8(zeros(113,113,97));	% pre-allocate memory for the target image array
for l=1:numel(g);
	r=imread(g{l});
	a(:,:,l)=medfilt2(r); % apply median-filtering to each image to reduce JPEG compression artifacts
	end
	
% fill in the corners of each image with white, since the median filter will leave them black:
a(:,:,1).*=255; a(1,1,:)=255; a(end,1,:)=255; a(1,end,:)=255; a(end,end,:)=255; 

% use "bwconncomp" from the image toolbox to count the actual number of shapes in each target image:
for l=1:97;
	q=bwconncomp(a(:,:,l)<200);
	objs(l)=q.NumObjects;
	end
	
% measure intensity steps in the X and Y directions using sums of absolute differences
for l=1:97;
	r=a(:,:,l)<200; % binarize the median-filtered images: black is 0, white is 1
	b(l)=mean(sum(abs(diff(r,[],1))));
	c(l)=mean(sum(abs(diff(r,[],2))));
	end
	
rr=b+c; % sum the variances calculated over the X and Y directions

% plotting:

plot(objs(1),rr(1),'ks;blank;',objs(2:33),rr(2:33),'rd;Diamonds;',objs(34:65),rr(34:65),'gs;Squares;',objs(66:97),rr(66:97),'bo;Circles;');
ggcf=get(gcf,'children');
set(ggcf(1),'location','northwest');
gra=get(gca,'children');
for l=1:4;set(gra,'markersize',12);end
xlabel("# of objects")
ylabel("simple variance")

```
