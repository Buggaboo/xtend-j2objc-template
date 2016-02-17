package com.example.xtend

import org.junit.Test
import org.json.JSONObject

import static org.junit.Assert.*

class SharedTest {

    @Test
    public def testSomeObject() throws Exception {
        assertTrue("Test parse a JSON object model",
		new SomeObject(new JSONObject('{ "a":"a", "b": "b"}')).a.equals('a'))
    }

}
