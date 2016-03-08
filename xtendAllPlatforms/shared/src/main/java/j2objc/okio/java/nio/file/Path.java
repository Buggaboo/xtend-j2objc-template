package j2objc.okio.java.nio.file;

import j2objc.okio.java.nio.file.FileSystem;
import j2objc.okio.java.nio.file.LinkOption;
import j2objc.okio.java.nio.file.Watchable;
import java.io.File;
import java.net.URI;

@SuppressWarnings("all")
public interface Path extends Comparable<Path>, Iterable<Path>, Watchable {
  public abstract boolean endsWith(final Path other);
  
  public abstract boolean endsWith(final String other);
  
  public abstract Path getFileName();
  
  public abstract FileSystem getFileSystem();
  
  public abstract Path getName(final int index);
  
  public abstract int getNameCount();
  
  public abstract Path getParent();
  
  public abstract Path getRoot();
  
  public abstract boolean isAbsolute();
  
  public abstract Path normalize();
  
  public abstract Path relativize(final Path other);
  
  public abstract Path resolve(final Path other);
  
  public abstract Path resolve(final String other);
  
  public abstract Path resolveSibling(final Path other);
  
  public abstract Path resolveSibling(final String other);
  
  public abstract boolean startsWith(final Path other);
  
  public abstract boolean startsWith(final String other);
  
  public abstract Path subpath(final int beginIndex, final int endIndex);
  
  public abstract Path toAbsolutePath();
  
  public abstract File toFile();
  
  public abstract Path toRealPath(final LinkOption... options);
  
  public abstract URI toUri();
}
