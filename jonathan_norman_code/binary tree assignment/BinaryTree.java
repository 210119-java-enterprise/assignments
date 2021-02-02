public class BinaryTree<T> {
    private Node<T> root;
    private Node<T> parentNode; // used for remove
    private Node<T> childNode; // used for remove
    private int size;
    private boolean containsPlaceholder; // assume data isn't in tree until proven otherwise

    public void insert(T data) {
        Node<T> newNode = new Node<>(data);

        if (root == null) {
            root = newNode;
            size++;
        } else {
            insertHelper(root, newNode);
        }
    }

    private void insertHelper(Node<T> walker, Node<T> newNode) {
        if (walker.left == null) {
            walker.left = newNode;
            size++;
        } else {
            insertHelper(walker.left, newNode);
        }
    }

    public void print() {
        printInorder(root);
    }

    private void printInorder(Node<T> walker) {
        if (walker != null) {
            System.out.println(walker.data);
            printInorder(walker.left);
            printInorder(walker.right);
        }
    }

    public int size() {
        return size;
    }

    public boolean contains(T data) {
        containsPlaceholder = false;
        findData(root, data);
        return containsPlaceholder;
    }

    private void findData(Node<T> walker, T data) {
        if (walker != null) {
            if (walker.data == data) {
                containsPlaceholder = true;
                return;
            }
            findData(walker.left, data);
            findData(walker.right, data);
        }
    }

    public void remove(T data) {
        if (root == null) {
            System.out.println("tree is empty");
            return;
        }

        if (root.data == data) {
            root = root.left;
            --size;
        } else {
            childNode = null;  // clear placeholder each time we traverse tree
            parentNode = null;

            removeNode(root, data);

            if (parentNode != null) {
                parentNode.left = childNode;
            }
        }
    }

    private void removeNode(Node<T> walker, T data) {
        if (walker != null) {
            if (walker.data == data) {
                childNode = walker.left;
                --size;
                return;
            } else {
                parentNode = walker;
            }
            removeNode(walker.left, data);
            removeNode(walker.right, data);
        }
    }

    private static class Node<T> {
        Node<T> left;
        Node<T> right;
        T data;

        Node(T data) {
            this.data = data;
        }

        Node(T data, Node<T> left, Node<T> right) {
            this(data);
            this.left = left;
            this.right = right;
        }
    }
}