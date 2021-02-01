package com.revature.util;

public class BinaryTree <T extends Comparable<? super T>> {

    private Node<T> root;
    private Node<T> temp;
    private Node<T> parent;
    int size = 0;


    public void insert(T data) {
        boolean inserting = true;
        if (data == null) {
            return;
        }
        if (root == null) {
            root = new Node<>(data);
            size++;
            return;
        }

        Node<T> newNode = new Node<>(data);

        temp = root;

        while (inserting) {
            parent = temp;
            if (data.compareTo(temp.data) < 0) {
                temp = temp.leftNode;
                if (temp == null) {
                    parent.leftNode = newNode;
                    inserting = false;
                }
            } else {
                temp = temp.rightNode;
                if (temp == null) {
                    parent.rightNode = newNode;
                    inserting = false;
                }
            }

        }


        size++;

    }

    public void remove(T data)
    {
        root = removeRecursive(root, data);
    }

    private Node<T> removeRecursive(Node<T> currentNode, T data)
    {
        if (data == currentNode.data) {
            // Node has no children
            if (currentNode.leftNode == null && currentNode.rightNode == null) {
                return null;
            }
            // Node has 1 child
            if (currentNode.rightNode == null) {
                return currentNode.leftNode;
            }
            if (currentNode.leftNode == null) {
                return currentNode.rightNode;
            }
            // Node has two children
            T small = findSmallestRight(currentNode.rightNode);
            currentNode.data = small;
            currentNode.rightNode = removeRecursive(currentNode.rightNode, small);
            return currentNode;
        }
        if (data.compareTo(currentNode.data) < 0) {
            currentNode.leftNode = removeRecursive(currentNode.leftNode, data);
        }else{
            currentNode.rightNode = removeRecursive(currentNode.rightNode, data);
        }
        return currentNode;
    }

    private T findSmallestRight(Node<T> root)
    {
        return root.leftNode == null ? root.data : findSmallestRight(root.leftNode);
    }

    public boolean contains(T data) {

        temp = root;

        while(!temp.data.equals(data))
        {
            if(data.compareTo(temp.data) < 0)
            {
                temp = temp.leftNode;
            }else {
                temp = temp.rightNode;
            }
            if(temp == null)
            {
                return false;
            }
        }

        return true;

    }


   private void traverseInorder(Node<T> node) {
        if (node != null) {
            traverseInorder(node.leftNode);
            System.out.println(" " + node.data);
            traverseInorder(node.rightNode);
        }
    }

    public void inOrder() {
        traverseInorder(root);
    }

    public void size() {
        System.out.println(this.size);
    }

    private static class Node<T> {
        T data;
        Node<T> leftNode;
        Node<T> rightNode;

        Node(T data) {
            this.data = data;
            this.leftNode = null;
            this.rightNode = null;
        }
    }

}