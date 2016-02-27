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
import javax.net.ssl.HttpsURLConnection
import javax.net.ssl.SSLContext
import java.nio.charset.StandardCharsets
import java.nio.charset.Charset
import java.util.zip.GZIPInputStream

// reuse the existing datastructure for the experiment
class HttpRp extends HttpResponse
{

    override onSuccess(HttpRequestBase request) {
        throw new UnsupportedOperationException()
    }

    override onError(HttpRequestBase request, Exception e) {
        throw new UnsupportedOperationException()
    }

}

// reuse the existing datastructure for the experiment
class HttpRq extends HttpRequestBase
{
    new (String urlString, String postData) {
        this.urlString = urlString
        this.method = 'POST'
        this.postData = postData
    }

    new (String urlString) {
        this(urlString, null)
    }

    // syntactic sugar
    public static def HttpRq addHeaders(HttpRq rq, Map<String, String> headers)
    {
        rq.headers = headers
        rq
    }

    // trying a different approach
    // see if extension can be applied
    // this agrees more with ObjC method dispatch style (sorry, protocol messaging shizzle)
    public static def shoot(/*extension*/ HttpRq rq, (HttpRq, HttpRp)=>void onSuccess,
        (HttpRq, HttpRp, Exception)=>void onError)
    {
        // There must be a better way to do this...
        // oh yeah, extension, but it "cannot make a static reference to the non-static"
        val urlString = rq.urlString
        val method = rq.method
        val headers = rq.headers
        val postData = rq.postData
        val useCaches = rq.useCaches
        val closeConnectionAfterUse = rq.closeConnectionAfterUse

        val rp = new HttpRp

        val url = new URL(urlString)

        var HttpsURLConnection secureConnection = null
        try {
            if (urlString.startsWith('https')) {
                // TODO do additional stuff with the secure connection
                // like certificate pinning etc.
                secureConnection = url.openConnection as HttpsURLConnection

                // Create the SSL connection using local certificates
                val sc = SSLContext.getInstance("TLS")

                // TODO SecureRandom is for shit with the default seed (aka pid), increase entropy of the seed
                sc.init(null, null, new java.security.SecureRandom)
                secureConnection.setSSLSocketFactory = sc.socketFactory

                // Use this if you need SSL authentication
                /*
                val userpass = user + ":" + password;
                val basicAuth = "Basic " + Base64.encodeToString(userpass.getBytes(), Base64.DEFAULT);
                conn.setRequestProperty("Authorization", basicAuth);
                */
            }else
            {
                throw new IllegalArgumentException("You must use http over SSL/TLS")
            }
            for (i : headers.entrySet)
            {
                secureConnection.addRequestProperty(i.key, i.value)
            }
        } catch(java.io.IOException e) {
            onError.apply(rq, rp, e)
        }

        try {
            secureConnection.requestMethod = method
        } catch(java.net.ProtocolException e) {
            onError.apply(rq, rp, e)
        }

        secureConnection.doInput = true
        secureConnection.useCaches = useCaches

        secureConnection.connectTimeout = HttpRequestBase.CONNECT_TIMEOUT
        secureConnection.readTimeout = HttpRequestBase.READ_TIMEOUT

        try {
            // TODO determine if DELETE is also a POST-type?
            if (('POST'.equals(method) || 'PUT'.equals(method)) && !postData.isNullOrEmpty)
            {
                secureConnection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded")
                secureConnection.setRequestProperty("Content-Length", Integer.toString(postData.bytes.size))
                secureConnection.doOutput = true
                val out = new OutputStreamWriter(secureConnection.outputStream)
                out.write(postData)
                out.close
            }

            val encoding = secureConnection.contentEncoding


            val in = new BufferedReader(
                    new InputStreamReader(if ('gzip'.equals(encoding)) new GZIPInputStream(secureConnection.inputStream) else secureConnection.inputStream)
            )
            val rBuilder = new StringBuffer
            var String decodedString
            while ((decodedString = in.readLine()) != null) {
                rBuilder.append(decodedString)
            }
            in.close()

            val output = rBuilder.toString

            if (encoding == null || 'gzip'.equals(encoding))
            {
                StandardCharsets.UTF_8.encode(output)
            }else
            {
                Charset.forName(encoding).encode(output)
            }

            val responseBody = output

            if (!responseBody.isEmpty)
            {
                rp.body = responseBody
            }

            rp.headers = secureConnection.headerFields

            val code = secureConnection.responseCode

            rp.code = code

            // NOTE: code 304, 204, 201, 200 are happy flows
            if (HTTP_OK == code || HTTP_NOT_MODIFIED == code || HTTP_NO_CONTENT == code || HTTP_CREATED == code) {
                // handle success
                onSuccess.apply(rq, rp)
            } else {
                // handle error code
                onError.apply(rq, rp, null)
            }
        } catch(java.io.IOException e) {
            onError.apply(rq, rp, e)
        }

        if (secureConnection != null && closeConnectionAfterUse) {
            secureConnection.disconnect()
        }
    }

    override execute(HttpResponse response) {
        throw new UnsupportedOperationException()
    }

}

abstract class HttpResponse
{
    @Accessors
    int code

    @Accessors
    String body

    @Accessors
    Map<String, List<String>> headers

