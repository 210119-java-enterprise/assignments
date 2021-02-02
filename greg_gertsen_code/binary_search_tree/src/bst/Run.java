package bst;

public class Run {

    public static void main(String[] args) {

        BST<Integer> tree = new BST<>();


        tree.insert(23);
        tree.insert(5);
        tree.insert(9);
        tree.insert(12);
        tree.insert(3);
        tree.insert(7);
        tree.insert(19);

        tree.remove(9);
        tree.remove(6);

        System.out.println(tree.contains(5));
        System.out.println(tree.contains(6));
        
        System.out.println(tree.size());






    }
}
