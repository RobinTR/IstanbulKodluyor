package overriding;

public class BaseKrediManager {
    public double hesapla(double tutar) {
        return tutar * 1.18;
    }

    //Override olmasını engellemek için final kullanılabilir.
    //public final double hesapla(double tutar) {
    //    return tutar * 1.18;
    //}
}
