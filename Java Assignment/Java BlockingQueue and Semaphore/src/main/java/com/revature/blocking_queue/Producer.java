package com.revature.blocking_queue;

import com.revature.pc.IntBuffer;

import java.util.concurrent.BlockingQueue;

public class Producer implements Runnable {

    private BlockingQueue<Integer> blockingQueue;

    public Producer(BlockingQueue<Integer> blockingQueue) {
        this.blockingQueue = blockingQueue;
    }

    void produce() {
    }

    @Override
    public void run() {
        try {
            for (int i = 0; i < 10; i++)
                // blockingQueue.put() will wait for a free slot in the queue, and then insert specified element
                blockingQueue.put(i);
            System.out.println("Produced new values.");
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
        }
    }
}
