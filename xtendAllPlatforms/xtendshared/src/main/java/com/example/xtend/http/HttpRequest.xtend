package com.example.xtend.http

import java.net.URL
import java.net.HttpURLConnection
import static java.net.HttpURLConnection.*
import java.io.OutputStreamWriter
import java.io.InputStreamReader
import java.io.BufferedReader

import java.util.Map
import java.util.List

import org.eclipse.xtend.lib.annotations.Accessors
import org.eclipse.xtend.lib.annotations.Data

import com.example.xtend.http.HttpRequestBase


abstract class HttpResponse
{
    @Accessors
    int code

    @Accessors
    String body

    @Accessors
    protected Map<String, List<String>> headers

    def void onSuccess(HttpRequestBase request)
    def void onError(HttpRequestBase request, Exception e)
}

abstract class HttpRequestBase
{
    @Accessors
    protected String method = 'GET'

    @Accessors
    protected String urlString

    @Accessors
    protected val headers = #{'User-Agent' -> 'github.com:Buggaboo/xtend-j2objc-template'}

    @Accessors
    protected String postData

    @Accessors
    protected boolean useCaches = false

    // TODO experiment!
    protected val CONNECT_TIMEOUT = 10000
    protected val READ_TIMEOUT    = 10000

    @Accessors
    protected boolean closeConnectionAfterUse = false

    public def HttpRequestBase withMethod(String method)
    {
        this.method = method
        this
    }

    public def HttpRequestBase addHeader(String key, String value)
    {
        headers.put(key, value)
        this
    }

    public def void execute(HttpResponse response)
}

class HttpRequest extends HttpRequestBase
{
    new (String urlString, String verb, String postData) {
        this.urlString = urlString
        this.method = verb
        this.postData = postData
    }

    new (String urlString) {
        this(urlString, 'GET', null)
    }

    public override execute(HttpResponse response)
    {
        val url = new URL(urlString)

        var HttpURLConnection connection = null
        try {
            connection = url.openConnection as HttpURLConnection
            for (i : headers.entrySet)
            {
                connection.addRequestProperty(i.key, i.value)
            }
        } catch(java.io.IOException e) {
            response.onError(this as HttpRequestBase, e)
        }

        try {
            connection.requestMethod = method
        } catch(java.net.ProtocolException e) {
            response.onError(this as HttpRequestBase, e)
        }

        connection.doInput = true
        connection.useCaches = useCaches

        connection.connectTimeout = CONNECT_TIMEOUT
        connection.readTimeout = READ_TIMEOUT

        try {
            if (('POST'.equals(method) || 'PUT'.equals(method)) && !postData.isNullOrEmpty)
            {
                connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded")
                connection.setRequestProperty("Content-Length", Integer.toString(postData.bytes.size))
                connection.doOutput = true
                val out = new OutputStreamWriter(connection.outputStream)
                out.write(postData)
                out.close
            }

            val in = new BufferedReader(new InputStreamReader(connection.inputStream))
            val rBuilder = new StringBuffer
            var String decodedString
            while ((decodedString = in.readLine()) != null) {
                rBuilder.append(decodedString)
            }
            in.close()

            val responseBody = rBuilder.toString.trim

            if (!responseBody.isEmpty)
            {
                response.body = responseBody
            }

            response.headers = connection.headerFields

            val code = connection.responseCode

            response.code = code

            // NOTE: code == 304, is also a happy flow
            if (HTTP_OK == code || HTTP_NOT_MODIFIED == code || HTTP_NO_CONTENT == code || HTTP_CREATED == code) {
                // handle success
                response.onSuccess(this as HttpRequestBase)
            } else {
                // handle error code
                response.onError(this as HttpRequestBase, null)
            }
        } catch(java.io.IOException e) {
            response.onError(this as HttpRequestBase, e)
        }

        if (connection != null && closeConnectionAfterUse) {
            connection.disconnect()
        }
    }
}

/*
// TODO
class VolleyRequest extends HttpRequestBase
{
    override execute()
    {

    }
}
*/