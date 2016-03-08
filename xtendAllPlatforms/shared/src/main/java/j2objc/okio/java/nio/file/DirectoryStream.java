package j2objc.okio.java.nio.file;

@SuppressWarnings("all")
public interface DirectoryStream<T extends Object> {
  public interface Filter<T extends Object> {
    public abstract boolean accept(final T entry);
  }
}
