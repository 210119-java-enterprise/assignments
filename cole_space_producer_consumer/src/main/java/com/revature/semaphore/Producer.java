package com.revature.semaphore;

import java.util.Random;
import java.util.concurrent.Semaphore;

public class Producer {

    private final Semaphore semaphore;
    private CustomBuffer buffer;

    public Producer(CustomBuffer buffer, Semaphore semaphore){
        this.buffer = buffer;
        this.semaphore = semaphore;
    }

    public void produce(){

        try{
            semaphore.acquire();
            if (buffer.isFull()) {
                System.out.println("Buffer is full");
                this.wait();
            }
            buffer.getBufferArray()[buffer.getCount()] = new Random().nextInt();
            buffer.incrementCount();

            System.out.println("Produced new value");
            semaphore.release();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
