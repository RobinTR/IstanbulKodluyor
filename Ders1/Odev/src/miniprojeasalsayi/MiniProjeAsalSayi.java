package miniprojeasalsayi;

public class MiniProjeAsalSayi {
    public static void main(String[] args) {
        int number = -2;
        boolean isPrime = true;

        if(number == 1) {
            System.out.println(number + " sayısı asal değildir.");
            return;
        }

        if(number < 1) {
            System.out.println("Geçersiz sayı.");
            return;
        }

        for(int i = 2; i < number; i++) {
            if(number % i == 0) {
                isPrime = false;
                break;
            }
        }

        if(isPrime) {
            System.out.println(number + " sayısı asaldır.");
        } else {
            System.out.println(number + " sayısı asal değil.");
        }
    }
}
