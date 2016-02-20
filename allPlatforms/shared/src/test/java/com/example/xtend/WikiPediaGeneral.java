package com.example.xtend;

import com.example.xtend.Query;
import org.json.JSONException;
import org.json.JSONObject;
import org.xtendroid.json.AndroidJsonized;

@AndroidJsonized("{\"batchcomplete\":\"\",\"query\":{\"pages\": {\"placeholder_for_page_def\":\"meh this is a string\"}}}")
@SuppressWarnings("all")
public class WikiPediaGeneral {
  public WikiPediaGeneral(final JSONObject jsonObject) {
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
  
  public String getBatchcomplete() throws JSONException {
    return mJsonObject.getString("batchcomplete");
  }
  
  public WikiPediaGeneral setBatchcomplete(final String batchcomplete) throws JSONException {
    mDirty = true;
    mJsonObject.put("batchcomplete", batchcomplete);
    return this;
  }
  
  protected Query query;
  
  public Query getQuery() throws JSONException {
    if (query == null) {
        query = new Query(mJsonObject.getJSONObject("query"));
    }
    return query;
  }
  
  public WikiPediaGeneral setQuery(final Query query) throws JSONException {
    mDirty = true;
    mJsonObject.put("query", query.toJSONObject());
    return this;
  }
}
