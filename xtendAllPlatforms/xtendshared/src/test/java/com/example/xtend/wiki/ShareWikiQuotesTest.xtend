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
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                fail(e.toString)
            }
        }, 'George+Washington', time)
    }

    @Test
    def testQueryTitles() throws Exception
    {
        queryTitles(new HttpResponse()
        {
            override onSuccess(HttpRequestBase request) {
                assertNotNull(body)
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                fail(e.toString)
            }
        }, 'George+Washington', time)
    }

    @Test
    def testParseSections() throws Exception
    {
        parseSections(new HttpResponse()
        {
            override onSuccess(HttpRequestBase request) {
                assertNotNull(body)
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                fail(e.toString)
            }
        }, '125733', time)
    }

    @Test
    def testParsePage() throws Exception
    {
        parsePage(new HttpResponse()
        {
            override onSuccess(HttpRequestBase request) {
                assertNotNull(body)
                println(body)
            }

            override onError(HttpRequestBase request, Exception e) {
                fail(e.toString)
            }
        }, '7051', time)
    }

}