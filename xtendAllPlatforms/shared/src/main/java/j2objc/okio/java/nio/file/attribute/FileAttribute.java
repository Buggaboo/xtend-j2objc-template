package j2objc.okio.java.nio.file.attribute;

/**
 * Created by jasmsison on 29/02/16.
 */
@SuppressWarnings("all")
public interface FileAttribute<T extends Object> {
  public abstract String name();
  
  public abstract T value();
}
