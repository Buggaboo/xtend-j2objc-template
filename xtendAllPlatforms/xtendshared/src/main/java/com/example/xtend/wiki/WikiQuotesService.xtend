package com.example.xtend.wiki

import com.example.xtend.http.HttpRequest
import com.example.xtend.http.HttpResponse
import java.util.Map
import static java.net.URLEncoder.*

/**
 * Created by jasmsison on 25/02/16.
 *
 * Inspired by: https://github.com/natetyler/wikiquotes-api
 *
 * TODO create n degree mashup
 */

class WikiQuotesService {

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

    // sugared up
    public static def void openSearch(HttpResponse response, String who)
    {
        val urlBuilder = sPartialUrl.addParameters(
                #{
                    'format' -> 'json'
                    , 'action' -> 'opensearch'
                    , 'namespace' -> '0' // ?
                    , 'suggest' -> '' // ?
                    , 'search' -> who // George+Washington
                }
        )

        new HttpRequest(urlBuilder).addHeaders(
            #{
                'User-Agent'-> sUserAgent
                , 'Accept'-> '*/*'
                , 'Accept-Language'-> 'nl,en-US;q=0.7,en;q=0.3'
                , 'Accept-Encoding'-> 'gzip, deflate'
                , 'Referer'-> 'http://natetyler.github.io/'
                , 'Cookie'-> 'WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4'
                , 'DNT'-> '1' // ?
            }
        ).execute(response as HttpResponse)
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

    // TODO shitty on android, shitty on iOS
    public static def void queryTitles(HttpResponse response, String titles)
    {
        val urlBuilder = sPartialUrl.addParameters(#{
            'format' -> 'json'
            , 'action' -> 'query'
            , 'redirects' -> ''
            , 'titles' -> titles
        })

        new HttpRequest(urlBuilder)
        .addHeader('User-Agent', sUserAgent)
        .addHeader('Accept', '*/*')
        .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
        .addHeader('Accept-Encoding','gzip, deflate')
        .addHeader('Referer','http://natetyler.github.io/')
        .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
        .addHeader('DNT','1')
        .addHeader('Connection','keep-alive')
        .execute(response as HttpResponse)
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
    public static def void parseSections(HttpResponse response, String pageId)
    {
        val urlBuilder = sPartialUrl.addParameters(#{
            'format' -> 'json'
            , 'action' -> 'parse'
            , 'prop' -> 'sections'
            , 'pageid' -> pageId
        })

        new HttpRequest(urlBuilder)
        .addHeader('User-Agent', sUserAgent)
        .addHeader('Accept', '*/*')
        .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
        .addHeader('Accept-Encoding','gzip, deflate')
        .addHeader('Referer','http://natetyler.github.io/')
        .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
        .addHeader('DNT','1')

        .execute(response as HttpResponse)
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

    // TODO fix on iOS, something is wrong with UrlBuilder, excellent on Android
    public static def void parsePage(HttpResponse response, String pageId)
    {
        val urlBuilder = sPartialUrl.addParameters(#{
            'format' -> 'json'
            , 'action' -> 'parse'
            , 'noimages' -> ''
            , 'pageid' -> pageId
            , 'section' -> '1' // TODO randomize?
        })

        new HttpRequest(urlBuilder)
        .addHeader('User-Agent', sUserAgent)
        .addHeader('Accept', '*/*')
        .addHeader('Accept-Language','nl,en-US;q=0.7,en;q=0.3')
        .addHeader('Accept-Encoding','gzip, deflate')
        .addHeader('Referer','http://natetyler.github.io/')
        .addHeader('Cookie','WMF-Last-Access=24-Feb-2016; GeoIP=NL:07:Amsterdam:52.37:4.89:v4')
        .addHeader('DNT','1')

        .execute(response as HttpResponse)
    }
}