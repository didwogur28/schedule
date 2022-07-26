import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.jasypt.encryption.pbe.config.SimpleStringPBEConfig;
import org.junit.Test;

public class JasyptTest {

    @Test
    public void jasyptTest() {

        StandardPBEStringEncryptor encryptor = new StandardPBEStringEncryptor();

        encryptor.setPassword("scheduleInc");
        encryptor.setAlgorithm("PBEWithMD5AndDES");

        String encId = encryptor.encrypt("sch");
        String encPassword = encryptor.encrypt("sch1234!");
        String dbName = encryptor.encrypt("schdb");
        String sndNo = encryptor.encrypt("01094648026");
        String apiKey = encryptor.encrypt("NCSTLA18CAPLYPQ0");
        String secretKey = encryptor.encrypt("B3XCQCKQIBHHJHOGW8GIP4YLOEJF5MTV");


        System.out.println("ID : " + encId);
        System.out.println("PASSWORD : " + encPassword);
        System.out.println("DBNAME : " + dbName);
        System.out.println("sndNo : " + sndNo);
        System.out.println("apiKey : " + apiKey);
        System.out.println("secretKey : " + secretKey);

    }

}
