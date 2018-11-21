# Node-Link-Graph-Visualization
How to make graphs easier to understand, by creating a circle link graph and line link graph.

To make the graph clear we have implemented an algorithm, The purpose of this algorithm is to build an arcs diagram from a graph G of N nodes. An arcs diagram consists of placing the nodes (v0, v1, v2, ..., vN-1) of G on an axis and replace each edge with an arc joining them as shown in Figure below.

![alt text](https://github.com/CHEREF-Mehdi/Node-Link-Graph-Visualization/blob/master/ImageForReadMe/Capture2.PNG)

If the distance between two connected nodes increases, the arcs will be away from the axis, which increases the viewing space. The goal is to find the best placement of the nodes on the axis which reduces the lengths of the arcs to draw.

To do this, it will be necessary to bring each node closer to its neighbors to minimiz the distance of each node of the centroid of its neighbors. A measure d is associated to each node indicating its distance to the centroid of its neighbors. Assuming that the nodes are arranged in an array Ti, d(Vk) is calculated as follows :

![alt text](https://github.com/CHEREF-Mehdi/Node-Link-Graph-Visualization/blob/master/ImageForReadMe/Capture3.PNG)

Where Vk is the considered node, nb is the number of neighbors including Vk and ij is the index of the neighbor number j in Ti.

The proposed computer solution for this project could therefore construct two diagrams in arcs (circular and linear) whatever the number of nodes of the graph G.

# About the proposed solution

The user can add nodes and arcs as many as he want inside the space of drawing (in the right side), and the solution will draw automaticly the optimized and NON-optimized arc diagrams (in the left side) associated to the graph G.

![alt text](https://github.com/CHEREF-Mehdi/Node-Link-Graph-Visualization/blob/master/ImageForReadMe/Capture.png)

# About Processing tool

Processing is a Java library and free development environment, created by Benjamin Fry and Casey Reas, two American artists.

URL : https://processing.org/
