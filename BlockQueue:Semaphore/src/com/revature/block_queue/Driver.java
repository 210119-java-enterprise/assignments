package com.revature.block_queue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class Driver {

    public static void main(String... strings) throws InterruptedException {

        BlockingQueue<Integer> queue = new LinkedBlockingQueue<>(10);

        Producer producer = new Producer(queue);
        Consumer consumer = new Consumer(queue);

        Thread consumerThread = new Thread(consumer);
        Thread producerThread = new Thread(producer);

        consumerThread.start();
        producerThread.start();

        consumerThread.join();
        producerThread.join();
    }
}