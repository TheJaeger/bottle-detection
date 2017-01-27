This problem requires the detection of imporperly filled bottles on a factory production line.

The following assumptions were made in solving this problem:
1.)	Every image taken by the has bottles arranged in the same fashion
2.)	Distance between each bottle remains constant
3.)	Only the three bottle in the center are used for analysis, the
	bottles on the edge of the image are disregarded
4.)	Bottles move in threes, so the first bottle is replaced by the
	bottle at the right edge of the frame. At every movement, the camera
	taken an image. This implies that every bottle is considered for analysis,
	whether it had been at the edge of the image or not.

The following approach was taken to solve this problem:
a.)	Applied a Gaussian low-pass filter to smoothen image and reduce noise.
b.)	Rectangular coordinates were defined that encompassed each of the three bottles.
c.)	The image was cropped at each of the three coordinates and the image was
	quantized based on two threshold values. The second quantization held information
	on the level of liquid in each bottle, and hence, was reassigned a value of 1.
	The other quantization were assigned a value of 0
d.)	Using these values, the area of the binary image of each bottle was determined
	using regionprops(I, ‘Area’). The average area of the level of liquid in each bottle
	was also determined.
e.)	A loop function was used that compared the level of liquid in each bottle and
	identified the bottle with area less than the average. The results of this method
	of detection are shown below.
