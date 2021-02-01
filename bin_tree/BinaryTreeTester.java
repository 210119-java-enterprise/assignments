public class BinaryTreeTester {
    public static void main(String[] args) {

        BinaryTree<Integer> t0 = new BinaryTree<Integer>();
        System.out.println("Testing add()...");
        t0.add(2);
        t0.add(1);
        t0.add(3);
        assert(t0.getSize() == 3);
        System.out.println("\t1");
        t0.add(3);
        assert(t0.getSize() == 4);
        System.out.println("\t2");
        t0.add(2);
        assert(t0.getSize() == 5);
        System.out.println("\t3");
        t0.add(null);
        assert(t0.getSize() == 5);
        System.out.println("\t4");

        System.out.println("Testing contains()...");
        assert(t0.contains(1));
        assert(t0.contains(2));
        assert(t0.contains(3));
        System.out.println("\t1");
        assert(!t0.contains(-1));
        assert(!t0.contains(null));
        System.out.println("\t2");

        System.out.println("Testing remove()...");
        t0.remove(1);
        assert(t0.getSize() == 4);
        assert(!t0.contains(1));
        System.out.println("\t1");
        t0.remove(2);
        assert(t0.getSize() == 3);
        assert(t0.contains(2));
        System.out.println("\t2");

        System.out.println("All tests passed successfully!");
        
    }
}
