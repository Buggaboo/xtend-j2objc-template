package com.example.xtend.wiki

import com.example.xtend.http.HttpResponse
import com.example.xtend.http.HttpRequest
import org.junit.Test
import org.json.JSONObject
import java.util.Date

import static org.junit.Assert.*

import static com.example.xtend.wiki.WikiQuotesService.*
import com.example.xtend.http.HttpRequestBase
import java.util.Map

/**
 * Created by jasmsison on 25/02/16.
 */
class ShareWikiQuotesTest {

    static def String formatDebugMessage(HttpResponse rp, Exception e)
    {
        String.format("code (%s), %s, %s", rp.code, rp.headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString)
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