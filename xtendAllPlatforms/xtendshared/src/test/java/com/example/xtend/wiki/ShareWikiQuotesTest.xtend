package com.example.xtend.wiki

import com.example.xtend.http.HttpResponse
import com.example.xtend.http.HttpRequest
import com.example.xtend.http.HttpRp
import com.example.xtend.http.HttpRq
import com.example.xtend.http.HttpRequest.Response
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

    public static def String formatDebugMessage(HttpResponse rp, Exception e)
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

    @Test
    def testXtendOpenSearch() throws Exception
    {
        openSearch(new Response([rq,rp|], [rq,rp,e| fail(formatDebugMessage(rp,e))]), 'Michael+Jackson')
    }

    @Test
    def testXtendQueryTitles() throws Exception
    {
        queryTitles(new Response([rq,rp|], [rq,rp,e| fail(formatDebugMessage(rp,e))]), 'Buddha')
    }

    @Test
    def testXtendParseSections() throws Exception
    {
        parseSections(new Response([rq,rp|], [rq,rp,e| fail(formatDebugMessage(rp,e))]), '125737')
    }

    @Test
    def testXtendParsePage() throws Exception
    {
        parsePage(new Response([rq,rp|], [rq,rp,e| fail(formatDebugMessage(rp,e))]), '7081')
    }

}

class SharedWikiQuotesTestNewApproachTest
{
    public static def String formatDebugMessage(HttpRp rp, Exception e)
    {
        String.format("code (%s), %s, %s", rp.code, rp.headers.entrySet.map [ it.key + ':' + it.value ].join("\n"), e?.toString)
    }

    @Test
    def testXtendOpenSearchNewApproach() throws Exception
    {
        var (HttpRq, HttpRp) => void success = [rq, rp|]
        var (HttpRq, HttpRp, Exception) => void failure = [rq, rp, e| fail(formatDebugMessage(rp,e))]
        openSearchNewApproach(success, failure, 'Michael+Jackson')
    }

    @Test
    def testXtendQueryTitlesNewApproach() throws Exception
    {
        queryTitlesNewApproach([rq,rp|], [rq,rp,e| fail(formatDebugMessage(rp,e))], 'Buddha')
    }

    @Test
    def testXtendParseSectionsNewApproach() throws Exception
    {
        parseSectionsNewApproach([rq,rp|], [rq,rp,e| fail(formatDebugMessage(rp,e))], '125737')
    }

    @Test
    def testXtendParsePageNewApproach() throws Exception
    {
        parsePageNewApproach([rq,rp|], [rq,rp,e| fail(formatDebugMessage(rp,e))], '7081')
    }
}