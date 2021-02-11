package BlockQueue;

import java.util.concurrent.BlockingQueue;

public class Producer {


    private BlockingQueue<Integer> blockingQueue;

    public Producer(BlockingQueue<Integer> blockingQueue) {
        this.blockingQueue = blockingQueue;
    }

    public void produce() {
        try {
            blockingQueue.put(1);
        } catch (InterruptedException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        System.out.println("Produced new value.");

    }
}