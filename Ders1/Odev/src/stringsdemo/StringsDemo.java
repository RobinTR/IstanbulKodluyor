package stringsdemo;

public class StringsDemo {
    public static void main(String[] args) {
        String message = "Bugün hava çok güzel.";
        System.out.println(message);

        System.out.println("Karakter sayısı: " + message.length());
        System.out.println("5. karakter: " + message.charAt(4));
        System.out.println(message.concat(" Yaşasın!"));
        System.out.println(message);
        System.out.println(message.startsWith("B"));
        System.out.println(message.endsWith("."));
        char[] karakterler = new char[5];
        message.getChars(0, 5, karakterler, 0);
        System.out.println(karakterler);
        System.out.println(message.indexOf('a'));
        System.out.println(message.lastIndexOf('a'));
    }
}
