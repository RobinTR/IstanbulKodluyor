package staticdemo;

public class ProductValidator {

    public ProductValidator() {
        System.out.println("Constructor çalıştı.");
    }

    static {
        System.out.println("Static constructor çalıştı.");
    }

    public static boolean isValid(Product product) {
        if (product.price > 0 && !product.name.isEmpty()) {
            return true;
        } else {
            return false;
        }
    }

    public void birSey() {

    }

    //Inner Class static yapılabilir.
    //public static class BaskaBirClass {
    //    public static void sil() {

    //    }
    //}
}
