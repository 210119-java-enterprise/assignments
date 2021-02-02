package com.revature;


 class BinaryTree< T extends Comparable<T>> {

    Node<T> node=new Node<>();
    Node<T> root;



    public void insert(T value) {
        if(root==null)
            root = new Node(value);
        else
            insert(root, value);
    }

    public void insert(Node<T> node, T value) {

        if(value.compareTo(node.getValue()) < 0) {
            if(node.getLeft() == null)
                node.left = new Node<T>(value);
            else
                insert(node.getLeft(), value);
        }
        else {
            if(node.getRight() == null)
                node.right = new Node<T>(value);
            else
                insert(node.getRight(), value);
        }
    }


    boolean contains(T value){
        if(root==null){
            return false;
        }
        return root.contains( value);
    }



    public void remove(T value){
        root=remove(root,value);
    }
    public Node<T> remove(Node<T> node,T value){
       while(node!=null){
           int compare= value.compareTo(node.getValue());
           if(compare<0){
               node.left=remove(node.left,value);
           }
           if(compare>0){
               node.right=remove(node.right,value);

           }
       }
       return null;
    }

    public int size(){
        return size(root);
    }

     int size(Node<T> node)
     {
         if (node == null)
             return 0;
         else
             return(size(node.left) + 1 + size(node.right));
     }

}

