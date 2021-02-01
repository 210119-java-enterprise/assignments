package BinaryTree;

/*
   -Does not accepts duplicates or nulls
   -Has several instances of a searching while loop, could potentially refactor to reduce code duplication
*/
public class BinaryTree <T extends Comparable<? super T>> {

    private Node root;
    private int size;

    public BinaryTree() {
        size = 0;
        root = null;
    }

    public Node getRoot() {
        return root;
    }

    void insert(T data){
        if (data == null) return;
        Node newNode = new Node(data);

        if (root == null){
            root = newNode;
            size++;
        }else{
            int compareVal = 0;
            Node cur, prev;
            cur = prev = root;

            while (cur != null){
                //Save parent
                prev = cur;
                compareVal = data.compareTo((T)cur.data);

                if (0 > compareVal){
                    cur = cur.leftChild;
                }else if (0 < compareVal){
                    cur = cur.rightChild;
                }else{
                    return;//duplicate data can be changed to accept duplicates
                }
            }
            //cur == null, prev = leaf
            if (0 > compareVal)
                prev.leftChild = newNode;
            else
                prev.rightChild = newNode;
            size++;
        }
    }

    boolean contains(T data){
        //Initial conditionals
        if (data == null) return false;
        if (root == null)return false;

        int compareVal;
        Node cur;
        cur = root;

        while (cur != null){
            compareVal = data.compareTo((T)cur.data);

            if (0 > compareVal)
                cur = cur.leftChild;
            else if (0 < compareVal)
                cur = cur.rightChild;
            else
                return true;//found match
        }
        //element not found
        return false;
    }

    void remove (T data){
        //Initial conditions
        if (data == null) return;
        if (root == null) return;

        int compareVal = 0;
        Node cur, prev, left, right;
        cur = prev = root;

        while (cur != null){
            compareVal = data.compareTo((T)cur.data);

            if (0 > compareVal){
                prev = cur;
                cur = cur.leftChild;
            }else if (0 < compareVal){
                prev = cur;
                cur = cur.rightChild;
            }else{
                //data to be removed found
                //save subtrees
                left = cur.leftChild;
                right = cur.rightChild;
                //remove reference
                T curData = (T) cur.data;
                if (0 > curData.compareTo((T)prev.data))
                    prev.leftChild = null;
                else
                    prev.rightChild = null;

                //re-insert children
                //I know there are rotations available but since it was just a basic
                //binary tree re-inserting the subtree felt lazy but functional.
                if (left != null)
                    reinsertSubTree(left);
                if (right != null)
                    reinsertSubTree(right);
                size--;
                break;
            }
        }
    }

    private void reinsertSubTree(Node <T> subRoot){
        if (root == null) return;
        int compareVal = 0;
        Node cur, prev;
        cur = prev = this.root;

        while (cur != null){
            //Save parent
            T subRootData = (T)subRoot.data;
            compareVal = subRootData.compareTo((T)cur.data);

            if (0 > compareVal){
                prev = cur;
                cur = cur.leftChild;
            }else if (0 < compareVal){
                prev = cur;
                cur = cur.rightChild;
            }
        }
        //cur == null, prev = leaf
        if (0 > compareVal)
            prev.leftChild = subRoot;
        else
            prev.rightChild = subRoot;
    }

    public T findMin(){
        if (root == null) return null;
        Node cur, prev;
        cur = prev = root;

        while (cur.leftChild != null) {
            //Save parent
            prev = cur;
            cur = cur.leftChild;
        }

        return (T)cur.data;
    }

    int getSize (){
        return size;
    }

    void printTree(Node root, int space){
        //Fun function to visualize binary tree in print out
        //GeeksforGeeks
        if (root == null) return;
        space += 10;
        //Process right
        printTree(root.rightChild, space);
        //Print space
        System.out.print("\n");
        for (int i = 10; i < space; i++)
            System.out.print(" ");
        System.out.println(root.data.toString());
        //Process left
        printTree(root.leftChild, space);
    }

    //private node class holding generic
    private static class Node <T> {

        T data;
        Node<T> leftChild;
        Node<T> rightChild;

        public Node(T data){
            this.data = data;
        }

        public Node(T data, Node<T> leftChild, Node<T> rightChild) {
            this.data = data;
            this.leftChild = leftChild;
            this.rightChild = rightChild;
        }

    }
}
