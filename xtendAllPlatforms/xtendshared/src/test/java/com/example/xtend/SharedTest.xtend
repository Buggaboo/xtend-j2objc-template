package com.example.xtend

import io.mikael.urlbuilder.UrlBuilder
import com.example.xtend.http.HttpResponse
import com.example.xtend.http.HttpRequest
import org.junit.Test
import org.json.JSONObject

import static org.junit.Assert.*
import com.example.xtend.http.HttpRequestBase

// These tests are especially tailored for android
import android.test.AndroidTestCase
import android.util.Log
import org.xtendroid.json.AndroidJsonized

class SharedTest /*extends AndroidTestCase*/ {

    @Test
    public def testSomeObject() throws Exception {
        assertTrue("Test parse a JSON object model",
		new SomeObject(new JSONObject('{ "a":"a", "b": "b"}')).a.equals('a'))
    }

}

@AndroidJsonized("{\"batchcomplete\":\"\",\"query\":{\"pages\": {\"placeholder_for_page_def\":\"meh this is a string\"}}}")
class WikiPediaGeneral {}

@AndroidJsonized("{\"pageid\":15580374,\"ns\":0,\"title\":\"Main Page\",\"revisions\":[{\"contentformat\":\"text/x-wiki\",\"contentmodel\":\"wikitext\"}]}")
class WikiPediaPage {}

class SharedHttpTest {

    @Test
    public def testCallToWikiPediaRestService ()
    {
        val urlBuilder = UrlBuilder.fromString('https://en.wikipedia.org')
        .withPath('/w/api.php')
        .addParameter('action', 'query')
        .addParameter('titles', 'Main Page')
        .addParameter('prop', 'revisions')
        .addParameter('rvprop', 'content')
        .addParameter('format', 'json')
        val req = new HttpRequest(urlBuilder.toString)
        req.execute(new HttpResponse () {

            override onSuccess(HttpRequestBase request) {
//                Log.d("Hello", String.format("%s produces %s", req.urlString, body)) // can't transpile this, so avoid this code
                assertNotNull(String.format("response (%s): %s", body.substring(5), code), body)
            }

            override onError(HttpRequestBase request, Exception e) {
                if (!body.isNullOrEmpty)
                {
                    fail(body)
                }

                if (e != null)
                {
                    fail(e.message)
                }
            }
        })
    }
}
