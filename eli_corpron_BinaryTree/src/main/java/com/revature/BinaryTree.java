package com.revature;

/**
 * Binary tree implementation.
 */
public class BinaryTree<T extends Comparable<? super T>> {

    private int size;
    private Node<T> root;

    public BinaryTree() {
        size = 0;
    }

    private static class Node<T extends Comparable<? super T>> {
        T data;
        Node<T> parent;
        Node<T> leftChild;
        Node<T> rightChild;

        public Node(T data) {
            this.data = data;
        }

        public Node(T data, Node<T> left, Node<T> right) {
            this(data);
            leftChild = left;
            rightChild = right;
        }

        public boolean isLeaf() {
            return(leftChild == null && rightChild == null);
        }
    }

    // Don't allow null values to be inserted
    public void insert(T data) {
        if (data == null) {
            return;
        }

        Node<T> newNode = new Node<T>(data);

        // if there is no root, new node is root
        if (root == null) {
            root = newNode;
            size++;
            return;
        }

        Node<T> currentNode = root;

        // probably a cleaner way of implementing
        while (currentNode != null) {
            // if the data at current node is smaller, the data goes to the right
            if (currentNode.data.compareTo(newNode.data) <= 0) {
                if (currentNode.rightChild == null) {
                    currentNode.rightChild = newNode;
                    size++;
                    break;
                } else {
                    currentNode = currentNode.rightChild;
                }
            } else { //else the data goes to the left
                if (currentNode.leftChild == null) {
                    currentNode.leftChild = newNode;
                    size++;
                    break;
                } else {
                    currentNode = currentNode.leftChild;
                }
            }
        }



    }

    public boolean contains(T data) {
        if (data == null) return false;

        Node<T> currentNode = root;

        while (currentNode != null) {
            int comparison = data.compareTo(currentNode.data);

            if (comparison == 0) {
                return true;
            }

            if (comparison > 0) {
                currentNode = currentNode.rightChild;
            } else {
                currentNode = currentNode.leftChild;
            }
        }

        return false;
    }

    public void remove(T data) {
        if (data == null) return;

        Node<T> currentNode = root;

        while (currentNode != null) {
            int comparison = data.compareTo(currentNode.data);

            if (comparison == 0) {
                shift(currentNode);
                size--;
                return;
            }
            if (comparison > 0) {
                currentNode = currentNode.rightChild;
            } else {
                currentNode = currentNode.leftChild;
            }
        }
    }

    //shifts to correct removing a node. If a node has two children, 'slide' right child up, make next node right child,
    // if node has 1 child, slide child up, make child next node. If node has no child, return.
    public void shift(Node<T> currentNode) {
        while (currentNode != null) {
            // If the current node has a right child, pull that right value into the current node, then move to right
            // child as long as the right child is not a leaf
            if (currentNode.rightChild != null) {
                currentNode.data = currentNode.rightChild.data;

                if (!currentNode.rightChild.isLeaf()) {
                    currentNode = currentNode.rightChild;
                } else { //If the right child is a leaf, pull data then forget right child
                    currentNode.rightChild = null;
                    return;
                }
            } else { // else if the node has a left child, then pull up that data, and traverse into the left child
                if (currentNode.leftChild != null) {
                    currentNode.data = currentNode.leftChild.data;

                    if (!currentNode.leftChild.isLeaf()) {
                        currentNode = currentNode.leftChild;
                    } else {
                        currentNode.leftChild = null;
                        return;
                    }
                } else { //otherwise the current node has no children, so we need to remove it
                    currentNode = null;
                }
            }
        }
    }

    public int size() {
        return size;
    }

    public void printTree() {
        System.out.println(root.data.toString());
        printLoop(root);
        System.out.println("\n");
    }

    private void printLoop(Node<T> currentNode) {
        System.out.println("|  \\");
        if (currentNode.leftChild != null) {
            System.out.print(currentNode.leftChild.data.toString());
        }
        if (currentNode.rightChild != null) {
            System.out.println("    "+currentNode.rightChild.data.toString());
        }

        if (currentNode.leftChild != null && !currentNode.leftChild.isLeaf()) {
            printLoop(currentNode.leftChild);
        }
        if (currentNode.rightChild != null && !currentNode.rightChild.isLeaf()) {
            printLoop(currentNode.rightChild);
        }
    }

}
