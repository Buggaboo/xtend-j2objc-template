package com.example.xtend.wiki

import static extension com.example.xtend.wiki.WikiQuotesService.*

import com.example.xtend.http.HttpRequest
import com.example.xtend.http.HttpResponse
import static extension com.example.xtend.http.HttpRq.*
import com.example.xtend.http.HttpRq
import com.example.xtend.http.HttpRp
import java.util.Map
import static java.net.URLEncoder.*


/** OkHttp */
import okhttp3.MediaType
import okhttp3.OkHttpClient
import okhttp3.Request
import okhttp3.RequestBody
import okhttp3.Response
import okhttp3.Callback


/**
 * Created by jasmsison on 25/02/16.
 *
 * Inspired by: https://github.com/natetyler/wikiquotes-api
 *
 * TODO create n degree mashup
 */

class WikiQuotesService {

    // a url builder, which makes one wonder why we need a whole library for it
    static def String addParameters (String startUrl, Map<String, String> parameters)
    {
        val builder = new StringBuilder
        builder.append(startUrl + '?')
        parameters.entrySet.forEach [ builder.append(encode(it.key, 'UTF-8')).append('=').append(encode(it.value, 'UTF-8')).append('&') ]

        val output = builder.toString
        val outputLen = output.length
        // trim off the last ampersand
        output.substring(0, outputLen-1)
    }

    static val sServer    = 'https://en.wikiquote.org' // TODO determine if this fixes anything
    static val sPath      = '/w/api.php'

    static val sUserAgent = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0'

    static val sPartialUrl = sServer + sPath
    /*
    request GET /w/api.php
          GET /w/api.php?format=json&action=opensearch&namespace=0&suggest=&search=George+Washington&_=1456325527972 HTTP/1.1
        Host: en.wikiquote.org
        User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0
        Accept: * / *
    Accept-Language: nl,en-US;q=0.7,en;q=0.3
    Accept-Encoding: gzip, deflate
    Referer: http://natetyler.github.io/
    Cookie: WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4
    DNT: 1
    Connection: keep-alive
    response
    HTTP/1.1 200 OK
    Server: nginx/1.9.4
    Date: Wed, 24 Feb 2016 15:18:23 GMT
    Content-Type: text/javascript; charset=utf-8
    Content-Length: 526
    Connection: keep-alive
    X-Powered-By: HHVM/3.6.5
    X-Content-Type-Options: nosniff
    Cache-control: max-age=10800, s-maxage=10800, public
X-Frame-Options: DENY
Vary: Accept-Encoding,X-Forwarded-Proto,Cookie,Authorization
Expires: Wed, 24 Feb 2016 18:18:23 GMT
Content-Encoding: gzip
Backend-Timing: D=67564 t=1456327103147445
X-Varnish: 4043010823, 52279670, 2570229133
Via: 1.1 varnish, 1.1 varnish, 1.1 varnish
Accept-Ranges: bytes
Age: 0
X-Cache: cp1066 miss(0), cp3012 miss(0), cp3008 frontend miss(0)
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Analytics: WMF-Last-Access=24-Feb-2016;https=1
X-Client-IP: 87.213.22.20*/

    public static def String getOpenSearchUrl(String who)
    {
        sPartialUrl.addParameters(
                #{
                    'format' -> 'json'
                    , 'action' -> 'opensearch'
                    , 'namespace' -> '0' // ?
                    , 'suggest' -> '' // ?
                    , 'search' -> who // George+Washington
                }
        )
    }

    // sugared up
    public static def void openSearch(HttpResponse response, String who)
    {

        new HttpRequest(who.openSearchUrl).addHeaders(
            #{
                'User-Agent'-> sUserAgent
                , 'Accept'-> '*/*'
                , 'Accept-Language'-> 'nl,en-US;q=0.7,en;q=0.3'
                , 'Accept-Encoding'-> 'gzip, deflate'
                , 'Referer'-> 'http://natetyler.github.io/'
                , 'Cookie'-> 'WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4'
                , 'DNT'-> '1' // ?
            }
        ).execute(response)
    }

    public static def HttpRq openSearchCompositional(String who)
    {
        new HttpRq(who.openSearchUrl).addHeaders(
            #{
                'User-Agent'-> sUserAgent
                , 'Accept'-> '*/*'
                , 'Accept-Language'-> 'nl,en-US;q=0.7,en;q=0.3'
                , 'Accept-Encoding'-> 'gzip, deflate'
                , 'Referer'-> 'http://natetyler.github.io/'
                , 'Cookie'-> 'WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4'
                , 'DNT'-> '1' // ?
            }
        )
    }

    public static def void openSearchSh(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String who)
    {
        who.openSearchCompositional.sh(onSuccess, onError)
    }

    public static def void openSearchShoot(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String who)
    {
        who.openSearchCompositional.shoot(onSuccess, onError)
    }

