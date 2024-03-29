package multidimensionalarraydemo;

public class MultiDimensionalArrayDemo {
    public static void main(String[] args) {
        String[][] sehirler = new String[3][3];
        sehirler[0][0] = "İstanbul";
        sehirler[0][1] = "Bursa";
        sehirler[0][2] = "Bilecik";
        sehirler[1][0] = "Ankara";
        sehirler[1][1] = "Konya";
        sehirler[1][2] = "Kayseri";
        sehirler[2][0] = "Diyarbakır";
        sehirler[2][1] = "Mardin";
        sehirler[2][2] = "Şanlıurfa";

        /*for (String[] bolge : sehirler) {
            for (String sehir : bolge) {
                System.out.println(sehir);
            }
        }

        for(int i = 0; i <= 2; i++) {
            for(int j = 0; j <= 2; j++) {
                System.out.println(sehirler[i][j]);
            }
        }
        */
        for (int i = 0; i < sehirler.length; i++) {
            System.out.println("----------------------");
            for (int j = 0; j < sehirler[i].length; j++) {
                System.out.println(sehirler[i][j]);
            }
        }
    }
}
