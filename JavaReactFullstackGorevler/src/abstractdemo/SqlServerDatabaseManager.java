package abstractdemo;

public class SqlServerDatabaseManager extends BaseDatabaseManager {

    @Override
    public void getData() {
        System.out.println("Veri getirildi: Microsoft Sql Server");
    }
}
