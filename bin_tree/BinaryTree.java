public class BinaryTree<T> {

    private class Node<T> {
        T data;
        Node<T> myLeft, myRight;

        public Node() {
            myLeft = myRight = null;
        }

        public Node(T data) {
            this();
            this.data = data;
        }

        
    }

    private Node<T> headNode;
    private int size;


    public BinaryTree() {
        super();
        headNode = null;
        size = 0;
    }

    /**
     * Takes in data of type T and adds it to the tree
     * If there is a node with data already in the tree, adds new node with same data to it's left
     * @param data
     */
    public void add(T data) {
        if (data == null) {
            return;
        }
        headNode = addRecursive(headNode, data);
    }

    private Node<T> addRecursive(Node<T> current, T data) {
        if (current == null) {
            return new Node<T>(data);
        }

        if (data.hashCode() <= current.data.hashCode()) {
            current.myLeft = addRecursive(current.myLeft, data);
        } else {
            current.myRight = addRecursive(current.myRight, data);
        }

        return current;
    }

    public int getSize() {
        return size;
    }

    public boolean contains(T data) {
        if (size == 0) {
            return false;
        }
        if (data == null) {
            return false;
        }
        return containsRecursive(headNode, data);
    } 

    private boolean containsRecursive(Node<T> current, T data) {
        if (current == null) {
            return false;
        }
        if (data.hashCode() == current.data.hashCode()) {
            return true;
        }
        if (data.hashCode() < current.data.hashCode()) {
            return containsRecursive(current.myLeft, data);
        } else {
            return containsRecursive(current.myRight, data);
        }
    }

    public void remove(T data) {
        if (data == null) {
            return;
        }
        if (size == 0) {
            return;
        }
        removeRecursive(headNode, data);

    }

    private Node<T> removeRecursive(Node<T> current, T data) {
        if (current = null) {
            return null;
        }
        if (data.hashCode() == current.data.hashCode()) {
            // Node has no children
            if (current.myLeft == null && current.myRight == null) {
                size--;
                return null;
            }
            // If node has exactly 1 child
            if (current.myLeft == null) {
                size--;
                return current.myRight;
            }
            if (current.myRight == null) {
                size--;
                return current.myLeft;
            }
            // If node has 2 children
            T largestValue = findLargestValue(current.myLeft);
            current.data = largestValue;
            current.myLeft = deleteRecursive(current.myLeft, largestValue);
            return current;
        }
        if (data.hashCode() < current.data.hashCode()) {
            current.myLeft = removeRecursive(current.myLeft, data);
            return current;
        }
        current.myRight = removeRecursive(current.myRight, data);
        return current;


        return false;
    }

    private T findLargestValue(Node<T> root) {
        return root.myRight == null ? root.data : findLargestValue(root.myRight); 
    }
}