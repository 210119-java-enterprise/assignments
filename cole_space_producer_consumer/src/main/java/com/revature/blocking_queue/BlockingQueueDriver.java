package com.revature.blocking_queue;

import java.util.Arrays;

public class BlockingQueueDriver {

    public static void main(String[] args) throws InterruptedException {

        CustomBuffer buffer = new CustomBuffer();

        Producer producer = new Producer(buffer);
        Consumer consumer = new Consumer(buffer);

        Runnable produceTask = () -> {
            for(int i = 0; i < 50; i++){
                producer.produce();
            }
            System.out.println("Done producing");
        };

        Runnable consumeTask = () -> {
            for(int i = 0; i < 45; i++){
                consumer.consume();
            }
            System.out.println("Done consuming");
        };

        Thread producerThread = new Thread(produceTask);
        producerThread.setName("producer");
        Thread consumerThread = new Thread(consumeTask);
        consumerThread.setName("consumer");

        producerThread.start();
        consumerThread.start();

        producerThread.join();
        consumerThread.join();

        System.out.println("Data in the buffer (count): " + buffer.getCount());
        //System.out.println(Arrays.toString(buffer.getBufferArray()));
    }
}