/*
request GET /w/api.php
      GET /w/api.php?callback=jQuery20203228909498638296_1456325527966&format=json&action=query&redirects=&titles=George+Washington&_=1456325527973 HTTP/1.1
	Host: en.wikiquote.org
	User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0
	Accept: * / *
Accept-Language: nl,en-US;q=0.7,en;q=0.3
Accept-Encoding: gzip, deflate
Referer: http://natetyler.github.io/
Cookie: WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4
DNT: 1
Connection: keep-alive
response
HTTP/1.1 200 OK
Server: nginx/1.9.4
Date: Wed, 24 Feb 2016 15:18:23 GMT
Content-Type: text/javascript; charset=utf-8
Content-Length: 145
Connection: keep-alive
X-Powered-By: HHVM/3.6.5
X-Content-Type-Options: nosniff
Cache-control: private, must-revalidate, max-age=0
X-Frame-Options: DENY
Vary: Accept-Encoding,X-Forwarded-Proto,Cookie,Authorization
Content-Encoding: gzip
Backend-Timing: D=28366 t=1456327103338997
X-Varnish: 744420921, 3839457073, 2570231325
Via: 1.1 varnish, 1.1 varnish, 1.1 varnish
Accept-Ranges: bytes
Age: 0
X-Cache: cp1052 miss+chfp(0), cp3040 miss+chfp(0), cp3008 frontend miss+chfp(0)
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Analytics: WMF-Last-Access=24-Feb-2016;https=1
X-Client-IP: 87.213.22.20*/



    public static def String getQueryTitlesUrl(String titles)
    {
        sPartialUrl.addParameters(#{
            'format' -> 'json'
            , 'action' -> 'query'
            , 'redirects' -> ''
            , 'titles' -> titles
        })
    }

    public static def void queryTitles(HttpResponse response, String titles)
    {
        new HttpRequest(titles.queryTitlesUrl)
        .addHeader('User-Agent', sUserAgent)
        .addHeader('Accept', '*/*')
        .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
        .addHeader('Accept-Encoding','gzip, deflate')
        .addHeader('Referer','http://natetyler.github.io/')
        .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
        .addHeader('DNT','1')
        .addHeader('Connection','keep-alive')
        .execute(response)
    }

    public static def HttpRq queryTitlesCompositional(String titles)
    {
        new HttpRq(titles.queryTitlesUrl).addHeaders(#{
            'User-Agent' -> sUserAgent
            , 'Accept' -> '*/*'
            , 'Accept-Language' -> 'nl,en-US;q=0.7,en;q=0.3'
            , 'Accept-Encoding' -> 'gzip, deflate'
            , 'Referer' -> 'http://natetyler.github.io/'
            , 'Cookie' -> 'WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4'
            , 'DNT' -> '1'
            , 'Connection' -> 'keep-alive'
        })
    }

    public static def void queryTitlesSh(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String titles)
    {
        titles.queryTitlesCompositional.sh(onSuccess, onError)
    }

    public static def void queryTitlesShoot(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String titles)
    {
        titles.queryTitlesCompositional.shoot(onSuccess, onError)
    }

