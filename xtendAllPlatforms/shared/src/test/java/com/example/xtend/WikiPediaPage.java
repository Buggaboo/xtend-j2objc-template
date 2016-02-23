package com.example.xtend;

import com.example.xtend.Revisions;
import java.util.ArrayList;
import java.util.List;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xtendroid.json.AndroidJsonized;

@AndroidJsonized("{\"pageid\":15580374,\"ns\":0,\"title\":\"Main Page\",\"revisions\":[{\"contentformat\":\"text/x-wiki\",\"contentmodel\":\"wikitext\"}]}")
@SuppressWarnings("all")
public class WikiPediaPage {
  public WikiPediaPage(final JSONObject jsonObject) {
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
  
  public long getPageid() throws JSONException {
    return mJsonObject.getLong("pageid");
  }
  
  public WikiPediaPage setPageid(final long pageid) throws JSONException {
    mDirty = true;
    mJsonObject.put("pageid", pageid);
    return this;
  }
  
  public long getNs() throws JSONException {
    return mJsonObject.getLong("ns");
  }
  
  public WikiPediaPage setNs(final long ns) throws JSONException {
    mDirty = true;
    mJsonObject.put("ns", ns);
    return this;
  }
  
  public String getTitle() throws JSONException {
    return mJsonObject.getString("title");
  }
  
  public WikiPediaPage setTitle(final String title) throws JSONException {
    mDirty = true;
    mJsonObject.put("title", title);
    return this;
  }
  
  protected List<Revisions> revisions;
  
  public List<Revisions> getRevisions() throws JSONException {
    if (revisions == null) {
        revisions = new ArrayList<Revisions>();
        for (int i=0; i<revisions.size(); i++) {
            revisions.add((Revisions) mJsonObject.getJSONArray("revisions").get(i));
        }
    }
    return revisions;
  }
  
  public WikiPediaPage setRevisions(final List<Revisions> revisions) throws JSONException {
    mDirty = true;
    mJsonObject.put("revisions", new JSONArray(revisions));
    return this;
  }
}
