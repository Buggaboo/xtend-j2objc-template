package com.example.xtend

import io.mikael.urlbuilder.UrlBuilder
import com.example.xtend.http.HttpResponse
import com.example.xtend.http.HttpRequest
import org.junit.Test
import org.json.JSONObject

import static org.junit.Assert.*

// These tests are especially tailored for android
import android.test.AndroidTestCase

class SharedTest {

    @Test
    public def testSomeObject() throws Exception {
        assertTrue("Test parse a JSON object model",
		new SomeObject(new JSONObject('{ "a":"a", "b": "b"}')).a.equals('a'))
    }

}
