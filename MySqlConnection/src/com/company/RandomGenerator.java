package com.company;

import java.util.ArrayList;
import java.util.Random;
import java.util.List;

public class RandomGenerator {

//    public static void main(String[] args) {
//        List<Category> categoryList = categoryGenerator(10);
//
//        for(int i = 0; i < 10; i++)
//            categoryList.get(i).print();
//    }

    private static String stringGenerator(int num) {
        Random random = new Random();
        int leftLimit = 97;
        int rightLimit = 122;
        int targetLength = num;


        StringBuilder buffer = new StringBuilder();

        for(int i = 0; i < targetLength; i++) {
            int randomLimitedInt = leftLimit + (int)
                    (random.nextFloat() * (rightLimit - leftLimit + 1));
            buffer.append((char) randomLimitedInt);
        }

        return buffer.toString();

    }

    static List<Category> categoryGenerator(int num, int nameLength) {
        List<Category> categoryList = new ArrayList<>();

        for(int i = 0; i < num; i++) {
            String name = stringGenerator(nameLength);
            int isFeatured = (new Random()).nextInt(2);
            categoryList.add(new Category(name, isFeatured));
        }
        return categoryList;
    }
}


class Category {

    String name;
    int isFeatured;

    public Category(String name, int isFeatured) {
        this.name = name;
        this.isFeatured = isFeatured;
    }

    public void print() {
        System.out.println(name +  " " + isFeatured);
    }
}


