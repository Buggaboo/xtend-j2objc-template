package j2objc.okio.java.nio.file;

import j2objc.okio.java.nio.file.Charset;
import j2objc.okio.java.nio.file.CopyOption;
import j2objc.okio.java.nio.file.DirectoryStream;
import j2objc.okio.java.nio.file.FileStore;
import j2objc.okio.java.nio.file.FileVisitOption;
import j2objc.okio.java.nio.file.FileVisitor;
import j2objc.okio.java.nio.file.LinkOption;
import j2objc.okio.java.nio.file.OpenOption;
import j2objc.okio.java.nio.file.Path;
import j2objc.okio.java.nio.file.attribute.BasicFileAttributes;
import j2objc.okio.java.nio.file.attribute.FileAttribute;
import j2objc.okio.java.nio.file.attribute.FileAttributeView;
import j2objc.okio.java.nio.file.attribute.FileTime;
import j2objc.okio.java.nio.file.attribute.PosixFilePermission;
import j2objc.okio.java.nio.file.attribute.UserPrincipal;
import j2objc.okio.java.nio.file.channels.SeekableByteChannel;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.Set;

@SuppressWarnings("all")
public final class Files {
  public static long copy(final InputStream in, final Path target, final CopyOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static long copy(final Path source, final OutputStream out) {
    throw new UnsupportedOperationException();
  }
  
  public static Path copy(final Path source, final Path target, final CopyOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createDirectories(final Path dir, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createDirectory(final Path dir, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createFile(final Path path, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createLink(final Path link, final Path existing) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createsymbolicLink(final Path link, final Path target, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createTempDirectory(final Path dir, final String prefix, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createTempDirectory(final String prefix, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createTempFile(final Path dir, final String prefix, final String suffix, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static Path createTempFile(final String prefix, final String suffix, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static void delete(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean deleteIfExists(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean exists(final Path path, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static Object getAttribute(final Path path, final String attribute, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static <V extends FileAttributeView> V getFileAttributeView(final Path path, final Class<V> type, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static FileStore getFileStore(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static FileTime getLastModifiedTime(final Path path, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static UserPrincipal getOwner(final Path path, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static Set<PosixFilePermission> getPosixFilePermissions(final Path path, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isDirectory(final Path path, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isExecutable(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isHidden(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isReadable(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isRegularFile(final Path path, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isSameFile(final Path path, final Path path2) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isSymbolicLink(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean isWritable(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static Path move(final Path source, final Path target, final CopyOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static BufferedReader newBufferedReader(final Path path, final Charset cs) {
    throw new UnsupportedOperationException();
  }
  
  public static BufferedWriter newBufferedWriter(final Path path, final Charset cs, final OpenOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static SeekableByteChannel newByteChannel(final Path path, final OpenOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static SeekableByteChannel newByteChannel(final Path path, final Set<? extends OpenOption> options, final FileAttribute<?>... attrs) {
    throw new UnsupportedOperationException();
  }
  
  public static DirectoryStream<Path> newDirectoryStream(final Path dir) {
    throw new UnsupportedOperationException();
  }
  
  public static DirectoryStream<Path> newDirectoryStream(final Path dir, final DirectoryStream.Filter<? super Path> filter) {
    throw new UnsupportedOperationException();
  }
  
  public static DirectoryStream<Path> newDirectoryStream(final Path dir, final String glob) {
    throw new UnsupportedOperationException();
  }
  
  public static InputStream newInputStream(final Path path, final OpenOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static OutputStream newOutputStream(final Path path, final OpenOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static boolean notExists(final Path path, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static String probeContentType(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static byte[] readAllBytes(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static List<String> readAllLines(final Path path, final Charset cs) {
    throw new UnsupportedOperationException();
  }
  
  public static <A extends BasicFileAttributes> A readAttributes(final Path path, final Class<A> type, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static Map<String, Object> readAttributes(final Path path, final String attributes, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static Path readSymbolicLink(final Path link) {
    throw new UnsupportedOperationException();
  }
  
  public static Path setAttribute(final Path path, final String attribute, final Object value, final LinkOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static Path setLastModifiedTime(final Path path, final FileTime time) {
    throw new UnsupportedOperationException();
  }
  
  public static Path setOwner(final Path path, final UserPrincipal owner) {
    throw new UnsupportedOperationException();
  }
  
  public static Path setPosixFilePermissions(final Path path, final Set<PosixFilePermission> perms) {
    throw new UnsupportedOperationException();
  }
  
  public static long size(final Path path) {
    throw new UnsupportedOperationException();
  }
  
  public static Path walkFileTree(final Path start, final FileVisitor<? super Path> visitor) {
    throw new UnsupportedOperationException();
  }
  
  public static Path walkFileTree(final Path start, final Set<FileVisitOption> options, final int maxDepth, final FileVisitor<? super Path> visitor) {
    throw new UnsupportedOperationException();
  }
  
  public static Path write(final Path path, final byte[] bytes, final OpenOption... options) {
    throw new UnsupportedOperationException();
  }
  
  public static Path write(final Path path, final Iterable<? extends CharSequence> lines, final Charset cs, final OpenOption... options) {
    throw new UnsupportedOperationException();
  }
}
