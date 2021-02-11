package com.revature.race;

public class RaceConditionDriver {

    public static void main(String[] args) throws InterruptedException {

        IntWrapper intWrapper = new IntWrapper();

        Runnable r1 = () -> {
            for (int i = 0; i < 1000; i++) {
                intWrapper.incrementValue();
            }
        };

        Runnable r2 = () -> {
            for (int i = 0; i < 1000; i++) {
                intWrapper.incrementValue();
            }
        };

        Thread t1 = new Thread(r1);
        t1.start();

        Thread t2 = new Thread(r2);
        t2.start();

        t1.join();
        t2.join();

        System.out.println(intWrapper.getValue());

    }
}
