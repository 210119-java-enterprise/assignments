package com.revature.pc.semaphore;


import java.util.concurrent.Semaphore;

public class Producer {

    private final Object monitor;
    private final Semaphore sem;
    private CustomBuffer buffer;
    int checkIfConsumerIsDone = 0;

    public Producer(CustomBuffer buffer, Semaphore sem, Object monitor) {
        this.buffer = buffer;
        this.sem = sem;
        this.monitor = monitor;
    }

    public void produce() {
        try{

            System.out.println("Producer is waiting for the permit");
            sem.acquire();
            System.out.println("Producer got the permit");

            while (buffer.isFull()) {
                System.out.println("Buffer full, pausing producer thread.");
                sem.release();
               // while(buffer.isFull())
                //{
                    try{
                        //Thread.sleep(10);
                        sem.acquire();
                    }catch(InterruptedException e)
                    {
                        e.printStackTrace();
                    }
                checkIfConsumerIsDone+=1;
                    if(checkIfConsumerIsDone == buffer.getBufferArray().length)
                    {
                        break;
                    }
               //}

                //sem.wait();
                //monitor.lock()
               // sem.release();


               // monitor.lock();
                //sem.notify();
                //sem.release();
            }
            if (!buffer.isFull())
            {
                buffer.getBufferArray()[buffer.getCount()] = 1;
                buffer.incrementCount();

                System.out.println("Produced new value. Releasing Permit.");
                System.out.println("Amount in buffer " + buffer.getCount());
            }

            //monitor.unlock()
            checkIfConsumerIsDone =0;
            sem.release();
            //monitor.notify();

        }catch(InterruptedException e)
        {
            e.printStackTrace();
        }
    }
}
