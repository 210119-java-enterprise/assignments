package com.revature;

public class BinaryTree <T extends Comparable<? super T>> {

    private Node<T> root;
    private int size;


    public void insert(T data) {
        if (data == null) {
            return;
        }
        root = traverseInsert(root, data);
    }

    private Node traverseInsert(Node node, T data) {
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

    public boolean contains(T data) {

    }

    public void remove (T data) {
        if (data == null)
        {
            return;
        }

        traverseRemove(root, data);
    }

    private void traverseRemove(Node node, T dataToRemove) {

            if (node.data.compareTo(dataToRemove) == 0)
            {
                // This is a leaf (No children)
                if(node.rightChild == null && node.leftChild == null)
                {
                    node = null;
                    return;
                }
                else if (node.leftChild != null && node.rightChild == null)
                {
                    Node tempNode = node.leftChild;
                    node.leftChild = null;
                    node = tempNode;
                }
                else if (node.leftChild == null && node.rightChild != null)
                {
                    Node tempNode = node.rightChild;
                    node.rightChild = null;
                    node = tempNode;
                }
                else if (node.leftChild != null && node.rightChild != null) {

                }
            }
            // data to remove in parameter is greater than data in current node
            else if (node.data.compareTo(data) < 0) {
                node.rightChild = traverseInsert(node.rightChild, dataToRemove);
            } else if (node.data.compareTo(data) > 0) { // data in parameter is less than data in node
                node.leftChild = traverseInsert(node.leftChild, dataToRemove);
            }

        return node;
    }



    public int size() {
        return size;
    }



    private static class Node<T extends Comparable<? super T>> {
        T data;
        Node<T> leftChild;
        Node<T> rightChild;

        Node(T data) {
            this.data = data;
        }

        Node(T data, Node<T> leftChild, Node<T> rightChild) {
            this(data);
            this.leftChild = leftChild;
            this.rightChild = rightChild;
        }


    }

}