package com.revature.pc.concurrentqueue;


import java.util.concurrent.LinkedBlockingQueue;

public class Consumer {

    private LinkedBlockingQueue<Integer> buffer;

    public Consumer(LinkedBlockingQueue<Integer> buffer) {
        this.buffer = buffer;
    }

    public void consume() {
        try {
            while(buffer.isEmpty()) {
                System.out.println("Buffer is empty, pausing consumer thread.");
            }
             buffer.remove(0);
            System.out.println("Consumed new value. Notifying monitor.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
