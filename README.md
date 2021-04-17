# face-recognition-system

Implementation of a MATLAB program allowing face recognition using the PCA and the KNN classification methods.

Introduction :
-

This project is based on an article called Eigenfaces for recognition, written by Turk and Pentland and published in the Journal of Cognitive Neuroscience in 1991.
This article constitutes one of the most interesting and popular applications of PCA in the field of pattern recognition. It is simply a matter of applying the PCA from very large data: images of faces. 


Description of data : 
-

We have 240 images of faces of 40 people with various facial expressions and under various lighting conditions. Each of these images is stored in a two-dimensional matrix of size 480 x 640. By vectorizing them, we can therefore represent these images by column vectors of dimension p = 480 x 640 = 307200.

In this project, only 4 individuals and 4 out of 6 postures are selected to form part of the training data; it will of course be necessary to consider a greater number of individuals and postures for a better performance.



Program implementation :
-

The objective of the program is to predict the image (or images) from the database that is (are) the most similar to a query image given as input.

It is inappropriate to use the p = 307200 pixels to compare the query image with each of the images in the database. The PCA is then a necessary preprocessing which consists in reducing the dimension of the data to have compact representations that best preserve the information contained in each image.

![image](https://user-images.githubusercontent.com/66040216/115105673-b490d700-9f60-11eb-96b0-c9408172effe.png)


The prediction can be defined in various ways. Among the simplest possibilities, one can look for the images of the database whose compact representations are closer (in the sense of a well-chosen distance d) to that associated with the query image.

In this project we used the KNN classification method for the prediction.

![image](https://user-images.githubusercontent.com/66040216/115105696-e30eb200-9f60-11eb-8203-d22798b41250.png)
