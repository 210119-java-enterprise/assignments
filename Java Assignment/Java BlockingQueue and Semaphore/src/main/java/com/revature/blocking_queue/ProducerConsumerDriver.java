package com.revature.blocking_queue;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class ProducerConsumerDriver {

    public static void main(String... strings) throws InterruptedException {

        BlockingQueue<Integer> blockingQueue = new LinkedBlockingQueue<>(10);

        Producer producer = new Producer(blockingQueue);
        Consumer consumer = new Consumer(blockingQueue);

        Thread consumerThread = new Thread(consumer);
        Thread producerThread = new Thread(producer);

        consumerThread.start();
        producerThread.start();

        consumerThread.join();
        producerThread.join();


    }

}
