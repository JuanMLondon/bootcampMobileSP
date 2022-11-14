package mini_reto;

import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

public class Challenge1 {

    public static String randomGen(String tipo) {
        // Variables
        Random random = new Random();
        String genCode = "";
        String prefixA = "54";
        String prefixB = "08";
        String finalCode;

        // Generates a random numbers "String".        
        for (int i = 0; i < 8; i++) {
            int randomN = random.nextInt(10);
            genCode += randomN;
        }

        // Concatenates the generated String with the corresponding prefix.
        if (tipo.equals("TipoA")) {
            finalCode = prefixA + genCode;
            return finalCode;
        } else if (tipo.equals("TipoB")) {
            finalCode = prefixB + genCode;
            return finalCode;
        } else {
            return null;
        }
    }

    public static String[] sortString(String sortOrder) {
        
        return null;
    }

    public static void main(String[] args) {
        // Variables
        Scanner input = new Scanner(System.in);
        int menuOption1 = 0;
        int menuOption2 = 0;
        String finalCode;
        String sortOrder;
        String[] orderedString;

        // Menu 1
        System.out.print("Welcome to the random number generator:\n"
                + "Choose your option:\n"
                + "\n"
                + "1. Type A = 1\n"
                + "2. Type B = 2\n"
                + "3. Exit = 3\n"
                + "\n"
                + "Enter your selection (1, 2 or 3 to exit): ");

        try {
            menuOption1 = input.nextInt();

        } catch (InputMismatchException immex) {

        }

        switch (menuOption1) {
            case 1:
                finalCode = randomGen("TipoA");
                System.out.println("The generated string is:\n" + finalCode);
                break;
            case 2:
                finalCode = randomGen("TipoB");
                System.out.println("The generated string is:\n" + finalCode);
                break;
            case 3:
                System.out.println("Exit...");
                break;
            default:
                System.out.println("Invalid option, try again.");
        }
        System.out.println("");

        // Menu 2
        System.out.print("\nDo you wish to sort your string in ascending o descending order?\n"
                + "\n"
                + "1. Ascending = 1\n"
                + "2. Descending = 2\n"
                + "3. Exit = 3\n"
                + "\n"
                + "Enter your selection (1, 2 or 3 to exit): ");

        try {
            menuOption2 = input.nextInt();

        } catch (InputMismatchException immex) {

        }

        switch (menuOption2) {
            case 1:
                sortOrder = "Asc";
                orderedString = sortString(sortOrder);
                System.out.println("The string in ascending order is:\n");
                break;
            case 2:
                sortOrder = "Desc";
                orderedString = sortString(sortOrder);
                System.out.println("The string in descending order is:\n");
                break;
            case 3:
                System.out.println("Exit...");
                break;
            default:
                System.out.println("Invalid option, try again.");
        }
    }
}