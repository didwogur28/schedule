import org.jasypt.encryption.pbe.StandardPBEStringEncryptor;
import org.junit.Test;

public class ContainTest {

    @Test
    public void containTest() {

        String url = "sch/goLogin";

        if(url.contains("Login")) {
            System.out.println("SUCCESS");
        }

    }
}
