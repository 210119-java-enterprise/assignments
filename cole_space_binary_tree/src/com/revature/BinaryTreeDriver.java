package com.revature;

import com.revature.util.BinaryTree;

public class BinaryTreeDriver {

    public static void main(String[] args){
        BinaryTree<Integer> ents = new BinaryTree<>();

        ents.insert(9);
        ents.insert(13);
        ents.insert(5);
        ents.insert(11);
        ents.insert(12);
        ents.insert(15);
        ents.insert(5);
        ents.printLeaves();
        System.out.println(ents.size());
        System.out.println("+-----------------------+");
        System.out.println(ents.contains(13));
        System.out.println(ents.contains(0));
        System.out.println("+-----------------------+");
        ents.remove(11);
        ents.printLeaves();
        System.out.println(ents.size());
        System.out.println("+-----------------------+");
        ents.insert(11);
        ents.printLeaves();
        System.out.println("+-----------------------+");
    }
}
