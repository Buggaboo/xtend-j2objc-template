package com.example.xtend;

import org.json.JSONException;
import org.json.JSONObject;

@SuppressWarnings("all")
public class Pages {
  public Pages(final JSONObject jsonObject) {
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
  
  public String getPlaceholder_for_page_def() throws JSONException {
    return mJsonObject.getString("placeholder_for_page_def");
  }
  
  public Pages setPlaceholder_for_page_def(final String placeholder_for_page_def) throws JSONException {
    mDirty = true;
    mJsonObject.put("placeholder_for_page_def", placeholder_for_page_def);
    return this;
  }
}
