package com.revature.semaphore;

public class IntBuffer {

    private int[] buffer;
    private int count;

    public IntBuffer() {
        buffer = new int[10];
        count = 0;
    }

    public int[] getBuffer() {
        return buffer;
    }

    public int getCount() {
        return count;
    }

    public void incrementCount() {
        ++count;
    }

    public void decrementCount() {
        --count;
    }

    public boolean isEmpty() {
        return count == 0;
    }

    public boolean isFull() {
        return count == buffer.length;
    }

}
