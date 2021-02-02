public class binaryTree <T extends Comparable<T>>{

    private int size;
    private Node<T> root;


    public int size() {
        return size;
    }

    public boolean contains(T data) {
        if(data == null) {
            return false;
        } else {
            return containsNode(root, data);
        }
    }

    private boolean containsNode(Node<T> currNode, T data) {

        if (currNode == null) {
            return false;
        }
        
        if (currNode.data.compareTo(data) > 0) {
            return containsNode(currNode.lNode, data);
        } else if (currNode.data.compareTo(data) < 0) {
            return containsNode(currNode.rNode, data);
        } else{
            return true;
            }
        }

    public void insert(T data) {
        if(data != null) {
            root = insertInto(root, data);
        } else {
            System.out.println("No NULL values allowed");
        }
    }

    private Node<T> insertInto(Node<T> currNode, T data) {

        if (currNode == null) {
            currNode = new Node(data);
            size++;
            return currNode;
        }

        if (data.compareTo(currNode.data) > 0) {
            currNode.lNode = insertInto(currNode.lNode, data);
        } else if (data.compareTo(currNode.data) < 0) {
            currNode.rNode = insertInto(currNode.rNode, data);
        } else {
            return currNode;
        }
        return currNode;
    }

    public void remove(T data){
        root = removeNode(root, data);
        size--;
    }

    private Node<T> removeNode(Node<T> currNode, T data){
        if(currNode == null) {
            return null;
        }
        if(currNode.data.compareTo(data) < 0){
            currNode.rNode = removeNode(currNode.rNode,data);
        }else if(currNode.data.compareTo(data) > 0){
            currNode.lNode = removeNode(currNode.lNode, data);
        }else{
            if(currNode.lNode == null && currNode.rNode == null){
                return null;
            }else if(currNode.lNode == null){
                return currNode.rNode;
            }else if(currNode.rNode == null){
                return currNode.lNode;
            }else{
                T minNode = minNode(currNode.rNode);
                currNode.data = minNode;
                currNode.rNode = removeNode(currNode.rNode, minNode);
            }
        }
        return currNode;
    }

    private T minNode(Node<T> currNode){
        if(currNode.lNode == null){
            return currNode.data;
        }
        return minNode(currNode.lNode);
    }


    private static class Node<T extends Comparable<T>> {

        T data;
        Node<T> lNode;
        Node<T> rNode;

        Node(T data) {

        this.data = data;
        lNode = null;
        rNode = null;
    }

        Node(T data, Node<T> lNode, Node<T> rNode) {

        this.data = data;
        this.lNode = lNode;
        this.rNode = rNode;
        }
    }
}














