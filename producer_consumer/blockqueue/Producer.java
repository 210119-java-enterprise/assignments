package com.revature.pc.blockqueue;

import java.util.concurrent.BlockingQueue;

public class Producer {
    private BlockingQueue<Integer> blockingQueue;

    public Producer(BlockingQueue<Integer> blockingQueue) {
        this.blockingQueue = blockingQueue;
    }

    public void produce() {
        try {
            blockingQueue.put(1);
            System.out.println("gibs");
        } catch (InterruptedException e) {}
    }
}
