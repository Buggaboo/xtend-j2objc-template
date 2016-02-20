package com.example.xtend;

import com.example.xtend.Pages;
import org.json.JSONException;
import org.json.JSONObject;

@SuppressWarnings("all")
public class Query {
  public Query(final JSONObject jsonObject) {
    mJsonObject = jsonObject;
  }
  
  private boolean mDirty;
  
  private JSONObject mJsonObject;
  
  public JSONObject toJSONObject() {
    return mJsonObject;
  }
  
  public boolean isDirty() {
    return mDirty;
  }
  
  protected Pages pages;
  
  public Pages getPages() throws JSONException {
    if (pages == null) {
        pages = new Pages(mJsonObject.getJSONObject("pages"));
    }
    return pages;
  }
  
  public Query setPages(final Pages pages) throws JSONException {
    mDirty = true;
    mJsonObject.put("pages", pages.toJSONObject());
    return this;
  }
}