    def void onSuccess(HttpRequestBase request)
    def void onError(HttpRequestBase request, Exception e)
}

abstract class HttpRequestBase
{
    @Accessors
    String method = 'GET'

    @Accessors
    String urlString

    @Accessors
    var Map<String, String> headers

    @Accessors
    String postData

    @Accessors
    boolean useCaches = false

    // TODO experiment!
    public static val CONNECT_TIMEOUT = 10000
    public static val READ_TIMEOUT    = 10000

    @Accessors
    boolean closeConnectionAfterUse = false

    public def HttpRequestBase withMethod(String method)
    {
        this.method = method
        this
    }

    public def void execute(HttpResponse response)
}

class HttpRequest extends HttpRequestBase
{
    new (String urlString, String postData) {
        this.urlString = urlString
        this.method = 'POST'
        this.postData = postData
    }

    new (String urlString) {
        this(urlString, null)
    }

    public def HttpRequest addHeaders(Map<String, String> headers)
    {
        this.headers = headers
        this
    }

    public def HttpRequest addHeader(String key, String value)
    {
        if (headers == null) { headers = newHashMap }
        this.headers.put(key, value)
        this
    }

    public override execute(HttpResponse response)
    {
        val url = new URL(urlString)

        var HttpURLConnection connection = null
        var HttpsURLConnection secureConnection = null
        try {
            if (urlString.startsWith('https')) {
                // TODO do additional stuff with the secure connection
                // like certificate pinning etc.
                secureConnection = url.openConnection as HttpsURLConnection

                // Create the SSL connection using local certificates
                val sc = SSLContext.getInstance("TLS")

                // TODO SecureRandom is for shit with the default seed (aka pid), increase entropy of the seed
                sc.init(null, null, new java.security.SecureRandom)
                secureConnection.setSSLSocketFactory = sc.socketFactory

                // Use this if you need SSL authentication
                /*
                val userpass = user + ":" + password;
                val basicAuth = "Basic " + Base64.encodeToString(userpass.getBytes(), Base64.DEFAULT);
                conn.setRequestProperty("Authorization", basicAuth);
                */

                connection = secureConnection as HttpURLConnection
            }else
            {
                connection = url.openConnection as HttpURLConnection
            }
            for (i : headers.entrySet)
            {
                connection.addRequestProperty(i.key, i.value)
            }
        } catch(java.io.IOException e) {
            response.onError(this, e)
        }

        try {
            connection.requestMethod = method
        } catch(java.net.ProtocolException e) {
            response.onError(this, e)
        }

        connection.doInput = true
        connection.useCaches = useCaches

        connection.connectTimeout = CONNECT_TIMEOUT
        connection.readTimeout = READ_TIMEOUT

        try {
            // TODO determine if DELETE is also a POST-type?
            if (('POST'.equals(method) || 'PUT'.equals(method)) && !postData.isNullOrEmpty)
            {
                connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded")
                connection.setRequestProperty("Content-Length", Integer.toString(postData.bytes.size))
                connection.doOutput = true
                val out = new OutputStreamWriter(connection.outputStream)
                out.write(postData)
                out.close
            }

            val encoding = connection.contentEncoding


            val in = new BufferedReader(
                new InputStreamReader(if ('gzip'.equals(encoding)) new GZIPInputStream(connection.inputStream) else connection.inputStream)
            )
            val rBuilder = new StringBuffer
            var String decodedString
            while ((decodedString = in.readLine()) != null) {
                rBuilder.append(decodedString)
            }
            in.close()

            val output = rBuilder.toString

            if (encoding == null || 'gzip'.equals(encoding))
            {
                StandardCharsets.UTF_8.encode(output)
            }else
            {
                Charset.forName(encoding).encode(output)
            }

            val responseBody = output

            if (!responseBody.isEmpty)
            {
                response.body = responseBody
            }

            response.headers = connection.headerFields

            val code = connection.responseCode

            response.code = code

            // NOTE: code 304, 204, 201, 200 are happy flows
            if (HTTP_OK == code || HTTP_NOT_MODIFIED == code || HTTP_NO_CONTENT == code || HTTP_CREATED == code) {
                // handle success
                response.onSuccess(this)
            } else {
                // handle error code
                response.onError(this, null)
            }
        } catch(java.io.IOException e) {
            response.onError(this, e)
        }

        if (connection != null && closeConnectionAfterUse) {
            connection.disconnect()
        }
    }

    static public class Response extends HttpResponse
    {
        (HttpRequest, HttpResponse)=>void onSuccess
        (HttpRequest, HttpResponse, Exception)=>void onError

        new ((HttpRequest, HttpResponse)=>void onSuccess, (HttpRequest, HttpResponse, Exception)=>void onError)
        {
            this.onSuccess = onSuccess
            this.onError   = onError
        }

        override onSuccess(HttpRequestBase request) {
            onSuccess.apply(request as HttpRequest, this)
        }

        override onError(HttpRequestBase request, Exception e) {
            onError.apply(request as HttpRequest, this, e)
        }
    }

    // TODO figure out eventually, why #execute(some named or anonymous subclass) is not transpiling correctly
    public def run((HttpRequest, HttpResponse)=>void onSuccess, (HttpRequest, HttpResponse, Exception)=>void onError)
    {
        this.execute(new Response(onSuccess, onError))
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