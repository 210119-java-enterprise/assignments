package com.revature.pc;

public class Consumer {

    private final Object monitor;
    private IntBuffer buffer;

    public Consumer(IntBuffer buffer, Object monitor) {
        this.buffer = buffer;
        this.monitor = monitor;
    }

    void consume() {

        synchronized (monitor) {

            if (buffer.isEmpty()) {
                try {
                    System.out.println("Buffer is empty, pausing thread.");
                    monitor.wait();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }

            buffer.getBuffer()[buffer.getCount() - 1] = 0;
            buffer.decrementCount();

            System.out.println("Consumed new value. Notifying monitor.");
            monitor.notify();

        }

    }

}
