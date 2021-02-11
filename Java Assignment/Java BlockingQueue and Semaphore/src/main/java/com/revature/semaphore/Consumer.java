package com.revature.semaphore;

import java.util.concurrent.Semaphore;

public class Consumer {

    private Semaphore semaphore;
    private IntBuffer intBuffer;

    public Consumer(Semaphore semaphore, IntBuffer intBuffer) {
        this.semaphore = semaphore;
        this.intBuffer = intBuffer;
    }

    void consume() {

        if (!intBuffer.isEmpty()) {
            try {
                semaphore.acquire();
                intBuffer.getBuffer()[intBuffer.getCount() - 1] = 0;
                intBuffer.decrementCount();
                semaphore.release();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
    }
}

