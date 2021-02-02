import com.revature.BinaryTree;

public class BinaryTreeTest {

    public static void main(String[] args) {
        BinaryTree<Integer> tree = new BinaryTree<>();

        tree.insert(5);
        System.out.println("inserted a 5");

        tree.insert(6);
        System.out.println("inserted a 6");
        tree.insert(4);
        System.out.println("inserted a 4");

        tree.printTree();

        System.out.println("The size of the tree is "+tree.size());

        System.out.println("Does the tree contain 5: "+tree.contains(5));
        System.out.println("Does the tree contain 7: "+tree.contains(7));

        System.out.println("Removing the 5");
        tree.remove(5);
        System.out.println("The size is now: "+tree.size());
        tree.printTree();

        System.out.println("Removing a 7");
        System.out.println("The tree is now size: "+tree.size());
    }
}
