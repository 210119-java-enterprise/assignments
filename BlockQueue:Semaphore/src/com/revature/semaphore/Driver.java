package com.revature.semaphore;
import com.revature.pc.CustomBuffer;
import java.util.concurrent.Semaphore;

public class Driver {

    public static void main(String... strings) throws InterruptedException {

        Semaphore sem = new Semaphore(1);
        CustomBuffer customBuffer = new CustomBuffer();

        Producer producer = new Producer(sem, customBuffer);
        Consumer consumer = new Consumer(sem, customBuffer);

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

        System.out.println("Data in the buffer: " + customBuffer.getCount());
    }

}