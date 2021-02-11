package com.revature.deadlock;

public class DeadlockDriver {

    public static void main(String[] args) throws InterruptedException {

        final Deadlocker deadlocker = new Deadlocker();
        Runnable runnable_1 = deadlocker::methodA;
        Runnable runnable_2 = deadlocker::methodB;

        Thread t1 = new Thread(runnable_1);
        t1.start();

        Thread t2 = new Thread(runnable_2);
        t2.start();

        t1.join();
        t2.join();

    }
}
