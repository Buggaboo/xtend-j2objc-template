package com.example.xtend.wiki

import io.mikael.urlbuilder.UrlBuilder
import com.example.xtend.http.HttpResponse
import com.example.xtend.http.HttpRequest
import org.junit.Test
import org.json.JSONObject
import java.util.Date

import static org.junit.Assert.*

import static com.example.xtend.wiki.WikiQuotesService.*
import com.example.xtend.http.HttpRequestBase

/**
 * Created by jasmsison on 25/02/16.
 */
class ShareWikiQuotesTest {

    def long getTime()
    {
        new Date().time
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

            // TODO refactor out String#format
            override onError(HttpRequestBase request, Exception e) {
                fail(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString))
                println(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString))
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
                fail(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString))
                println(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString))
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
                fail(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString))
                println(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString))
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
                fail(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n\t"), e?.toString))
                println(String.format("code (%s), %s, %s", code, headers.entrySet.map [ it.key + ':' + it.value ].join("\n\t"), e?.toString))
            }
        }, '7051')
    }

}