package com.revature.pc.semaphore;

import java.util.concurrent.Semaphore;

public class Consumer {

    private CustomBuffer buffer;
    private Semaphore sem;

    public Consumer(CustomBuffer buffer,Semaphore sem) {
        this.buffer = buffer;
        this.sem = sem;
    }

    public void consume() {
        try{
            while(buffer.isEmpty()) {
                System.out.println("Buffer is empty, pausing consumer thread.");
            }
            sem.acquire();
            buffer.getBufferArray()[buffer.getCount() - 1] = 0;
            buffer.decrementCount();
            System.out.println("Consumed new value. Notifying monitor.");
            sem.release();
        }catch(Exception e) {
            e.printStackTrace();
        }
    }
}
