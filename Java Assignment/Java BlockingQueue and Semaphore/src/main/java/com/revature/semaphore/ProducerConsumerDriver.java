package com.revature.semaphore;

import java.util.concurrent.Semaphore;

public class ProducerConsumerDriver {

    public static void main(String... strings) throws InterruptedException {

        Semaphore semaphore = new Semaphore(1);
        IntBuffer intBuffer = new IntBuffer();

        Producer producer = new Producer(semaphore, intBuffer);
        Consumer consumer = new Consumer(semaphore, intBuffer);

        Runnable produceTask = () -> {
            for (int i = 0 ; i < 50 ; i++) {
                producer.produce();
            }
            System.out.println("Done producing");
        };
        Runnable consumeTask = () -> {
            for (int i = 0 ; i < 45 ; i++) {
                consumer.consume();
            }
            System.out.println("Done consuming");
        };

        Thread consumerThread = new Thread(consumeTask);
        Thread producerThread = new Thread(produceTask);

        consumerThread.start();
        producerThread.start();

        consumerThread.join();
        producerThread.join();

        System.out.println("Data in the buffer: " + intBuffer.getCount());
    }

}
