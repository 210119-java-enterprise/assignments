package com.revature.util;

public class BinaryTree<T extends Comparable<T>> {

    public Node<T> root;
    public int size;

    //finds the min of the tree
    public T min(Node<T> root){
        if(root.left == null){
            return root.data;
        }
        return min(root.left);

    }

    //finds the max of the tree
    public T max(Node<T> root){
        if(root.right == null){
            return root.data;
        }
            return max(root.right);
    }

    public void printTree(Node<T> node, String p)
    {
        if(node == null) return;

        printTree(node.left , p + " ");
        System.out.println(node.data);
        printTree(node.right , p + " ");

    }

    public void insert(T data) {
        if( data == null){
            return;
        }
        else {
            root = insertRec(root, data);
        }
    }
    //insert recursive
    private Node<T> insertRec(Node<T> tempNode, T data) {
        if(tempNode == null){
            return new Node<>(data);
        }
        if (data.compareTo(tempNode.data) > 0) {
            tempNode.right = insertRec(tempNode.right, data);
        }
        else if(data.compareTo(tempNode.data) < 0){
            tempNode.left = insertRec(tempNode.left, data);
        }
        return tempNode;
    }

    public boolean constains(T data){
        return constainsRec(root,data);
    }

    public boolean constainsRec(Node<T> tempNode, T data){
        if (data == null){
            return false;
        }
        if(data.equals(tempNode.data)){
            return true;
        }
        if (data.compareTo(tempNode.data) > 0){
            return constainsRec(tempNode.right, data);
        }
        else{
            return constainsRec(tempNode.left, data);
        }

    }

    public void remove(T data){
        root = removeRec(root,data);
    }

    public Node<T> removeRec(Node<T> tempNode, T data){
        if (data == null){
            return null;
        }

        if(data == tempNode.data){
            if(tempNode.left == null && tempNode.right == null){
                return null;
            }

            if(tempNode.left == null){
                return tempNode.right;
            }

            if(tempNode.right == null){
                return tempNode.left;
            }
            T min = min(tempNode.right);
            tempNode.data = min;
            tempNode.right = removeRec(tempNode.right, min);
            return tempNode;
        }

        if(data.compareTo(tempNode.data)< 0){
            tempNode.left = removeRec(tempNode.left, data);
        }
        else {
            tempNode.right = removeRec(tempNode.right, data);
        }
        return tempNode;

    }

    public int size(){
        return size(root);
    }
    public int size(Node<T> root){
        if(root == null){
            return 0;
        }
        return size = size(root.left)+size(root.right)+1;

    }
    private static class Node<T extends Comparable<T>> {
        T data;
        Node<T> left;
        Node<T> right;

        Node(T data) {
            this.data = data;
        }

        Node(T data, Node<T> left, Node<T> right) {
            this(data);
            this.left = left;
            this.right = right;
        }

    }

}