/*
request GET /w/api.php
      GET /w/api.php?callback=jQuery20203228909498638296_1456325527966&format=json&action=parse&prop=sections&pageid=125733&_=1456325527974 HTTP/1.1
	Host: en.wikiquote.org
	User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0
	Accept: * / *
Accept-Language: nl,en-US;q=0.7,en;q=0.3
Accept-Encoding: gzip, deflate
Referer: http://natetyler.github.io/
Cookie: WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4
DNT: 1
Connection: keep-alive
response
HTTP/1.1 200 OK
Server: nginx/1.9.4
Date: Wed, 24 Feb 2016 15:18:23 GMT
Content-Type: text/javascript; charset=utf-8
Content-Length: 751
Connection: keep-alive
X-Powered-By: HHVM/3.6.5
X-Content-Type-Options: nosniff
Cache-control: private, must-revalidate, max-age=0
X-Frame-Options: DENY
Vary: Accept-Encoding,X-Forwarded-Proto,Cookie,Authorization
Content-Encoding: gzip
Backend-Timing: D=56584 t=1456327103496566
X-Varnish: 605713336, 4196973043, 2570233141
Via: 1.1 varnish, 1.1 varnish, 1.1 varnish
Accept-Ranges: bytes
Age: 0
X-Cache: cp1065 miss+chfp(0), cp3041 miss+chfp(0), cp3008 frontend miss+chfp(0)
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Analytics: WMF-Last-Access=24-Feb-2016;https=1
X-Client-IP: 87.213.22.20*/
    public static def String getParseSectionsUrl(String pageId)
    {
        sPartialUrl.addParameters(#{
            'format' -> 'json'
            , 'action' -> 'parse'
            , 'prop' -> 'sections'
            , 'pageid' -> pageId
        })
    }

    public static def void parseSections(HttpResponse response, String pageId)
    {
        new HttpRequest(pageId.parseSectionsUrl)
        .addHeader('User-Agent', sUserAgent)
        .addHeader('Accept', '*/*')
        .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
        .addHeader('Accept-Encoding','gzip, deflate')
        .addHeader('Referer','http://natetyler.github.io/')
        .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
        .addHeader('DNT','1')

        .execute(response)
    }

    public static def HttpRq parseSectionsCompositional(String pageId)
    {
        new HttpRq(pageId.parseSectionsUrl).addHeaders(#{
            'User-Agent' -> sUserAgent
            , 'Accept' -> '*/*'
            , 'Accept-Language' -> 'nl,en-US;q=0.7,en;q=0.3'
            , 'Accept-Encoding' -> 'gzip, deflate'
            , 'Referer' -> 'http://natetyler.github.io/'
            , 'Cookie' -> 'WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4'
            , 'DNT' -> '1'
        })
    }

    public static def void parseSectionsSh(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String pageId)
    {
        pageId.parseSectionsCompositional.sh(onSuccess, onError)
    }

    public static def void parseSectionsShoot(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String pageId)
    {
        pageId.parseSectionsCompositional.shoot(onSuccess, onError)
    }

/*
request GET /w/api.php
      GET /w/api.php?callback=jQuery20203228909498638296_1456325527948&format=json&action=parse&noimages=&pageid=7051&section=1&_=1456325527979 HTTP/1.1
	Host: en.wikiquote.org
	User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0
	Accept: * / *
Accept-Language: nl,en-US;q=0.7,en;q=0.3
Accept-Encoding: gzip, deflate
Referer: http://natetyler.github.io/
Cookie: WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4
DNT: 1
Connection: keep-alive
response
HTTP/1.1 200 OK
Server: nginx/1.9.4
Date: Wed, 24 Feb 2016 15:18:24 GMT
Content-Type: text/javascript; charset=utf-8
Content-Length: 3465
Connection: keep-alive
X-Powered-By: HHVM/3.6.5
X-Content-Type-Options: nosniff
Cache-control: private, must-revalidate, max-age=0
X-Frame-Options: DENY
Vary: Accept-Encoding,X-Forwarded-Proto,Cookie,Authorization
Content-Encoding: gzip
Backend-Timing: D=92244 t=1456327104169795
X-Varnish: 959017461, 252719391, 2570240893
Via: 1.1 varnish, 1.1 varnish, 1.1 varnish
Accept-Ranges: bytes
Age: 0
X-Cache: cp1068 miss+chfp(0), cp3006 miss+chfp(0), cp3008 frontend miss+chfp(0)
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Analytics: WMF-Last-Access=24-Feb-2016;https=1
X-Client-IP: 87.213.22.20*/


    public static def String getParsePageUrl(String pageId)
    {
        sPartialUrl.addParameters(#{
            'format' -> 'json'
            , 'action' -> 'parse'
            , 'noimages' -> ''
            , 'pageid' -> pageId
            , 'section' -> '1' // TODO randomize?
        })
    }

    public static def void parsePage(HttpResponse response, String pageId)
    {
        new HttpRequest(pageId.parsePageUrl)
        .addHeader('User-Agent', sUserAgent)
        .addHeader('Accept', '*/*')
        .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
        .addHeader('Accept-Encoding','gzip, deflate')
        .addHeader('Referer','http://natetyler.github.io/')
        .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
        .addHeader('DNT','1')
        .execute(response)
    }

    public static def HttpRq parsePageCompositional(String pageId)
    {
        new HttpRq(pageId.parsePageUrl).addHeaders(#{
            'User-Agent' -> sUserAgent
            , 'Accept' -> '*/*'
            , 'Accept-Language' -> 'nl,en-US;q=0.7,en;q=0.3'
            , 'Accept-Encoding' -> 'gzip, deflate'
            , 'Referer' -> 'http://natetyler.github.io/'
            , 'Cookie' -> 'WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4'
            , 'DNT' -> '1'
        })
    }

    public static def void parsePageSh(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String pageId)
    {
        parsePageCompositional(pageId).sh(onSuccess, onError)
    }

    public static def void parsePageShoot(
            (HttpRq, HttpRp)=>void onSuccess,
            (HttpRq, HttpRp, Exception)=>void onError, String pageId)
    {
        pageId.parsePageCompositional.shoot(onSuccess, onError)
    }


}



