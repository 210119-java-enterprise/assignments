package com.revature.pc.blocking_queue;

import java.util.concurrent.BlockingQueue;

public class Consumer {

    private BlockingQueue<Integer> blockingQueue;

    public Consumer(BlockingQueue blockingQueue) {
        this.blockingQueue = blockingQueue;
    }

    public void consume() {

        try{
            blockingQueue.take();
        } catch (InterruptedException e)
        {
            e.printStackTrace();
        }

        System.out.println("New value Consumed.");
    }
}
