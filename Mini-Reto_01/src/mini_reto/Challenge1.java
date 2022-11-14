package mini_reto;

import java.util.InputMismatchException;
import java.util.Random;
import java.util.Scanner;

public class Challenge1 {

    // randomGen method
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

    // 
    public static int[] sortString(String unsorted, String sortOrder) {
        // Variables
        int[] numbersArr = new int[10];
        int tmp;

        // Creates an int array from the unsorted String.
        for (int i = 0; i < numbersArr.length; i++) {
            numbersArr[i] = Integer.parseInt(Character.toString(unsorted.charAt(i)));
        }

        if (sortOrder.equals("Asc")) {
            // Sorts the numbers in the array in ascending order.
            for (int i = 0; i < numbersArr.length - 1; i++) {
                for (int j = 0; j < numbersArr.length - 1; j++) {
                    if (numbersArr[j] > numbersArr[j + 1]) { 
                        tmp = numbersArr[j];
                        numbersArr[j] = numbersArr[j + 1];
                        numbersArr[j + 1] = tmp;
                    }
                }
            }
        }
        if (sortOrder.equals("Desc")) {
            // Sorts the numbers in the array in descending order.
            for (int i = 0; i < numbersArr.length - 1; i++) {
                for (int j = 0; j < numbersArr.length - 1; j++) {
                    if (numbersArr[j] < numbersArr[j + 1]) { // Logic change, numbersArr[j] < numbersArr[j + 1]
                        tmp = numbersArr[j];
                        numbersArr[j] = numbersArr[j + 1];
                        numbersArr[j + 1] = tmp;
                    }
                }
            }
        }

        return numbersArr;
    }

    public static void main(String[] args) {
        // Variables
        Scanner input = new Scanner(System.in);
        int menuOption1 = 0;
        int menuOption2 = 0;
        String finalCode = "";
        String sortOrder;
        int[] orderedArr;

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
                orderedArr = sortString(finalCode, sortOrder);
                System.out.println("\nThe numbers in ascending order are:");
                for (int i = 0; i < orderedArr.length; i++) {
                    System.out.print(orderedArr[i] + ",");
                }
                System.out.println("");
                break;
            case 2:
                sortOrder = "Desc";
                orderedArr = sortString(finalCode, sortOrder);
                System.out.println("\nThe numbers in descending order are:");
                for (int i = 0; i < orderedArr.length; i++) {
                    System.out.print(orderedArr[i] + ",");
                }
                System.out.println("");
                break;
            case 3:
                System.out.println("Exit...");
                break;
            default:
                System.out.println("Invalid option, try again.");
        }
    }
}
