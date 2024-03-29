package canli6saatlikjavaprogramlamakamp;

import java.util.ArrayList;
import java.util.List;

public class Main {
    public static void main(String[] args) {
        //CreditManager creditManager = new CreditManager();
        //creditManager.add();
        //creditManager.calculate();

        //MortgageManager mortgageManager = new MortgageManager();
        //mortgageManager.add();

        CreditManager[] credits = new CreditManager[3];
        credits[0] = new MortgageManager();
        credits[1] = new VehicleManager();
        credits[2] = new OfficerManager();

        List<CreditManager> creditsList = new ArrayList<>();
        creditsList.add(new MortgageManager());
        creditsList.add(new OfficerManager());
        creditsList.add(new VehicleManager());

        for ( int i = 0; i < credits.length; i++) {
            credits[i].calculate();
        }

        for (CreditManager credit : creditsList) {
            credit.calculate();
        }
    }
}
