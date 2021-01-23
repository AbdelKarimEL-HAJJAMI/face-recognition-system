# PCA-based-face-recognition-system

Implementation of a MATLAB program allowing face recognition using the PCA method.

=Introduction :
This project is based on an article called Eigenfaces for recognition, written by Turk and Pentland and published in the Journal of Cognitive Neuroscience in 1991.
This article constitutes one of the most interesting and popular applications of PCA in the field of pattern recognition. It is simply a matter of applying the PCA from very large data: images of faces. 


=Description of data : 
We have 240 images of faces of 40 people with various facial expressions and under various lighting conditions. Each of these grayscale images is stored in a two-dimensional matrix of size 480 x 640. 
These images constitute the training data. By vectorizing them, we can therefore represent these images by column vectors of dimension p = 480 x 640 = 307200
The models are trained with

