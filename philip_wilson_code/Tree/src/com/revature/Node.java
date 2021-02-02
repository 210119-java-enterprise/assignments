package com.revature;

public class Node<T extends Comparable<T>> {

    public T data;
    public Node<T> left;
    public Node<T> right;
    public int size;


   public Node(){

   }

    public Node(T data) {
        this.data = data;
    }

    public T getValue() {
        return data;
    }

    public void setValue(T data) {
        this.data = data;
    }

    public Node<T> getLeft() {
        return left;
    }

    public void setLeft(Node<T> left) {
        this.left = left;
    }

    public Node<T> getRight() {
        return right;
    }

    public void setRight(Node<T> right) {
        this.right = right;
    }
    public int getSize(){
       return size;
    }

    boolean contains(T value){
        if(value.compareTo(data)==0){
            return true;
        }
        if(left!=null){
            left.contains(value);
        }
        if(right!=null){
            right.contains(value);
        }
        return false;
    }
}