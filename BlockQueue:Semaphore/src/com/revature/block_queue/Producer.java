package com.revature.block_queue;
import java.util.concurrent.BlockingQueue;

public class Producer implements Runnable{

    private BlockingQueue<Integer> queue;

    public Producer(BlockingQueue<Integer> queue) {
        this.queue = queue;
    }

    @Override
    public void run() {
        try {
            for (int i = 0; i < 10; i++)
                queue.put(i);
            System.out.println("Produced new values.");
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
        }
    }
}
