package com.revature.util;

import com.sun.javafx.scene.control.skin.VirtualFlow;

import java.util.LinkedList;

public class BinaryTree <T extends Comparable<T>>{
/*
Challenge: Implement a custom binary-tree structure with the following functionalities:
void insert(T data)
boolean contains(T data)
remove(T data)  (removes the first occurrence)
size() (gives the number of nodes stored in the tree)
 */

    private int size;
    private Node<T> root;


    public void insert(T data){
        if(data==null){return;}
        if (root==null){

            root=new Node(data);
            System.out.println("set root "+root.data);
            return;
        }
        boolean traversing=true;
        Node<T> cursor=root;
        while(traversing) {

            if (cursor.data.compareTo(data) < 0) {//go right
                if (cursor.rChild != null) {
                    System.out.print("r-");
                    cursor = cursor.rChild;
                } else {

                    cursor.rChild = new Node(data);
                    System.out.println("rSet-"+cursor.rChild.data);
                    size++;
                    traversing=false;
                }

            } else {//go left
                if (cursor.lChild!=null) {
                    System.out.print("l-");
                    cursor = cursor.lChild;
                } else {

                    cursor.lChild = new Node(data);
                    System.out.println("lSet-"+cursor.lChild.data);
                    size++;
                    traversing=false;
                }
            }
        }
    }


    public boolean contains(T data){

        return DFS(root,data)!=null;
    }



    public void printTree(Node root, int space){
        if (root == null) return;
        space += 10;

        printTree(root.rChild, space);

        System.out.print("\n");
        for (int i = 10; i < space; i++) { System.out.print(" "); }
        System.out.println(root.data.toString());

        printTree(root.lChild, space);
    }


    public Node<T> DFS(Node<T> cursor, T data){

        if(cursor==null){return null;}

        if(cursor.data.compareTo(data)==0){
            return cursor;
        }

        Node<T> l=DFS(cursor.lChild, data);
        if(l!=null){return l;}

        return DFS(cursor.rChild, data);
    }


    public void remove(T data){
        delete(root, data);

    }

    private Node<T> delete(Node<T> root, T data){

        if (root == null){return null;}
        if (root.data.compareTo(data) > 0)  {// left
            root.lChild = delete(root.lChild, data);
        } else if (root.data.compareTo(data) < 0) {// right
            root.rChild = delete(root.rChild, data);

        } else {//at correct node
            if (root.lChild != null && root.rChild != null) {//has 2 children
                Node<T> temp = root;
                Node<T> temp2 = leftMost(temp.rChild);//go right then find leftmost
                root.data = temp2.data;
                root.rChild = delete(root.rChild, temp2.data);

            }
            else if (root.lChild != null) {// only lChild
                root = root.lChild;
            }
            else if (root.rChild != null) {//only rChild
                root = root.rChild;
            }
            else
                root = null;
        }
        return root;
    }



    public Node<T> leftMost(Node<T> root) {
        if (root.lChild == null)
            return root;
        else {
            return leftMost(root.lChild);
        }
    }




    private void inorder(Node<T> root) {
        if (root != null) {
            inorder(root.lChild);
            System.out.println(root.data);
            inorder(root.rChild);
        }
    }


    public int size(){
        return size;
    }

    public Node<T> getRoot(){
        return root;
    }



}


    class Node<T> {
        T data;
        Node<T> lChild;
        Node<T> rChild;

        Node(T data) {
            this.data = data;
        }

        Node(T data, Node<T> lChild, Node<T> rChild) {
            this(data);
            this.lChild = lChild;
            this.rChild = rChild;
        }
    }


