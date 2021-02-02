package com.revature;

import com.revature.util.BinaryTree;

public class Driver {
    public static void main(String[] args){

        BinaryTree<Integer> bt= new BinaryTree();
        bt.insert(38);
        bt.insert(35);
        bt.insert(43);
        bt.insert(87);
        bt.insert(92);
        bt.insert(61);
        bt.insert(12);

        bt.printTree(bt.getRoot(),1);
        System.out.println("contains: 12: "+bt.contains(12)+"--T");
        System.out.println("contains: 86: "+bt.contains(86)+"--F");
        System.out.println("contains: 87: "+bt.contains(87)+"--T");
        bt.remove(38);
        bt.printTree(bt.getRoot(),1);


    }
}
