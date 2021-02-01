import com.revature.BinaryTree;

public class Driver {

    public static void main(String[] args) {
        System.out.println("Here goes hope it works!");
        BinaryTree<Integer> bTree = new BinaryTree<>(1);

        bTree.insert(2);
        System.out.println(bTree.size());
        System.out.println("contains: " + bTree.contains(1));
        System.out.println("contains: " + bTree.contains(2));
        System.out.println("contains: " + bTree.contains(3));

        bTree.remove(1);
        System.out.println("contains: " + bTree.contains(1));

        bTree.insert(1);
        System.out.println(bTree.contains(1));


    }
}
