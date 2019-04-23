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

    public static String stringGenerator(int num) {
        Random random = new Random();
        int leftLimit = 97;
        int rightLimit = 122;
        int targetLength = random.nextInt(num + 1);


        String buffer = "";

        for(int i = 0; i < targetLength; i++) {
            int randomLimitedInt = leftLimit + (int)
                    (random.nextFloat() * (rightLimit - leftLimit + 1));
            buffer += (char) randomLimitedInt;
        }

        return buffer;

    }

    public static List<Category> categoryGenerator(int num) {
        List<Category> categoryList = new ArrayList<>();

        for(int i = 0; i < num; i++) {
            String name = stringGenerator(11) + 1;
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


