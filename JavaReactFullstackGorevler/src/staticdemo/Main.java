package staticdemo;

public class Main {
    public static void main(String[] args) {
        Product product = new Product();
        product.price = 10;
        product.name = "";

        ProductManager productManager = new ProductManager();
        productManager.add(product);
    }
}
