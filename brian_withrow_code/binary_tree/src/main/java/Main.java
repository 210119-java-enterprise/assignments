public class Main {
    public static void main(String [] args){

        BinaryTree<Integer> myBinary = new BinaryTree<Integer>();

        myBinary.insert(4);
        myBinary.insert(5);
        myBinary.insert(1);
        myBinary.insert(2);
        myBinary.insert(3);
        myBinary.insert(6);
        myBinary.insert(7);
        myBinary.insert(8);
        myBinary.remove(1);
        System.out.println(myBinary.size());
        System.out.println(myBinary.contains(1));
        System.out.println(myBinary.contains(2));
        System.out.println(myBinary.contains(3));
        System.out.println(myBinary.contains(4));
        System.out.println(myBinary.contains(5));
        System.out.println(myBinary.contains(6));
        System.out.println(myBinary.contains(7));
        System.out.println(myBinary.contains(8));

    }
}
