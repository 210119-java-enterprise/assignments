package com.revature.pc.semaphore;

import java.util.concurrent.Semaphore;

public class Producer {
    private Semaphore semaphore;
    private CustomBuffer buffer;

    public Producer(CustomBuffer buffer, Semaphore sema) {
        this.buffer = buffer;
        this.semaphore=sema;
    }

    public void produce() {

        try {
            semaphore.acquire();
        } catch (InterruptedException e) {}

        if (buffer.isFull()) {
            System.out.println("full");
            semaphore.release();
            try {
                semaphore.acquire();
            } catch (InterruptedException e) {}
        }

        System.out.println("I gibs");
        buffer.getBufferArray()[buffer.getCount()] = 1;
        buffer.incrementCount();
        semaphore.release();
    }
}




