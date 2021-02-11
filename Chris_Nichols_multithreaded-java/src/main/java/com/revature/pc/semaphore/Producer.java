package com.revature.pc.semaphore;

import java.util.concurrent.Semaphore;

public class Producer {

    private CustomBuffer buffer;
    private Semaphore sem;

    public Producer(CustomBuffer buffer,Semaphore sem) {
        this.buffer = buffer;
        this.sem = sem;
    }

    public void produce() {
        try  {
            while(buffer.isFull()) {
                System.out.println("Buffer full, pausing producer thread.");
            }
            sem.acquire();
            buffer.getBufferArray()[buffer.getCount()] = 1;
            buffer.incrementCount();
            System.out.println("Produced new value. Notifying monitor.");
            sem.release();
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}
