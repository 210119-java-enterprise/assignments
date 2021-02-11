package com.revature.pc.semaphore;


import java.util.concurrent.Semaphore;

public class Consumer {

    private final Object monitor;
    private final Semaphore sem;
    private CustomBuffer buffer;
    int checkIfProducerIsDone = 0;

    public Consumer(CustomBuffer buffer, Semaphore sem, Object monitor) {
        this.buffer = buffer;
        this.sem = sem;
        this.monitor = monitor;
    }

    public void consume() {


        try{
            System.out.println("Consumer is waiting for the permit");
            sem.acquire();
            System.out.println("Consumer got the permit");
            while (buffer.getCount() == 0) {
                System.out.println("Buffer is empty, pausing consumer thread.");
                sem.release();

                //while(buffer.isEmpty()) {
                    try{
                        //Thread.sleep(10);
                        sem.acquire();
                    }catch(InterruptedException e){
                        e.printStackTrace();
                    }

                    checkIfProducerIsDone+=1;
                    if(checkIfProducerIsDone == buffer.getBufferArray().length)
                    {
                        break;
                    }
               // }


                //monitor.lock()

             ;
            }
           if(buffer.getCount() > 0)
           {
               buffer.getBufferArray()[buffer.getCount() - 1] = 0;
               buffer.decrementCount();

               System.out.println("Consumed new value. Release permit.");
               System.out.println("Amount in buffer " + buffer.getCount());

           }

            //monitor.unlock();
            checkIfProducerIsDone = 0;
            sem.release();
        }catch(InterruptedException e)
        {
            e.printStackTrace();
        }


        }
    }


/*
*         try{

            System.out.println("Producer is waiting for the permit");
            sem.acquire();
            System.out.println("Producer got the permit");

            if (buffer.isFull()) {
                System.out.println("Buffer full, pausing producer thread.");
                sem.release();
            }

            buffer.getBufferArray()[buffer.getCount()] = 1;
            buffer.incrementCount();

            System.out.println("Produced new value. Notifying monitor.");
            Thread.sleep(10);
            sem.release();
            //monitor.notify();

        }catch(InterruptedException e)
        {
            e.printStackTrace();
        }
*
*
* */
