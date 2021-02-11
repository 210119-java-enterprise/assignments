package com.revature.pc.concurrentqueue;

import java.util.concurrent.LinkedBlockingQueue;

public class Producer {

    private LinkedBlockingQueue<Integer> buffer;

    public Producer(LinkedBlockingQueue<Integer> buffer) {
        this.buffer = buffer;
    }

    public void produce() {
        try {
            buffer.put(1);
            System.out.println("Produced new value. Notifying monitor.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