class WikiQuotesServiceOkHttp {

    public static def void openSearch(Callback callback, String who)
    {
        val client = new OkHttpClient

        val req = new Request.Builder()
            .url(who.openSearchUrl)
            .addHeader('Host','en.wikiquote.org')
            .addHeader('User-Agent','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0')
            .addHeader('Accept','*/*')
            .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
            .addHeader('Accept-Encoding','gzip, deflate')
            .addHeader('Referer','http://natetyler.github.io/')
            .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
            .addHeader('DNT','1')
            .addHeader('Connection','keep-alive')
            .build

        client.newCall(req).enqueue(callback)
    }

    /*
request GET /w/api.php
      GET /w/api.php?callback=jQuery20203228909498638296_1456325527948&format=json&action=query&redirects=&titles=Keith+Richards&_=1456325527977 HTTP/1.1
	Host: en.wikiquote.org
	User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0
	Accept: * / *
Accept-Language: nl,en-US;q=0.7,en;q=0.3
Accept-Encoding: gzip, deflate
Referer: http://natetyler.github.io/
Cookie: WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4
DNT: 1
Connection: keep-alive
response
HTTP/1.1 200 OK
Server: nginx/1.9.4
Date: Wed, 24 Feb 2016 15:18:23 GMT
Content-Type: text/javascript; charset=utf-8
Content-Length: 141
Connection: keep-alive
X-Powered-By: HHVM/3.6.5
X-Content-Type-Options: nosniff
Cache-control: private, must-revalidate, max-age=0
X-Frame-Options: DENY
Vary: Accept-Encoding,X-Forwarded-Proto,Cookie,Authorization
Content-Encoding: gzip
Backend-Timing: D=36718 t=1456327103815181
X-Varnish: 1381578792, 1219557941, 2570236933
Via: 1.1 varnish, 1.1 varnish, 1.1 varnish
Accept-Ranges: bytes
Age: 0
X-Cache: cp1053 miss+chfp(0), cp3010 miss+chfp(0), cp3008 frontend miss+chfp(0)
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Analytics: WMF-Last-Access=24-Feb-2016;https=1
X-Client-IP: 87.213.22.20*/
/*
    public static def void queryTitles(HttpResponse response)
    {
    val urlBuilder = UrlBuilder.fromString(mServer).withPath("/w/api.php")
    .addParameter('format', 'json')
    .addParameter('action', 'query')
    .addParameter('redirects', '')
    .addParameter('titles', 'Keith+Richards')
    val req = new HttpRequest(urlBuilder.toString)
    .addHeader('Host','en.wikiquote.org')
    .addHeader('User-Agent','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0')
    .addHeader('Accept','* / *')
    .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
    .addHeader('Accept-Encoding','gzip, deflate')
    .addHeader('Referer','http://natetyler.github.io/')
    .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
    .addHeader('DNT','1')
    .addHeader('Connection','keep-alive')

    req.execute(response)
    }
*/
    
