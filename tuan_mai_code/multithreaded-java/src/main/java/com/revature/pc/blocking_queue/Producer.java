package com.revature.pc.blocking_queue;

import java.util.concurrent.BlockingQueue;

public class Producer {

    private BlockingQueue<Integer> blockingQueue;

    public Producer(BlockingQueue blockingQueue) {
        this.blockingQueue = blockingQueue;
    }

    public void produce() {

        try{
            blockingQueue.put(1);
        } catch (InterruptedException e)
        {
            e.printStackTrace();
        }

        System.out.println("New value Produced.");
    }
}
