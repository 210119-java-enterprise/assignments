package com.revature.semaphore;

import com.revature.pc.CustomBuffer;

import java.util.concurrent.Semaphore;

public class Producer {

    private final Semaphore sem;
    private CustomBuffer buffer;

    public Producer(Semaphore sem, CustomBuffer buffer) {
        this.buffer = buffer;
        this.sem = sem;
    }

    public void produce() {
            if (buffer.isFull()) {
                try {
                    sem.acquire();
                    buffer.getBufferArray()[buffer.getCount()] = 1;
                    buffer.incrementCount();
                    sem.release();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }
    }
