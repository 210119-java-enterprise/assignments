package com.revature;

public class BinaryTree<T extends Comparable<T>> {
    Node<T> root;

//    public BinaryTree(){
//        root = null;
//    }
    // constructor will initialize the root
    public BinaryTree(T key){
        root = new Node<T>(key);
    }

    // put the data left of the root if empty
    // put it to the right if left if not null
    // and after put in right change root node
    public void insert(T data){
        Node<T> tempRoot = root;
        if(tempRoot == null){
            System.out.println("Check 1");
            tempRoot = new Node<T>(data);
        }
        else if(tempRoot.leftNode == null){
            System.out.println("check 2");

            tempRoot.leftNode = new Node<T>(data);
        }
        else if(tempRoot.rightNode == null){
            System.out.println("check 3");

            tempRoot.rightNode = new Node<T>(data);
            //tempRoot = root.leftNode;
        }
    }

    public boolean contains (T data){
        Node<T> tempRoot = root;

        return contains(tempRoot,data);
    }

    boolean contains( Node<T> node, T data){
        if(node == null){
            return false;
        }
        if(node.data == data){
            return true;
        }
        else if(node == null){
            // if you didnt find the data and the children are null
            if(node.leftNode == null && node.rightNode == null){
                return false;
            }
        }
        // if the data does not equal current nodes data but there is a child
        return (contains(node.leftNode,data) || contains(node.rightNode,data));
    }


    public void remove(T data){
        if(root != null && root.data == data){
            root.data = null;
        }
    }
    public boolean findNode(){
        return false;
    }

    public int size(){

        return size(root);
    }

        // method that helps me go through this recursivly
    int size(Node<T> node){

        if(node == null) return 0;

        return(size(node.leftNode) + size(node.rightNode) + 1);
    }

    // class for a single node
    private static class Node<T> {
        T data;
        Node<T> leftNode;
        Node<T> rightNode;

        public Node(T data){
            // initialize with data passed in.
            // the children will initialize as null
            this.data = data;
            leftNode = rightNode = null;
        }

    }
}


