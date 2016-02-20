package com.example.xtend;

import org.json.JSONException;
import org.json.JSONObject;

@SuppressWarnings("all")
public class Revisions {
  public Revisions(final JSONObject jsonObject) {
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
  
  public String getContentformat() throws JSONException {
    return mJsonObject.getString("contentformat");
  }
  
  public Revisions setContentformat(final String contentformat) throws JSONException {
    mDirty = true;
    mJsonObject.put("contentformat", contentformat);
    return this;
  }
  
  public String getContentmodel() throws JSONException {
    return mJsonObject.getString("contentmodel");
  }
  
  public Revisions setContentmodel(final String contentmodel) throws JSONException {
    mDirty = true;
    mJsonObject.put("contentmodel", contentmodel);
    return this;
  }
}
