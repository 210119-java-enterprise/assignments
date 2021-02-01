import com.revature.BinaryTree;

public class BinaryTreeDriver {

    public static void main(String[] args) {

        BinaryTree<Integer> binaryTree = new BinaryTree<>();

        System.out.println("Size before Inserts: " + binaryTree.size());

        binaryTree.insert(7);
        binaryTree.insert(3);
        binaryTree.insert(8);
        binaryTree.insert(6);
        binaryTree.insert(1);

        // Does not work.
        binaryTree.insert(null);

        System.out.println("Size after Inserts: " + binaryTree.size());

        if (binaryTree.contains(7))
            System.out.println("Contains 7");
        if (binaryTree.contains(1))
            System.out.println("Contains 1");
        if (binaryTree.contains(9))
            System.out.println("Contains 9");

        binaryTree.remove(1);

        System.out.println("Size after removing 1: " + binaryTree.size());

        if (!binaryTree.contains(1)) {
            System.out.println("Does not contain 1");
        }

        // BONUS Test
        // 3 6 7 8
        binaryTree.inOrder(binaryTree.getRoot());
        System.out.println();

        // 7 3 6 8
        binaryTree.preOrder(binaryTree.getRoot());
        System.out.println();

        // 6 3 8 7
        binaryTree.postOrder(binaryTree.getRoot());
        System.out.println();
    }
}
