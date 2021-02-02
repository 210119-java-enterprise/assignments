package com.revature;

import com.revature.util.AppState;
import com.revature.util.BinaryTree;

public class Decrypter {

        private static AppState app = new AppState();

        public static void main(String[] args){

//                while (app.isAppRunning()){
//                        app.getRouter().navigate("/home");
//                }
                //test for binary tree
                BinaryTree<Integer> bTree = new BinaryTree<>();
                bTree.insert(1);
                bTree.insert(2);
                bTree.insert(3);
                bTree.insert(9);
                bTree.printTree(bTree.root,"");
                System.out.println("\n");
                bTree.insert(8);
                bTree.printTree(bTree.root,"");
                System.out.println("current size " + bTree.size());
                System.out.println("Tree min: " + bTree.min(bTree.root));
                System.out.println("Tree max: " + bTree.max(bTree.root));
                System.out.println("removed 9: ");
                bTree.remove(9);
                System.out.println("Does it contain 2: "+ bTree.constains(2));
                bTree.printTree(bTree.root,"");
                System.out.println("current size: " + bTree.size());
        }

        public static AppState app() {
                return app;
        }
}