    /*
request GET /w/api.php
      GET /w/api.php?callback=jQuery20203228909498638296_1456325527948&format=json&action=parse&prop=sections&pageid=7051&_=1456325527978 HTTP/1.1
	Host: en.wikiquote.org
	User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0
	Accept: * / *
Accept-Language: nl,en-US;q=0.7,en;q=0.3
Accept-Encoding: gzip, deflate
Referer: http://natetyler.github.io/
Cookie: WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4
DNT: 1
Connection: keep-alive
response
HTTP/1.1 200 OK
Server: nginx/1.9.4
Date: Wed, 24 Feb 2016 15:18:24 GMT
Content-Type: text/javascript; charset=utf-8
Content-Length: 260
Connection: keep-alive
X-Powered-By: HHVM/3.6.5
X-Content-Type-Options: nosniff
Cache-control: private, must-revalidate, max-age=0
X-Frame-Options: DENY
Vary: Accept-Encoding,X-Forwarded-Proto,Cookie,Authorization
Content-Encoding: gzip
Backend-Timing: D=32928 t=1456327103985540
X-Varnish: 1381582061, 631002454, 2570238785
Via: 1.1 varnish, 1.1 varnish, 1.1 varnish
Accept-Ranges: bytes
Age: 0
X-Cache: cp1053 miss+chfp(0), cp3014 miss+chfp(0), cp3008 frontend miss+chfp(0)
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Analytics: WMF-Last-Access=24-Feb-2016;https=1
X-Client-IP: 87.213.22.20*/
/*
    public static def void parseSections(HttpResponse response)
    {
    val urlBuilder = UrlBuilder.fromString(mServer).withPath("/w/api.php")
    .addParameter('format', 'json')
    .addParameter('action', 'parse')
    .addParameter('prop', 'sections')
    .addParameter('pageid', '7051')
    val req = new HttpRequest(urlBuilder.toString)
    .addHeader('Host','en.wikiquote.org')
    .addHeader('User-Agent','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0')
    .addHeader('Accept','* / *')
    .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
    .addHeader('Accept-Encoding','gzip, deflate')
    .addHeader('Referer','http://natetyler.github.io/')
    .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
    .addHeader('DNT','1')
    .addHeader('Connection','keep-alive')

    req.execute(response)
    }
*/

    /*
request GET /w/api.php
      GET /w/api.php?callback=jQuery20203228909498638296_1456325527948&format=json&action=parse&noimages=&pageid=7051&section=1&_=1456325527979 HTTP/1.1
	Host: en.wikiquote.org
	User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0
	Accept: * / *
Accept-Language: nl,en-US;q=0.7,en;q=0.3
Accept-Encoding: gzip, deflate
Referer: http://natetyler.github.io/
Cookie: WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4
DNT: 1
Connection: keep-alive
response
HTTP/1.1 200 OK
Server: nginx/1.9.4
Date: Wed, 24 Feb 2016 15:18:24 GMT
Content-Type: text/javascript; charset=utf-8
Content-Length: 3465
Connection: keep-alive
X-Powered-By: HHVM/3.6.5
X-Content-Type-Options: nosniff
Cache-control: private, must-revalidate, max-age=0
X-Frame-Options: DENY
Vary: Accept-Encoding,X-Forwarded-Proto,Cookie,Authorization
Content-Encoding: gzip
Backend-Timing: D=92244 t=1456327104169795
X-Varnish: 959017461, 252719391, 2570240893
Via: 1.1 varnish, 1.1 varnish, 1.1 varnish
Accept-Ranges: bytes
Age: 0
X-Cache: cp1068 miss+chfp(0), cp3006 miss+chfp(0), cp3008 frontend miss+chfp(0)
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
X-Analytics: WMF-Last-Access=24-Feb-2016;https=1
X-Client-IP: 87.213.22.20*/
/*
    public static def void parsePage(HttpResponse response)
    {
        val urlBuilder = UrlBuilder.fromString(mServer).withPath("/w/api.php")
        .addParameter('format', 'json')
        .addParameter('action', 'parse')
        .addParameter('noimages', '')
        .addParameter('pageid', '7051')
        .addParameter('section', '1')
        val req = new HttpRequest(urlBuilder.toString)
        .addHeader('Host','en.wikiquote.org')
        .addHeader('User-Agent','Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:43.0) Gecko/20100101 Firefox/43.0')
        .addHeader('Accept','* / *')
        .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
        .addHeader('Accept-Encoding','gzip, deflate')
        .addHeader('Referer','http://natetyler.github.io/')
        .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
        .addHeader('DNT','1')
        .addHeader('Connection','keep-alive')

        req.execute(response)
    }
*/
}