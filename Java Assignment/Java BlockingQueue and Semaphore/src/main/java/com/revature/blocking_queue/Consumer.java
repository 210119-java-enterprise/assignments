package com.revature.blocking_queue;

import java.util.concurrent.BlockingQueue;

public class Consumer implements Runnable {

    private BlockingQueue<Integer> blockingQueue;

    public Consumer(BlockingQueue<Integer> blockingQueue) {

        this.blockingQueue = blockingQueue;
    }

    void consume() {
    }

    @Override
    public void run() {

        try {
            while (true) {
                // blockingQueue.take() will wait for an element and remove it.
                // Or if the queue is empty, it will block and wait for an element.
                Integer num = blockingQueue.take();
                System.out.println("Number Consumed: " + num);
            }
        } catch (InterruptedException ie) {
            Thread.currentThread().interrupt();
        }
    }
}
