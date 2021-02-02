package com.revature;

public class Driver {

    public static void main(String [] args) {

        BinaryTree myTree = new BinaryTree();

        for(int i = 50; i <= 100; i++)
        {
            myTree.insert(i);
            System.out.println("Added to myTree, value: " + i);
            System.out.println("Size of tree" + myTree.size());
        }

        for(int i = 50; i>0; i--){
            myTree.insert(i);
            System.out.println("Added to myTree, value: " + i);
            System.out.println("Size of tree" + myTree.size());
        }

        myTree.remove(75);
        System.out.println("Removed 75");
        System.out.println("Size of tree" + myTree.size());
        myTree.remove(35);
        System.out.println("Removed 35");
        System.out.println("Size of tree" + myTree.size());

        System.out.println("75 in is in the tree: " + myTree.contains(75));
        System.out.println("35 is in the tree " + myTree.contains(35));

    }
}
