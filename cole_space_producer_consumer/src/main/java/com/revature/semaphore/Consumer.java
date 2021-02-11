package com.revature.semaphore;

import java.util.concurrent.Semaphore;

public class Consumer {

    private final Semaphore semaphore;
    private CustomBuffer buffer;

    public Consumer (CustomBuffer buffer, Semaphore semaphore){
        this.buffer = buffer;
        this.semaphore = semaphore;
    }

    public void consume() {

        try{
            semaphore.acquire();
            if (buffer.isEmpty()) {
                System.out.println("Buffer is empty");
                this.wait();
            }
            buffer.getBufferArray()[buffer.getCount() - 1] = 0;
            buffer.decrement();

            System.out.println("Consumed value");
            semaphore.release();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
