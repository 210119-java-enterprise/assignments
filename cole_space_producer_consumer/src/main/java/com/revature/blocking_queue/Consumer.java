package com.revature.blocking_queue;

public class Consumer {

    private CustomBuffer buffer;

    public Consumer (CustomBuffer buffer){
        this.buffer = buffer;
    }

    public void consume(){
        try {
            buffer.getBufferArray().take();
            System.out.println("Consumed value");
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
