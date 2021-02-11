package com.revature.pc.blockqueue;

import java.util.concurrent.BlockingQueue;

public class Consumer {


    private BlockingQueue<Integer> blockingQueue;

    public Consumer(BlockingQueue<Integer> blockingQueue) {
        this.blockingQueue = blockingQueue;
    }

    public void consume() {
        try {
            blockingQueue.take();
            System.out.println("nom");
        } catch (InterruptedException e) {}

    }
}
