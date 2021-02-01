public class BinaryTree<T extends Comparable<T>> {

        private int size;
        private Node<T> root;

        public void insert(T data){
            Node<T> parent = null;
            boolean searching = true;

            if (contains(data))
                return;

            if (root == null){
                Node<T> newNode = new Node<T>(data);
                root = newNode;
                size++;
            } else {
                parent = root;

                while (searching) {
                    //This is a right traversal
                    if (0 < data.compareTo(parent.data)) {
                        if (parent.rightChild == null){
                            size++;
                            parent.rightChild = new Node<>(data);
                            return;
                        }
                        parent = parent.rightChild;
                    }

                    //This is a left traversal
                    if (0 > data.compareTo(parent.data)) {
                        if (parent.leftChild == null){
                            size++;
                            parent.leftChild = new Node<>(data);
                            return;
                        }
                        parent = parent.leftChild;
                    }
                }
            }

        }

        public boolean contains(T data){
            Node<T> searcher = null;
            boolean searching = true;

            if (root == null){
                return false;
            } else{
                searcher = root;
                while (searching){
                    //Then checks the data if the searcher is still a node.
                    if (searcher.data.equals(data)){
                        return true;
                    }

                    /**
                     * Each of the following traversals makes sure not to set the searcher to null for a
                     * NullPointerException
                     */
                    //This is a right traversal
                    if (0 < data.compareTo(searcher.data)) {
                        if (searcher.rightChild == null){
                            return false;
                        }
                        searcher = searcher.rightChild;
                    }

                    //This is a left traversal
                    if (0 > data.compareTo(searcher.data)) {
                        if (searcher.leftChild == null){
                            return false;
                        }
                        searcher = searcher.leftChild;
                    }
                }
            }
            return false;
        }

        public void remove(T data){
           Node<T> parent;
           Node<T> child;
           Node<T> temp;
           boolean searching = true;

           if (!contains(data)){
               return;
           }

           //Now that it is confirmed that the data is within the tree, I decrement size once for convenience.
            size--;
           //First we set up the premise for our deletion for acquiring the desired node and its parent.
           parent = null;
           child = root;
           while (searching){
               if (child.data.equals(data)){
                   searching = false;
               } else if(0 < data.compareTo(child.data)) {
                   //Right traversal to keep searching, no need to return because value is within tree.
                   parent = child;
                   child = child.rightChild;
               } else if(0 > data.compareTo(child.data)) {
                   //Left traversal to keep searching, no need to return because value is within tree.
                   parent = child;
                   child = child.leftChild;
               }
           }

           /**
            * With the parent and child acquired, we have to handle 1 of 3 cases:
            * 1. The child has no children nodes to be handled
            * 2. The child has one child node to be handled
            * 3. The child has two children nodes to be handled
            */

            // 1. The child has no nodes below
            if (child.leftChild == null && child.rightChild == null){
                //Root case:
                if (child == root){
                    root = null;
                    return;
                }

                //All others, delete reference from Parent:
                if (parent.leftChild == child){
                    parent.leftChild = null;
                } else{
                    parent.rightChild = null;
                }
                return;
            }

            // 2. The child has one node below
            //Logic will split based on where the null value is found.
            //If neither are null, then both children exist, will go to condition 3.
            //If there is no right child:
            if (child.rightChild == null){
                //Handle Root Case
                if (child == root){
                    root = root.leftChild;
                    return;
                }

                //Replaces the child from the parent's end with it's sole successor.
                if (parent.leftChild == child){
                    parent.leftChild = child.leftChild;
                } else{
                    parent.rightChild = child.leftChild;
                }
            }
            // If there is no left child:
            else if(child.leftChild == null){
                //Handle Root Case
                if (child == root){
                    root = root.rightChild;
                    return;
                }

                //Replaces the child from the parent's end with it's sole successor.
                if (parent.leftChild == child){
                    parent.leftChild = child.rightChild;
                } else{
                    parent.rightChild = child.rightChild;
                }
            }

            // 3. The child has two children nodes to be handled.
            // We find the leftmost child of the right branch of the parent in this instance.
            // This will guarantee that there is no left discrepancies with keeping all other nodes on the right side
            // While also keeping the left branch of the parent smaller than the node replacement.
            // There is ONE special case in which the right node does not have a left child, and is the successor
            if (child.rightChild.leftChild == null){
                child.data = child.rightChild.data;
                child.rightChild = child.rightChild.rightChild;
                // You kind of play leapfrog to just skip the right child, and make the replaced item the right child.
                return;
            }

            Node<T> successor = child.rightChild;
            Node<T> successorParent = child;


            while (successor.leftChild != null){
                successorParent = successor;
                successor = successor.leftChild;
            }

            child.data = successor.data;
            successorParent.leftChild = successor.rightChild;

        }

        public int size(){
            return size;
        }

        private class Node<T> {
            T data;
            Node<T> leftChild;
            Node<T> rightChild;

            Node(T data){
                this.data = data;
            }

            Node(T data, Node<T> parentNode){
                this(data);
            }
        }
}
