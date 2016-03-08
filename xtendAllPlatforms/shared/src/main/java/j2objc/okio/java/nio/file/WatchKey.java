package j2objc.okio.java.nio.file;

import j2objc.okio.java.nio.file.WatchEvent;
import j2objc.okio.java.nio.file.Watchable;
import java.util.List;

@SuppressWarnings("all")
public interface WatchKey {
  public abstract void cancel();
  
  public abstract boolean isValid();
  
  public abstract List<WatchEvent<?>> pollEvents();
  
  public abstract boolean reset();
  
  public abstract Watchable watchable();
}
