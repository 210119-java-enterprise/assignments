package com.revature;

import com.revature.util.BinaryTree;

public class Driver {
    public static void main(String[] args) {

        BinaryTree tree = new BinaryTree();

        tree.insert(1);
        tree.insert(12);
        tree.insert(5);
        tree.insert(131);
        tree.insert(12);
        tree.insert(8);
        tree.insert(7);
        tree.insert(7);

//        tree.size();
//
//        if(tree.contains(8))
//        {
//            System.out.println("true");
//        }else
//        {
//            System.out.println("false");
//        }

        tree.remove(1);

        tree.inOrder();
    }
}
