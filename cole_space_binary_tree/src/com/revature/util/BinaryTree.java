package com.revature.util;

public class BinaryTree<T extends Comparable<T>> {

    private int size;
    private Node<T> root;

    public void insert(T data){
        if(data == null) return;
        root = recursiveInsert(root, data);
    }

    private Node<T> recursiveInsert(Node<T> currentNode, T data){
        //increment size
        if(currentNode == null){
            currentNode = new Node<>(data);
            size++;
            return currentNode;
        }

        if(currentNode.data.compareTo(data) > 0){
            currentNode.left = recursiveInsert(currentNode.left, data);
        }else if(currentNode.data.compareTo(data) < 0){
            currentNode.right = recursiveInsert(currentNode.right, data);
        }else{
            return currentNode;
        }

        return currentNode;
    }

    public boolean contains(T data){
        if(data == null) return false;
        return recursiveContains(root, data);
    }

    private boolean recursiveContains(Node<T> current, T data){
        if(current == null){
            return false;
        }

        if(current.data.compareTo(data) > 0){
            return recursiveContains(current.left, data);
        }else if(current.data.compareTo(data) < 0){
            return recursiveContains(current.right, data);
        }else{
            return true;
        }

    }

    public void remove(T data){
        //decrement size
        root = recursiveRemove(root, data);
    }

    private Node<T> recursiveRemove(Node<T> current, T data){
        if(current == null) return null;

        if(current.data.compareTo(data) < 0){
            current.right = recursiveRemove(current.right,data);
        }else if(current.data.compareTo(data) > 0){
            current.left = recursiveRemove(current.left, data);
        }else{
            size--;
            //remove, 3 scenarios
            if(current.left == null && current.right == null){
                //no children
                return null;
            }else if(current.left == null){
                //1 child exists
                return current.right;
            }else if(current.right == null){
                //1 child exists
                return current.left;
            }else{
                //2 children exist, must choose which child to replace
                //Let's keep the left tree intact, replacing the deleted node with modified right subtree
                T smallestValue = smallestValue(current.right);
                current.data = smallestValue;
                current.right = recursiveRemove(current.right, smallestValue);
            }

        }
        return current;
    }

    private T smallestValue(Node<T> current){
        if(current.left == null){
            return current.data;
        }
        return smallestValue(current.left);
    }

    public int size(){
        return size;
    }

    public void printLeaves(){
        inOrderPrint(root);
        System.out.println();
    }

    private void inOrderPrint(Node<T> current){
        if(current == null){
            return;
        }
        inOrderPrint(current.left);
        System.out.print(current.data.toString() + ", ");
        inOrderPrint(current.right);
    }

    private static class Node<T extends Comparable<T>>{

        T data;
        Node<T> left;
        Node<T> right;

        Node(T data){
            this.data = data;
            left = null;
            right = null;
        }

        Node(T data, Node<T> left, Node<T> right){
            this.data = data;
            this.left = left;
            this.right = right;
        }
    }
}
