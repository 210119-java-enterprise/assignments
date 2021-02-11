package com.revature.pc;

public class Producer {

    private final Object monitor;
    private IntBuffer buffer;

    public Producer(IntBuffer buffer, Object monitor) {
        this.buffer = buffer;
        this.monitor = monitor;
    }

    void produce() {

        synchronized (monitor) {

            if (buffer.isFull()) {
                System.out.println("Buffer is full, pausing thread.");
                try {
                    monitor.wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }

            buffer.getBuffer()[buffer.getCount()] = 1;
            buffer.incrementCount();

            System.out.println("Produced new value. Notifying monitor.");
            monitor.notify();

        }

    }

}
