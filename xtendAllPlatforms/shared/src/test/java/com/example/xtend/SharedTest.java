package com.example.xtend;

import com.example.xtend.SomeObject;
import org.json.JSONObject;
import org.junit.Assert;
import org.junit.Test;

@SuppressWarnings("all")
public class SharedTest {
  @Test
  public void testSomeObject() throws Exception {
    JSONObject _jSONObject = new JSONObject("{ \"a\":\"a\", \"b\": \"b\"}");
    SomeObject _someObject = new SomeObject(_jSONObject);
    String _a = _someObject.getA();
    boolean _equals = _a.equals("a");
    Assert.assertTrue("Test parse a JSON object model", _equals);
  }
}
