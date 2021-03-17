import java.util.Arrays;

class ReverseString{

    public String method(String input){

        char[] charString= input.toCharArray();
        char[] newCharString = new char[charString.length];
        int counter = 0;
        for(int i = charString.length; i > 0; i--){

            newCharString[counter] = charString[i-1];
            counter++;
        }
        //String resultString = Character.toString(newCharString);
        StringBuilder build = new StringBuilder();

//        for(int i = 0; i < newCharString.length; i++){
//            build.append(Character.toString(newCharString[i]));
//        }
//        return build.toString();

        return newCharString.toString();
    }
}