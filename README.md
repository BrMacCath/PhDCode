# PhDCode

Code I created during my PhD. Uses optimization algorithms on images.

## Local variance

This is code where you can create a subvariety to randomly sample from. With a randomly sampled element you can create a projection matrix and see how well the image retains its shape. The subvarieties we make are by taking eigenvectors of matrices that are used to measure variance in order to minise variance.

## One dimensional sampling

Points on a Grassmannian can be defined by the projection matrix they form. Furthermore we can embed Daubechies wavelets in Grassmannian and make paths between any two points on a Grassmannian. For each function on a specified domain, if we sample it we can make a set that allows us to apply a projection matrix to see how well it works in practice. Furthermore, it allows us to explore ''Daubechies triangles" to examine if there is potential in utilizing these structures.

## Two dimensional sampling

To extend the cases for experimentation, I applied these algorithms to a 2 dimensional version, images. We can still see the effect of the algorithms applied here but this time we can apply them to MNIST and jpg images.

## Sparse Matrix Variety

When talking about regions of compressing images, Grassmannians are a natural candidate as each point on a Grassmannian can be uniquely defined by a projection matrix, which can be used to compress images. Furthermore, another common technique to process images is to use wavelets. Daubechies wavelets can be mapped into Grassmannians and furthermore, there is a specific structure they follow within Grassmannians. The purpose of this folder is to experiment with a structure found by examining Daubechies wavelets within Grassmannians.

The structure defined creates a Schubert cell within Grassmannians. It is possible to generate elements in this variety and to travel along it using rotation matrices instead of derivatives. A major advatage of this is that we can use machine learning algorithms in a less computationally expensive way.

## Experimental Code

This is code from a future paper.
