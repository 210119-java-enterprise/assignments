package com.revature.semaphore;

import java.util.concurrent.Semaphore;

public class Producer {

    private Semaphore semaphore;
    private IntBuffer intBuffer;

    public Producer(Semaphore semaphore, IntBuffer intBuffer) {
        this.semaphore = semaphore;
        this.intBuffer = intBuffer;
    }

    void produce() {

        if (!intBuffer.isFull()) {
            try {
                semaphore.acquire();
                intBuffer.getBuffer()[intBuffer.getCount()] = 1;
                intBuffer.incrementCount();
                semaphore.release();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

    }
}
