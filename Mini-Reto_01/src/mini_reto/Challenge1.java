package mini_reto;

import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

public class Challenge1 {
    public String randomGen(String tipo){
        return null;
    }
    
    public static void main(String[] args) {
        Scanner input = new Scanner(System.in);

        // Variables
        int option = 0;
        Random random = new Random();
        String genCode = "";
        String prefixA = "54";
        String prefixB = "08";
        String finalCode;

        // Menu
        System.out.print("Welcome to the random number generator:\n"
                + "Choose your option:\n"
                + "\n"
                + "1. Type A = 1\n"
                + "2. Type B = 2\n"
                + "3. Exit = 3\n"
                + "\n"
                + "Enter your selection (1, 2 or 3 to exit): ");

        // Generates a random numbers "String".        
        for (int i = 0; i < 8; i++) {
            int randomN = random.nextInt(10);
            genCode += randomN;
        }

        try {
            option = input.nextInt();
        } catch (InputMismatchException immex) {
            
        }
        switch (option) {
            case 1:
                finalCode = prefixA + genCode;
                System.out.println("The generated string is:\n" + finalCode);
                break;
            case 2:
                finalCode = prefixB + genCode;
                System.out.println("The generated string is:\n" + finalCode);
                break;
            case 3:
                System.out.println("Exit...");
                break;
            default:
                System.out.println("Invalid option, try again.");
        }
    }
}
