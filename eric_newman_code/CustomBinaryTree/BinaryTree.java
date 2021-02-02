package com.revature.util;

import java.util.Stack;

public class BinaryTree<T extends Comparable> {

    Node root;

    private static class Node<T>
    {
        T data;
        Node<T> left, right;

        public Node(T data)
        {
            this.data = data;
            this.left = this.right = null;
        }

        public Node(T data, Node<T> nodeLeft, Node<T> nodeRight)
        {
            this.data = data;
            this.left = nodeLeft;
            this.right = nodeRight;
        }

    }

    public BinaryTree()
    {
        root = null;
    }


    public void insert (T data) {
        root = insert(data, root);
    }

    //recursive insert function
    private Node<T> insert(T data, Node<T> sRoot)
    {
        if (sRoot == null) {
            return new Node<T>(data);
        }
        if (data.compareTo(sRoot.data) < 0) {
            sRoot.left = insert(data, sRoot.left);
        } else if (data.compareTo(sRoot.data) > 0) {
            sRoot.right = insert(data, sRoot.right);
        } else {
            //do nothing if equal?
        }
        return sRoot;
    }

    // Depth first Print
    void inOrderPrint(Node<T> root)
    {
        if (root != null) {
            //runs through left side sub trees then back up through the right side of the sub trees hit
            inOrderPrint(root.left);
            //once hits bottom it will begin breaking calls backwards, printing the left most node,
            // and then calling the inOrderPrint for the right side of the sub tree
            System.out.println(root.data);
            //hits right side on way back up recursion
            inOrderPrint(root.right);
        }
    }

    //non recursive contains implementation
    boolean contains(T data) {
        boolean found = false;
        Stack<Node> stack = new Stack<Node>();
        Node<T> current = root;
        stack.push(root);
        while(! stack.isEmpty() && found == false) {
            //while loop digs us down to the bottommost left subtree
            while(current.left != null) {
                current = current.left;
                stack.push(current);
            }
            current = stack.pop(); //pulls left bottom node first time thru - goes back to the node previous next cycle
            if (current.data.equals(data)) {
                found = true; //found what we are looking for break loop stop search
            }
            //else we didnt find it on the left side so we back up to the right node as current
            if(current.right != null) {
                current = current.right;
                stack.push(current);
            }
        }
        return found;
    }

    //gets data from bottom left node in current subtree
    private T leftChild(Node<T> curr)
    {
        if (curr.left != null) {
            return leftChild(curr.left);
        }
        return curr.data;
    }

    private Node<T> delete(T data, Node<T> sRoot) {
        if (sRoot == null) {
            return sRoot;
        }
        //reccursive calls happen at the top for the most part allowing us to push the
        // root down to the subtree we are inspecting for deletion
        if (data.compareTo(sRoot.data) < 0) {
            sRoot.left = delete(data, sRoot.left);
        } else if (data.compareTo(sRoot.data) > 0) {
            sRoot.right = delete(data, sRoot.right);
        } else {
            //found removal
            //easy case just sitting without any children
            if (sRoot.left == null && sRoot.right == null) {
                return null;
            } else if (sRoot.left == null) {
                return sRoot.right;
            } else if (sRoot.right == null) {
                return sRoot.left;
            } else {
                T smallData = leftChild(sRoot.right);
                sRoot.data = smallData;
                sRoot.right = delete(smallData, sRoot.right);
            }
        }
        return sRoot;
    }

    void remove(T data) {
        root = delete(data, root);
    }

    int size()
    {
        return size(root);
    }

    // recursive size counter - counts each node and calls to its two children to see if it needs to add more
    // if the children do not exist it simply adds a 0 in place of them so our count stays accurate on the leaves
    int size(Node node)
    {
        if (node == null)
            return 0;
        else
            return(size(node.left) + 1 + size(node.right));
    }

    public static void main(String[] args)
    {
        BinaryTree tree = new BinaryTree();
        tree.insert(50);
        tree.insert(30);
        tree.insert(20);
        System.out.println("tree size after 3: " + tree.size());
        tree.insert(40);
        tree.insert(70);
        tree.insert(60);
        tree.insert(80);
        System.out.println("tree size after 7: " + tree.size());
        System.out.println("Tree list after insertions: ");
        tree.inOrderPrint(tree.root);
        tree.remove(50);
        System.out.println("tree size after removing 1: " + tree.size());
        System.out.println("does tree contain 50 after removal? " + tree.contains(50));
        System.out.println("does tree contain 81 never inserted? " + tree.contains(81));
        System.out.println("does tree contain 80 as it should? " + tree.contains(80));
        System.out.println("tree size: " + tree.size());
        tree.inOrderPrint(tree.root);
    }
}
