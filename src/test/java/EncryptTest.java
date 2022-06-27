import com.schedule.util.Util;


import net.minidev.json.parser.JSONParser;
import net.minidev.json.parser.ParseException;
import org.json.JSONObject;
import org.junit.Test;

import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.Map;

public class EncryptTest {

    @Test
    public void EncryptTest() throws Exception {

        String encryptPw = "";

        encryptPw = Util.digestStringSHA256("abcd1234!");

        System.out.println(encryptPw);

    }

}
