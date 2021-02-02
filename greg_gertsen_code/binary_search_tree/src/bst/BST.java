package bst;

/*
Implement a custom binary-tree structure with the following functionalities:
void insert(T data)
boolean contains(T data)
remove(T data)  (removes the first occurrence)
size() (gives the number of nodes stored in the tree)
 */

public class BST<T extends Comparable<T>> {

    int size;
    Node<T> root;

    public void insert(T value){
        root = insertionHelper(root, value);
    }

    public Node<T> insertionHelper(Node<T> root, T value) {

        if (root == null){
            size++;
            return new Node<T>(value);
        }
        if (value.compareTo(root.data)<0) {
            root.left = insertionHelper(root.left, value);
        } else if (value.compareTo(root.data)>0) {
            root.right = insertionHelper(root.right, value);
        }
        return root;
    }

    public int size(){
        return size;
    }

    public boolean contains(T value) {

        Node<T> helper;
        helper = root;

        while (helper != null) {
            if (helper.data == value)
                return true;
            if (value.compareTo(helper.data)<0)
                helper = helper.left;
            else
                helper = helper.right;
        }
        return false;
    }

    /*
    Removes first occurence
     */
    public void remove(T data){

        root = removeHelper(root, data);
    }

    private Node<T> removeHelper(Node<T> current, T value) {
        if (current == null) {
            size--;
            return null;
        }
        if (value == current.data) {
            if (current.left == null && current.right == null) {
                size--;
                return null;
            }
            if (current.right == null) {
                size--;
                return current.left;
            }
            if (current.left == null) {
                size--;
                return current.right;
            }
        }
        if (value.compareTo(current.data)<0) {
            current.left = removeHelper(current.left, value);
            return current;
        }
        current.right = removeHelper(current.right, value);
        return current;
    }



    static class Node<T extends Comparable<T>>{

        T data;
        Node<T> left;
        Node<T> right;

        public Node(){
            super();
        }

        Node(T data) {
            this.data = data;
        }

        Node(T data, Node<T> left, Node<T> right) {
            this(data);
            this.left = left;
            this.right = right;
        }

        @Override
        public String toString() {
            return "Node{" +
                    "data=" + data +
                    '}';
        }
    }



}
