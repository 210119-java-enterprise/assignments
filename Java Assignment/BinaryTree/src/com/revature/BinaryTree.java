package com.revature;


// Curious on why StackOverflow recommends <? super T> for Comparable's bounded Generic instead of just <T>.
// LOOK UP MORE LATER.
public class BinaryTree<T extends Comparable<? super T>> {

    private Node<T> root;

    public void insert (T data) {

        // Does not take null data.
        if (data == null) {
            System.out.println("Cannot enter null data. Nothing happened.");
        } else {
            root = insertRecursive(root, data);
        }

    }

    private Node<T> insertRecursive (Node<T> currentNode, T data) {

        // We are at a leaf and can insert into a new Node.
        if (currentNode == null)
            return new Node(data);

        // If < 0, data is naturally less than currentNode.data and should be added on the left.
        if (data.compareTo(currentNode.data) < 0) {
            currentNode.leftNode = insertRecursive(currentNode.leftNode, data);

        // If > 0, data is naturally greater than currentNode.data and should be added on the right.
        } else if (data.compareTo(currentNode.data) > 0) {
            currentNode.rightNode = insertRecursive(currentNode.rightNode, data);
        }

        return currentNode;
    }

    public boolean contains (T data) {
        return containsRecursive(root, data);
    }

    private boolean containsRecursive (Node<T> currentNode, T data) {

        if (currentNode == null) {
            return false;
        }

        if(data.equals(currentNode.data)) {
            return true;
        }

        // Compare data and currentNode.data. If < 0, check left. If > 0 check right.
        return data.compareTo(currentNode.data) < 0 ? containsRecursive(currentNode.leftNode, data) :
                                                      containsRecursive(currentNode.rightNode, data);
    }

    public void remove (T data) {
        root = removeRecursive(root, data);
    }

    private Node<T> removeRecursive (Node<T> currentNode, T data) {

        if (currentNode == null)
            return null;

        if (data == currentNode.data) {
            // Node has no children. Just delete.
            if (currentNode.leftNode == null && currentNode.rightNode == null) {
                return null;
            }
            // Node has 1 child. Return the child node that exists.
            if (currentNode.rightNode == null) {
                return currentNode.leftNode;
            }
            if (currentNode.leftNode == null) {
                return currentNode.rightNode;
            }
            // Node has two children. Assign the smallest value on the right subtree to the Node.
            T smallest = findSmallestRight(currentNode.rightNode);
            currentNode.data = smallest;
            currentNode.rightNode = removeRecursive(currentNode.rightNode, smallest);
            return currentNode;
        }
        if (data.compareTo(currentNode.data) < 0) {
            currentNode.leftNode = removeRecursive(currentNode.leftNode, data);
        }
        currentNode.rightNode = removeRecursive(currentNode.rightNode, data);
        return currentNode;
    }

    // Returns the smallest T in the right subtree. Note: root is the first node in the right subtree.
    private T findSmallestRight (Node<T> root) {
        return root.leftNode == null ? root.data : findSmallestRight(root.leftNode);
    }

    public int size () {
        return size(root);
    }

    private int size (Node<T> root) {

        // Empty tree.
        if (root == null) {
            return 0;
        }
        else {
            // returns the size of the left subtree + root node (1) + size of the right subtree.
            return (size(root.leftNode) + 1 + size(root.rightNode));
        }
    }

    public Node<T> getRoot() {
        return root;
    }


    // BONUSES
    // In order of smallest T to largest T (left, root, right).
    public void inOrder(Node<T> node) {

        // if there is a tree.
        if (node != null) {

            // recursive call to left subtree.
            inOrder(node.leftNode);

            // print root.
            System.out.print(node.data + " ");

            // recursive call to right subtree.
            inOrder(node.rightNode);
        }
    }

    // Pre order : root, left, right
    public void preOrder (Node<T> node) {

        if (node != null) {

            // root
            System.out.print(node.data + " ");

            // left
            preOrder(node.leftNode);

            // right
            preOrder(node.rightNode);
        }
    }

    // Post order : left, right, root
    public void postOrder(Node<T> node) {

        if (node != null) {

            // left
            postOrder(node.leftNode);

            // right
            postOrder(node.rightNode);

            // root
            System.out.print(node.data + " ");
        }

    }

    private static class Node<T> {
        T data;
        Node<T> leftNode;
        Node<T> rightNode;

        Node (T data) {
            this.data = data;
            leftNode = null;
            rightNode = null;
        }

        Node (T data, Node<T> leftNode, Node<T> rightNode) {
            this.data = data;
            this.leftNode = leftNode;
            this.rightNode = rightNode;
        }
    }

}
