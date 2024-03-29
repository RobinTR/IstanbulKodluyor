package canli6saatlikjavaprogramlamakamp;

public class Diziler {
    public static void main(String[] args) {
        String[] sehirler0 = new String[]{"Ankara", "İstanbul", "İzmir"};

        for (String sehir : sehirler0) {
            System.out.println(sehir);
        }

        for (int i = 0; i < 3; i++) {
            System.out.println(sehirler0[i]);
        }

        String[] sehirler1 = new String[]{"Ankara", "İstanbul", "İzmir"};
        String[] sehirler2 = new String[]{"Antep", "Diyarbakır", "Urfa"};

        sehirler1 = sehirler2;
        sehirler1[0] = "Adana";
        System.out.println(sehirler2[0]);

        int sayi1 = 10;
        int sayi2 = 20;
        sayi1 = sayi2;
        sayi2 = 30;

        System.out.println(sayi1);

        //Value types: boolean, int, double...
        //Reference types: Array, class, abstract, interface
    }
}
