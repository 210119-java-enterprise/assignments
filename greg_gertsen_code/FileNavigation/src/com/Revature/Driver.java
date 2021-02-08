package com.Revature;
/*
 * Basic package explorer written in Java
 * Leverages Java nio and DateTime packages
 *
 * User stories:
 * as a user, I can:
 * - read/write files
 * - create and read from directories
 * - read date and time of file creation and last modified file
 */
import com.sun.xml.internal.bind.api.impl.NameConverter;
import java.io.File;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
public class Driver {
    public static void main(String[] args) {
        // attempting to write to a file
        try {
            Path path = FileSystems.getDefault().getPath("src/com/Revature/output.txt");
            FileChannel fc = FileChannel.open(path, StandardOpenOption.WRITE);
            byte[] array = "hello world fafafasfafaf".getBytes();
            ByteBuffer bbuffer = ByteBuffer.wrap(array);
            fc.write(bbuffer);
            FileChannel rc = FileChannel.open(path, StandardOpenOption.READ);




        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}