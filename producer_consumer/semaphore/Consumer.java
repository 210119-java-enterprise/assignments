package com.revature.pc.semaphore;

import java.util.concurrent.Semaphore;

public class Consumer {
    private Semaphore semaphore;
    private CustomBuffer buffer;

    public Consumer(CustomBuffer buffer, Semaphore sema) {
        this.buffer = buffer;
        this.semaphore=sema;

    }

    public void consume() {
        try {
            semaphore.acquire();
        } catch (InterruptedException e) {}

        if (buffer.isEmpty()) {
            System.out.println("empty");
            semaphore.release();
            try {
                semaphore.acquire();
            } catch (InterruptedException e) {}
        }
        System.out.println("nom");
        buffer.getBufferArray()[buffer.getCount() - 1] = 0;
        buffer.decrementCount();
        semaphore.release();
    }
}
