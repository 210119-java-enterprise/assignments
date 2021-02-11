package com.revature.pc.semaphore;

import java.util.concurrent.Semaphore;

public class Producer {

    private CustomBuffer buf;
    private final Semaphore sem;

    public Producer(CustomBuffer buf, Semaphore sem) {
        this.buf = buf;
        this.sem = sem;
    }

    public void produce() {
        try {
            sem.acquire();
        } catch (InterruptedException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        if (buf.isFull()) {
            System.out.println("Buffer is full, pausing producer thread.");
            sem.release();
            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            try {
                sem.acquire();
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }

        System.out.println("size of buf: " + buf.getCount());
        buf.getBufferArray()[buf.getCount()] = 1;
        buf.incrementCount();

        System.out.println("Produced new value. Notifying semaphore");
        sem.release();

    }
}
