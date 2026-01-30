package com.oceanview.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordHashGenerator {
    public static void main(String[] args) {
        String password = "password123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(10));
        System.out.println("BCrypt hash for 'password123': " + hash);
    }
}
