package com.schedule.util;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class Util {

    public static String digestStringSHA256(String data) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        return digestString(data, "SHA-256");
    }

    public static String digestString(String data, String algorithm) throws NoSuchAlgorithmException, UnsupportedEncodingException {
        MessageDigest md = MessageDigest.getInstance(algorithm);

        byte digest[] = md.digest(data.getBytes("iso-8859-1"));
        String hash = "";
        for (int i = 0; i < digest.length; i++) {
            hash += String.format("%02x", digest[i] & 0xff).toUpperCase();
        }

        return hash;
    }

}
