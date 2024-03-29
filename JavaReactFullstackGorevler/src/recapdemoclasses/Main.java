package recapdemoclasses;

public class Main {
    public static void main(String[] args) {
        DortIslem dortIslem = new DortIslem();
        int sonuc = dortIslem.topla(3, 4);
        double sonuc2 = dortIslem.bol(5, 2);

        System.out.println(sonuc);
        System.out.println(sonuc2);
    }
}
