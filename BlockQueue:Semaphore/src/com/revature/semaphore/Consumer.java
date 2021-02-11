package com.revature.semaphore;

import com.revature.pc.CustomBuffer;

import java.util.concurrent.Semaphore;

public class Consumer {

    private final Semaphore sem;
    private CustomBuffer buffer;

    public Consumer(Semaphore sem, CustomBuffer buffer) {
        this.buffer = buffer;
        this.sem = sem;
    }

    public void consume() {

            if (buffer.isEmpty()) {
                try {
                    sem.acquire();
                    buffer.getBufferArray()[buffer.getCount() - 1] = 0;
                    buffer.decrementCount();
                    sem.release();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
    }
}