package com.revature.blocking_queue;

import java.util.Random;

public class Producer {

    private CustomBuffer buffer;

    public Producer(CustomBuffer buffer){
        this.buffer = buffer;
    }

    public void produce() {
        try {
            buffer.getBufferArray().put(new Random().nextInt());
            System.out.println("Produced new value");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
