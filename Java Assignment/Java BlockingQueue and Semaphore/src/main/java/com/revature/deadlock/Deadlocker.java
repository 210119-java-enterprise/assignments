package com.revature.deadlock;

public class Deadlocker {

    private final Object monitorA = new Object();
    private final Object monitorB = new Object();

    public void methodA() {
        synchronized (monitorA) {
            System.out.printf("[%s] is running inside of methodA()\n", Thread.currentThread().getName());
            methodB();
        }
    }

    public void methodB() {
        synchronized (monitorB) {
            System.out.printf("[%s] is running inside of methodB()\n", Thread.currentThread().getName());
            methodC();
        }
    }

    public void methodC() {
        synchronized (monitorA) {
            System.out.printf("[%s] is running inside of methodC()\n", Thread.currentThread().getName());
        }
    }

}
