package arraysdemo;

public class ArraysDemo {
    public static void main(String[] args) {
        String ogrenci1 = "Engin";
        String ogrenci2 = "Robin";
        String ogrenci3 = "Salih";
        String ogrenci4 = "Ahmet";

        System.out.println(ogrenci1);
        System.out.println(ogrenci2);
        System.out.println(ogrenci3);
        System.out.println(ogrenci4);

        String[] ogrenciler = new String[4];
        ogrenciler[0] = "Engin";
        ogrenciler[1] = "Robin";
        ogrenciler[2] = "Salih";
        ogrenciler[3] = "Ahmet";
        //ogrenciler[4] = "Ali";

        String[] ogrenciler2 = {"Engin", "Robin", "Salih", "Ahmet"};

        System.out.println("---------------------------");

        for (int i = 0; i < ogrenciler.length; i++) {
            System.out.println(ogrenciler[i]);
        }

        System.out.println("---------------------------");

        for (String ogrenci : ogrenciler) {
            System.out.println(ogrenci);
        }
    }
}
