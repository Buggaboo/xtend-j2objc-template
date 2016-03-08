package j2objc.okio.java.nio.file;

import j2objc.okio.java.nio.file.WatchEvent;
import j2objc.okio.java.nio.file.WatchKey;
import j2objc.okio.java.nio.file.WatchService;

@SuppressWarnings("all")
public interface Watchable {
  public abstract WatchKey register(final WatchService watcher, final WatchEvent.Kind<?>... events);
  
  public abstract WatchKey register(final WatchService watcher, final WatchEvent.Kind<?>[] events, final WatchEvent.Modifier... modifiers);
}
