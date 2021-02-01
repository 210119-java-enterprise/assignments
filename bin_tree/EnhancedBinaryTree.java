public class EnhancedBinaryTree<T> {

    private class Node<T> {
        T data;
        Node<T> myLeft, myRight;
        int count;

        public Node() {
            myLeft = myRight = null;
        }

        public Node(T data) {
            this();
            this.data = data;
            count = 1;
        }

        
    }

    private Node<T> headNode;
    private int size;


    public EnhancedBinaryTree() {
        super();
        headNode = null;
        size = 0;
    }

    /**
     * Takes in data of type T and adds it to the tree
     * If there is a node with data already in the tree, increases count on that node by 1
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
            size++;
            return new Node<T>(data);
        }


        if (data.hashCode() < current.data.hashCode()) {
            current.myLeft = addRecursive(current.myLeft, data);
        } else if (data.hashCode() > current.data.hashCode()) {
            current.myRight = addRecursive(current.myRight, data);
        } else {
            current.count++;
            size++;
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
        // data is not in tree
        if (current == null) {
            return null;
        }
        if (data.hashCode() == current.data.hashCode()) {
            if (current.count > 1) {
                current.count--;
                size--;
                return current;
            }
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
            current.myLeft = removeRecursive(current.myLeft, largestValue);
            return current;
        }
        if (data.hashCode() < current.data.hashCode()) {
            current.myLeft = removeRecursive(current.myLeft, data);
            return current;
        }
        current.myRight = removeRecursive(current.myRight, data);
        return current;
    }

    private T findLargestValue(Node<T> root) {
        return root.myRight == null ? root.data : findLargestValue(root.myRight); 
    }
}