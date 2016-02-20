package com.example.xtend;

import com.example.xtend.http.HttpRequest;
import com.example.xtend.http.HttpRequestBase;
import com.example.xtend.http.HttpResponse;
import com.google.common.base.Objects;
import io.mikael.urlbuilder.UrlBuilder;
import org.eclipse.xtext.xbase.lib.StringExtensions;
import org.junit.Assert;
import org.junit.Test;

@SuppressWarnings("all")
public class SharedHttpTest {
  @Test
  public void testCallToWikiPediaRestService() {
    UrlBuilder _fromString = UrlBuilder.fromString("https://en.wikipedia.org");
    UrlBuilder _withPath = _fromString.withPath("/w/api.php");
    UrlBuilder _addParameter = _withPath.addParameter("action", "query");
    UrlBuilder _addParameter_1 = _addParameter.addParameter("titles", "Main Page");
    UrlBuilder _addParameter_2 = _addParameter_1.addParameter("prop", "revisions");
    UrlBuilder _addParameter_3 = _addParameter_2.addParameter("rvprop", "content");
    final UrlBuilder urlBuilder = _addParameter_3.addParameter("format", "json");
    String _string = urlBuilder.toString();
    final HttpRequest req = new HttpRequest(_string);
    req.execute(new HttpResponse() {
      @Override
      public void onSuccess(final HttpRequestBase request) {
        String _body = this.getBody();
        int _code = this.getCode();
        String _format = String.format("response (%s): %s", _body, Integer.valueOf(_code));
        String _body_1 = this.getBody();
        Assert.assertNotNull(_format, _body_1);
      }
      
      @Override
      public void onError(final HttpRequestBase request, final Exception e) {
        String _body = this.getBody();
        boolean _isNullOrEmpty = StringExtensions.isNullOrEmpty(_body);
        boolean _not = (!_isNullOrEmpty);
        if (_not) {
          String _body_1 = this.getBody();
          Assert.fail(_body_1);
        }
        boolean _notEquals = (!Objects.equal(e, null));
        if (_notEquals) {
          String _message = e.getMessage();
          Assert.fail(_message);
        }
      }
    });
  }
}
