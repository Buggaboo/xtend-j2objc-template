package com.example.xtend.wiki

import com.example.xtend.http.HttpResponse
import com.example.xtend.http.HttpRp
import com.example.xtend.http.HttpRq
import static extension com.example.xtend.http.HttpRq.*
import org.junit.Test

import static org.junit.Assert.*

import static com.example.xtend.wiki.WikiQuotesService.*
import static com.example.xtend.wiki.WikiQuotesServiceOkHttp.*
import com.example.xtend.http.HttpRequestBase
import static com.example.xtend.wiki.SharedWikiQuotesShootTest.*

// okhttp
import okhttp3.Call
import okhttp3.Callback
import okhttp3.Request
import okhttp3.Response
import java.io.IOException


/**
 * Created by jasmsison on 25/02/16.
 */
class ShareWikiQuotesTest {

    public static def String formatDebugMessage(HttpResponse rp, Exception e)
    {
        String.format("code (%d), %s, %s", rp.code, rp.headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString)
    }

    @Test
    def testOpenSearch() throws Exception
    {
        openSearch(new HttpResponse()
        {
            override onSuccess(HttpRequestBase request) {
                assertNotNull(body)
                println(String.format("%s %s", request.method, request.urlString))
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                println(formatDebugMessage(e))
                fail(formatDebugMessage(e))
            }
        }, 'George+Washington')
    }

    @Test
    def testQueryTitles() throws Exception
    {
        queryTitles(new HttpResponse()
        {
            override onSuccess(HttpRequestBase request) {
                assertNotNull(body)
                println(String.format("%s %s", request.method, request.urlString))
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                println(formatDebugMessage(e))
                fail(formatDebugMessage(e))
            }
        }, 'George+Washington')
    }

    @Test
    def testParseSections() throws Exception
    {
        parseSections(new HttpResponse()
        {
            override onSuccess(HttpRequestBase request) {
                assertNotNull(body)
                println(String.format("%s %s", request.method, request.urlString))
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                println(formatDebugMessage(e))
                fail(formatDebugMessage(e))
            }
        }, '125733')
    }

    @Test
    def testParsePage() throws Exception
    {
        parsePage(new HttpResponse()
        {
            override onSuccess(HttpRequestBase request) {
                assertNotNull(body)
                println(String.format("%s %s", request.method, request.urlString))
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                println(formatDebugMessage(e))
                fail(formatDebugMessage(e))
            }
        }, '7051')
    }
}

class SharedWikiQuotesShootTest
{

    public static def String formatDebugMessage(HttpRp rp, Exception e)
    {
        //String.format("code (%d), %s, %s", rp.code, rp?.headers?.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString)
        String.format("code (%d), %s", rp.code, e?.toString)
    }

    public static def String formatDebugMessage(HttpRp rp)
    {
        String.format("code (%d), %s, %s", rp.code, rp?.headers?.entrySet.map [ it.key + ':' + it.value ].join("\n"), rp?.body)
    }

    @Test
    def testOpenSearch() throws Exception
    {
        openSearchShoot([rq,rp| println(formatDebugMessage(rp)) ], [rq,rp,e| fail(rp.formatDebugMessage(e))], 'Michael+Jackson')
    }

    @Test
    def testQueryTitles() throws Exception
    {
        queryTitlesShoot([rq,rp| println(formatDebugMessage(rp)) ], [rq,rp,e| fail(rp.formatDebugMessage(e))], 'Buddha')
    }

    @Test
    def testParseSections() throws Exception
    {
        parseSectionsShoot([rq,rp| println(formatDebugMessage(rp)) ], [rq,rp,e| fail(rp.formatDebugMessage(e))], '125737')
    }

    @Test
    def testParsePage() throws Exception
    {
        parsePageShoot([rq,rp| println(formatDebugMessage(rp)) ], [rq,rp,e| fail(rp.formatDebugMessage(e))], '7081')
    }
}

class SharedWikiQuotesShTest
{
    @Test
    def testOpenSearch() throws Exception
    {
        var (HttpRq, HttpRp) => void success = [rq, rp| println(formatDebugMessage(rp)) ]
        var (HttpRq, HttpRp, Exception) => void failure = [rq, rp, e| fail(formatDebugMessage(rp,e))]
        openSearchSh(success, failure, 'Michael+Jackson')
    }

    @Test
    def testQueryTitles() throws Exception
    {
        queryTitlesSh([rq,rp|println(formatDebugMessage(rp))], [rq,rp,e| fail(formatDebugMessage(rp,e))], 'Buddha')
    }

    @Test
    def testParseSections() throws Exception
    {
        parseSectionsSh([rq,rp|println(formatDebugMessage(rp))], [rq,rp,e| fail(formatDebugMessage(rp, e))], '125737')
    }

    @Test
    def testParsePage() throws Exception
    {
        parsePageSh([rq,rp|println(formatDebugMessage(rp))], [rq,rp,e| fail(formatDebugMessage(rp,e))], '7081')
    }
}

class SharedWikiQuotesOkHttpTest {
    @Test
    def testOpenSearch() throws Exception
    {
        /**
            client.newCall(request).enqueue(new Callback() {
      @Override public void onFailure(Request request, IOException throwable) {
        throwable.printStackTrace();
      }

      @Override public void onResponse(Response response) throws IOException {
        if (!response.isSuccessful()) throw new IOException("Unexpected code " + response);

        Headers responseHeaders = response.headers();
        for (int i = 0; i < responseHeaders.size(); i++) {
          System.out.println(responseHeaders.name(i) + ": " + responseHeaders.value(i));
        }

        System.out.println(response.body().string());
      }
    });
        */
        openSearch(new Callback () {
            override void onFailure(Call call, IOException throwable) {
                throwable.printStackTrace()
            }

            override void onResponse (Call call, Response response) throws IOException {
/*
                if (!response.isSuccessful) throw new IOException("Unexpected code " + response);

                Headers responseHeaders = response.headers
                for (var i = 0; i < responseHeaders.size; i++) {
                    println(responseHeaders.name(i) + ": " + responseHeaders.value(i))
                }
                println(response.body.string)
*/
            }
        }, 'Madonna')
    }

}