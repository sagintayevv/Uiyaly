//
//  Sa.swift
//  Uialy
//
//  Created by Abat Sagintayev on 07.03.2022.
//

import Foundation

//import java.util.Scanner;
//public class Main
//{
//
//    static void RSA(){

//        Scanner sc=new Scanner(System.in);
//        int p,q,n;
//        int phi,e,k,d;

//        System.out.print("Message=");
//        String m=sc.nextLine();
//
//        int random ;
//        int j=0;
//        int []a=new int[2];
//
//        while(j<2){
//            random = 2 + (int) (Math.random() * 100);
//            if(prime(random)){
//                a[j]=random;
//                j++;
//            }
//        }
//        j=0;
//        p=a[0];
//        q=a[1];

//        System.out.println("p="+p+" "+"q="+q);
//        n=p*q;

//        System.out.println("n="+n);
//        phi=(p-1)*(q-1);

//        System.out.println("Phi="+phi);
//        e=E(phi);
//        d=D(e,phi);

//        System.out.println("e="+e);
//        System.out.println("d="+d+"\n");

//        int []ascii=new int[1000];
//
//        System.out.print("Message ASCII=");

//        for(int i=0;i<m.length();i++){
//            char c=m.charAt(i);
//            ascii[i] = (int)c;
//            System.out.print(ascii[i]);
//        }
//        int []enc=new int[1000];
//        for(int i=0;i<m.length();i++){
//            enc[i]=encryption(ascii[i],e,n);
//        }
//        System.out.print("\n\nEncryption=");
//        for(int i=0;i<m.length();i++){
//            System.out.print(enc[i]);
//        }
//        int []dec=new int[1000];
//        for(int i=0;i<m.length();i++){
//            dec[i]=decryption(enc[i],d,n);
//        }
//        System.out.print("\n\nDecryption=");
//        for(int i=0;i<m.length();i++){
//            System.out.print((char)dec[i]);
//        }
//        System.out.print("\n\nDecryption ASCII=");
//        for(int i=0;i<m.length();i++){
//            System.out.print(dec[i]);
//        }
//
//
//    }
//    static boolean prime(int n){
//
//        for(int i=2;i<=Math.sqrt(n);i++){
//            if(n%i==0)
//            return false;
//        }
//        return true;
//    }
//
//    static int E(int phi){
//        int e;
//        for(e=2;e<phi;e++){
//            if(phi%e==1){
//                return e;
//            }
//        }
//        return 0;
//    }
//    static int D(int e,int phi){
//        int d;
//        int k=1;
//        while(true){
//            k+=phi;
//            if(k%e==0){
//                d=(k/e);
//                return d;
//            }
//        }
//
//    }
//
//    static int encryption(int m,int e, int n){
//        int enc=m;
//        for(int i=0;i<e-1;i++)
//            enc=(enc*m)%n;
//            return enc;
//    }
//    static int decryption(int c,int d, int n){
//        int dec=c;
//        for(int i=0;i<d-1;i++)
//            dec=(dec*c)%n;
//            return dec;
//    }
//
//    public static void main(String[] args) {
//        RSA();
//    }
//}
