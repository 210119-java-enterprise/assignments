package com.revature;

public class BinaryTree <T extends Comparable<? super T>> {

    private Node<T> root;
    private int size;


    public void insert(Comparable<T> data) {
        if (data == null) {
            return;
        }
        root = traverseInsert(root, data);
    }

    private Node traverseInsert(Node node, Comparable<T> data) {
        if (node == null) { // base case for stopping recursion, if tree is empty or current node is null, then insert a new node
            node = new Node(data);
            size+=1;
            return node;
        }
        else {

            // data in parameter is greater than data in current node
            if (node.data.compareTo(data) < 0 || node.data.compareTo(data) == 0) {
                node.rightChild = traverseInsert(node.rightChild, data);
            } else if (node.data.compareTo(data) > 0) { // data in parameter is less than data in node
                node.leftChild = traverseInsert(node.leftChild, data);
            }
        }
        return node;
    }

    public boolean contains(Comparable<T> data) {
        if (data == null)
        {
            return false;
        }
        if(containsTraverse(root, data) == null)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    private Node containsTraverse(Node node, Comparable<T> data) {

        // If the node is null or if the the value is found, return the node
        if (node == null || node.data.compareTo(data) == 0)
        {
            return node;
        }
        else
        {
            // data in parameter is greater than data in current node, the node is equal to the node's right child called recursively
            if (node.data.compareTo(data) < 0) {

                node = containsTraverse(node.rightChild, data);
            } else if (node.data.compareTo(data) > 0) { // data in parameter is less than data in node, the node is equal to the node's left child
                node = containsTraverse(node.leftChild, data); // called recursively
            }
        }

        // Needed to return the correct node in the end, else the recursion doesn't work
        return node;
    }

    public void remove (Comparable<T> data) {
        if (data == null)
        {
            return;
        } // if

        traverseRemove(root, data);
    } // remove()

    private Node traverseRemove(Node node, Comparable<T> dataToRemove) {

        if (node == null)
        {
            return root;
        } // if
        // data in parameter is greater than data in current node
        if (node.data.compareTo(dataToRemove) < 0) {
            node.rightChild = traverseRemove(node.rightChild, dataToRemove);
        } else if (node.data.compareTo(dataToRemove) > 0) { // data in parameter is less than data in node
            node.leftChild = traverseRemove(node.leftChild, dataToRemove);
        } // else if
        else{
            // if the left child is null, then the previous node's next child is this node's right child
            if(node.leftChild == null)
            {
                size-=1;
                return node.rightChild;

            } // if
            else if (node.rightChild == null) // If the right child is null, the previous node's next child is this node's left child
            { size-=1;
                return node.leftChild;
            } // else if
            size-=1;
            Node tempNode = node.rightChild;
            while(tempNode.leftChild != null)
            {
                node.data = tempNode.leftChild.data;
                tempNode = tempNode.leftChild;
            } // while
            tempNode = null;

            // Since the lowest value to the right of the binary tree was set to the node that was just removed, delete the node that has that
            // value

            node.rightChild = traverseRemove(node.rightChild, node.data);
        } // else
        return node;
    } // Node traverseRemove()



    public int size() {
        return size;
    }



    private static class Node<T extends Comparable<? super T>> {
        Comparable<T> data;
        Node<T> leftChild;
        Node<T> rightChild;

        Node(Comparable<T> data) {
            this.data = data;
        }

        Node(Comparable<T>  data, Node<T> leftChild, Node<T> rightChild) {
            this(data);
            this.leftChild = leftChild;
            this.rightChild = rightChild;
        }


    }

}