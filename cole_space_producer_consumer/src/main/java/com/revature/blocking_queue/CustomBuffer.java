package com.revature.blocking_queue;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

public class CustomBuffer {

    private BlockingQueue<Integer> blockedBuffer;

    public CustomBuffer() {
        blockedBuffer = new LinkedBlockingQueue<>();
    }

    public BlockingQueue<Integer> getBufferArray() {
        return blockedBuffer;
    }

    public int getCount() {
        return blockedBuffer.size();
    }
}
