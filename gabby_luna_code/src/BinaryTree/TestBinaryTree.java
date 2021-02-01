package BinaryTree;

public class TestBinaryTree {
    public static void main(String[] args) {
        int[] rand_vals = {62, 4, 65, 29, 4, 38, 86, 65, 54, 82, 60, 58, 53, 51, 87, 4, 90, 20};
        BinaryTree tree = new BinaryTree();

        for (int i : rand_vals)
            tree.insert(i);

        System.out.print("Insert: vals array, size: " + tree.getSize() + ", printout: \n");
        tree.printTree(tree.getRoot(), 0);

        System.out.println("Min value: " + tree.findMin().toString() + "\n");
        tree.remove(4);
        System.out.print("Remove: 4, size: " + tree.getSize() + ", printout: \n");
        tree.printTree(tree.getRoot(), 0);


        System.out.println("Min value: " + tree.findMin().toString() + "\n");
        tree.remove(54);
        System.out.print("Remove: 54, size: " + tree.getSize() + ", printout: \n");
        tree.printTree(tree.getRoot(), 0);

        System.out.println("contains 90 : " + tree.contains(90));
        tree.remove(90);
        System.out.print("Remove: 90, size: " + tree.getSize() + ", printout: \n");
        tree.printTree(tree.getRoot(), 0);
    }
}
