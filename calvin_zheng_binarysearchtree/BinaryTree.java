package com.revature.util;

public class BinaryTree<T extends Comparable<T>> {

    public Node<T> root;

    public void printTree(Node<T> node, String p)
    {
        if(node == null) return;

        System.out.println(p + " + " + node.data);
        printTree(node.left , p + " ");
        printTree(node.right , p + " ");
    }

    public void insert(T data){
        if (data.equals(null)){
            //return nothing, can't accept null values
            return;
        }
            Node<T> newNode = new Node<T>(data);
            if (root == null) {
                root = newNode;
            } else {
                Node<T> tempNode = root;
                Node<T> prev = null;
                while (tempNode != null) {
                    prev = tempNode;
                    if (data.compareTo(tempNode.data) > 0) {
                        tempNode = tempNode.right;
                    } else {
                        tempNode = tempNode.left;
                    }
                }
                if (data.compareTo(prev.data) < 0) {
                    prev.left = newNode;
                } else {
                    prev.right = newNode;
                }
            }
    }


    public boolean constains(T data){
        if (data == null){
            return false;
        }
        Node<T> newNode = new Node<T>(data);
        Node<T> templeftNode = root;
        Node<T> temprightNode = root;
        if(data.equals(templeftNode)){
            return true;
        }
        templeftNode = templeftNode.left;
        temprightNode = temprightNode.right;
        while (templeftNode != null){

            if(templeftNode.data.equals(data)){
                return true;
            }
            templeftNode = templeftNode.left;
        }
        while (temprightNode != null){

            if(temprightNode.data.equals(data)){
                return true;
            }
            temprightNode = temprightNode.right;
        }


        return false;
    }

    public void remove(T data){
        if (data == null){
            return;
        }
        Node<T> newNode = new Node<T>(data);
        Node<T> templeftNode = root;
        Node<T> temprightNode = root;
        if(data.equals(templeftNode)){
            root = root.right;
        }
        else {
            templeftNode = templeftNode.left;
            temprightNode = temprightNode.right;
            while (templeftNode != null) {

                if (templeftNode.data.equals(data)) {
                    if(templeftNode.left != null) {
                        templeftNode = templeftNode.left;
                    }
                    else {
                        templeftNode = templeftNode.right;

                    }
                }
                templeftNode = templeftNode.left;
            }
            while (temprightNode != null) {

                if (temprightNode.data.equals(data)) {
                    if(temprightNode.right != null) {
                        temprightNode = temprightNode.right;
                    }
                    else {
                        temprightNode = temprightNode.left;

                    }
                }
                temprightNode = temprightNode.right;
            }
        }
    }

    public int size(){
        Node<T> templeftnode = root.left;
        Node<T> temprightnode = root.right;
        int leftsize =0;
        int rightsize =0;
        int totalsize = 0;
        if (root.data.equals(null)){
            return totalsize;
        }
        if (templeftnode == null && temprightnode == null){
            return totalsize + 1;
        }
//        if (templeftnode == null || temprightnode == null){
//            return totalsize + 2;
//        }
        totalsize +=1;
        while(templeftnode != null){
            leftsize++;
            templeftnode = templeftnode.left;
        }
        while(temprightnode !=null){
            rightsize++;
            temprightnode = temprightnode.right;
        }
        System.out.println("left size and right size "+ leftsize +"  " + rightsize);
        totalsize = leftsize + rightsize;
        return totalsize;

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