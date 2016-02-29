package j2objc.okio.java.nio.file

import java.lang.Comparable
import java.util.List
import java.util.Map
import java.util.Set
import java.net.URI
import java.io.Closeable
import java.io.File
import java.util.Iterator
import java.lang.UnsupportedOperationException
import java.io.OutputStream
import java.io.InputStream
import java.io.BufferedReader
import java.io.BufferedWriter

import j2objc.okio.java.nio.file.attribute.*
import j2objc.okio.java.nio.file.channels.*


/**
 * Created by jasmsison on 29/02/16.
 */

interface WatchEvent<K> {
    public static class Kind<K> {}
    public static class Modifier {}
}

interface WatchKey {
    //Cancels the registration with the watch service.
    def void cancel()
    // Tells whether or not this watch key is valid.
    def boolean	isValid()
    // Retrieves and removes all pending events for this watch key, returning a List of the events that were retrieved.
    def List<WatchEvent<?>>	pollEvents()
    // Resets this watch key.
    def boolean	reset()
    // // Returns the object for which this watch key was created.
    def Watchable watchable()

}

interface WatchService {}

interface Watchable {
    // Registers an object with a watch service.
    def WatchKey register(WatchService watcher, WatchEvent.Kind<?>... events)

    //Registers an object with a watch service.
    def WatchKey register(WatchService watcher, WatchEvent.Kind<?>[] events, WatchEvent.Modifier... modifiers)
}

abstract class FileSystem implements Closeable
{
    new () {}
}

enum LinkOption { /* TODO */ }

interface Path extends Comparable<Path>, Iterable<Path>, Watchable{
    //override int	compareTo(Path other)
    //Compares two abstract paths lexicographically.
    def boolean	endsWith(Path other)
    // Tests if this path ends with the given path.
    def boolean	endsWith(String other)
    // Tests if this path ends with a Path, constructed by converting the given path string, in exactly the manner specified by the endsWith(Path) method.
    //def boolean	equals(Object other) // TODO use AA
    // Tests this path for equality with the given object.
    def Path	getFileName()
    // Returns the name of the file or directory denoted by this path as a Path object.
    def FileSystem	getFileSystem()
    // Returns the file system that created this object.
    def Path	getName(int index)
    // Returns a name element of this path as a Path object.
    def int	getNameCount()
    // Returns the number of name elements in the path.
    def Path	getParent()
    // Returns the parent path, or null if this path does not have a parent.
    def Path	getRoot()
    // Returns the root component of this path as a Path object, or null if this path does not have a root component.
    //def int	hashCode()
    // Computes a hash code for this path.
    def boolean	isAbsolute()
    // Tells whether or not this def Path is absolute.
    //def Iterator<Path>	iterator() // TODO use AA
    // Returns an iterator over the name elements of this def Path.
    def Path	normalize()
    // Returns a path that is this path with redundant name elements eliminated.
    //def WatchKey	register(WatchService watcher, WatchEvent.Kind<?>... events) // // TODO use AA
    // Registers the file located by this path with a watch service.
    // def WatchKey	register(WatchService watcher, WatchEvent.Kind<?>[] events, WatchEvent.Modifier... modifiers) // TODO use AA
    // Registers the file located by this path with a watch service.
    def Path	relativize(Path other)
    // Constructs a relative path between this path and a given path.
    def Path	resolve(Path other)
    // Resolve the given path against this path.
    def Path	resolve(String other)
    // Converts a given path string to a Path and resolves it against this Path in exactly the manner specified by the resolve method.
    def Path	resolveSibling(Path other)
    // Resolves the given path against this path's parent path.
    def Path	resolveSibling(String other)
    // Converts a given path string to a Path and resolves it against this path's parent path in exactly the manner specified by the resolveSibling method.
    def boolean	startsWith(Path other)
    // Tests if this path starts with the given path.
    def boolean	startsWith(String other)
    // Tests if this path starts with a Path, constructed by converting the given path string, in exactly the manner specified by the startsWith(Path) method.
    def Path	subpath(int beginIndex, int endIndex)
    // Returns a relative Path that is a subsequence of the name elements of this path.
    def Path	toAbsolutePath()
    // Returns a Path object representing the absolute path of this path.
    def File	toFile()
    // Returns a File object representing this path.
    def Path	toRealPath(LinkOption... options)
    // Returns the real path of an existing file.
    //override String	toString() // TODO use AA
    // Returns the string representation of this path.
    def URI	toUri()
    // Returns a URI to represent this path.

}

interface OpenOption {}
interface CopyOption {}

enum FileVisitOption {}

abstract class Charset implements Comparable<Charset>
{
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/charset/Charset.html
}

abstract class FileStore {
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/FileStore.html
}

interface FileVisitor<T> {
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/FileVisitor.html
}

interface DirectoryStream<T> {
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/DirectoryStream.html
    static interface Filter<T> {
        def boolean accept(T entry)
    }
}

final class Files {
    public static def long	copy(InputStream in, Path target, CopyOption... options) {
        throw new UnsupportedOperationException
    }
    //Copies all bytes from an input stream to a file.
    public static def long	copy(Path source, OutputStream out) {
        throw new UnsupportedOperationException
    }
    //Copies all bytes from a file to an output stream.
    public static def Path	copy(Path source, Path target, CopyOption... options) {
        throw new UnsupportedOperationException
    }
    //Copy a file to a target file.
    public static def Path	createDirectories(Path dir, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates a directory by creating all nonexistent parent directories first.
    public static def Path	createDirectory(Path dir, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates a new directory.
    public static def Path	createFile(Path path, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates a new and empty file, failing if the file already exists.
    public static def Path	createLink(Path link, Path existing) {
        throw new UnsupportedOperationException
    }
    //Creates a new link (directory entry) for an existing file (optional operation).
    public static def Path createsymbolicLink(Path link, Path target, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates a symbolic link to a target (optional operation).
    public static def Path	createTempDirectory(Path dir, String prefix, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates a new directory in the specified directory, using the given prefix to generate its name.
    public static def Path	createTempDirectory(String prefix, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates a new directory in the default temporary-file directory, using the given prefix to generate its name.
    public static def Path	createTempFile(Path dir, String prefix, String suffix, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates a new empty file in the specified directory, using the given prefix and suffix strings to generate its name.
    public static def Path	createTempFile(String prefix, String suffix, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Creates an empty file in the default temporary-file directory, using the given prefix and suffix to generate its name.
    public static def void	delete(Path path) {
        throw new UnsupportedOperationException
    }
    //Deletes a file.
    public static def boolean	deleteIfExists(Path path) {
        throw new UnsupportedOperationException
    }
    //Deletes a file if it exists.
    public static def boolean	exists(Path path, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Tests whether a file exists.
    public static def Object	getAttribute(Path path, String attribute, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Reads the value of a file attribute.
    public static def <V extends FileAttributeView>
    V	getFileAttributeView(Path path, Class<V> type, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Returns a file attribute view of a given type.
    public static def FileStore	getFileStore(Path path) {
        throw new UnsupportedOperationException
    }
    //Returns the FileStore representing the file store where a file is located.
    public static def FileTime	getLastModifiedTime(Path path, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Returns a file's last modified time.
    public static def UserPrincipal	getOwner(Path path, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Returns the owner of a file.
    public static def Set<PosixFilePermission>	getPosixFilePermissions(Path path, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Returns a file's POSIX file permissions.
    public static def boolean	isDirectory(Path path, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Tests whether a file is a directory.
    public static def boolean	isExecutable(Path path) {
        throw new UnsupportedOperationException
    }
    //Tests whether a file is executable.
    public static def boolean	isHidden(Path path) {
        throw new UnsupportedOperationException
    }
    //Tells whether or not a file is considered hidden.
    public static def boolean	isReadable(Path path) {
        throw new UnsupportedOperationException
    }
    //Tests whether a file is readable.
    public static def boolean	isRegularFile(Path path, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Tests whether a file is a regular file with opaque content.
    public static def boolean	isSameFile(Path path, Path path2) {
        throw new UnsupportedOperationException
    }
    //Tests if two paths locate the same file.
    public static def boolean	isSymbolicLink(Path path) {
        throw new UnsupportedOperationException
    }
    //Tests whether a file is a symbolic link.
    public static def boolean	isWritable(Path path) {
        throw new UnsupportedOperationException
    }
    //Tests whether a file is writable.
    public static def Path	move(Path source, Path target, CopyOption... options) {
        throw new UnsupportedOperationException
    }
    //Move or rename a file to a target file.
    public static def BufferedReader	newBufferedReader(Path path, Charset cs) {
        throw new UnsupportedOperationException
    }
    //Opens a file for reading, returning a BufferedReader that may be used to read text from the file in an efficient manner.
    public static def BufferedWriter	newBufferedWriter(Path path, Charset cs, OpenOption... options) {
        throw new UnsupportedOperationException
    }
    //Opens or creates a file for writing, returning a BufferedWriter that may be used to write text to the file in an efficient manner.
    public static def SeekableByteChannel	newByteChannel(Path path, OpenOption... options) {
        throw new UnsupportedOperationException
    }
    //Opens or creates a file, returning a seekable byte channel to access the file.
    public static def SeekableByteChannel	newByteChannel(Path path, Set<? extends OpenOption> options, FileAttribute<?>... attrs) {
        throw new UnsupportedOperationException
    }
    //Opens or creates a file, returning a seekable byte channel to access the file.
    public static def DirectoryStream<Path>	newDirectoryStream(Path dir) {
        throw new UnsupportedOperationException
    }
    //Opens a directory, returning a DirectoryStream to iterate over all entries in the directory.
    public static def DirectoryStream<Path>	newDirectoryStream(Path dir, DirectoryStream.Filter<? super Path> filter) {
        throw new UnsupportedOperationException
    }
    //Opens a directory, returning a DirectoryStream to iterate over the entries in the directory.
    public static def DirectoryStream<Path>	newDirectoryStream(Path dir, String glob) {
        throw new UnsupportedOperationException
    }
    //Opens a directory, returning a DirectoryStream to iterate over the entries in the directory.
    public static def InputStream	newInputStream(Path path, OpenOption... options) {
        throw new UnsupportedOperationException
    }
    //Opens a file, returning an input stream to read from the file.
    public static def OutputStream	newOutputStream(Path path, OpenOption... options) {
        throw new UnsupportedOperationException
    }
    //Opens or creates a file, returning an output stream that may be used to write bytes to the file.
    public static def boolean	notExists(Path path, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Tests whether the file located by this path does not exist.
    public static def String	probeContentType(Path path) {
        throw new UnsupportedOperationException
    }
    //Probes the content type of a file.
    public static def byte[]	readAllBytes(Path path) {
        throw new UnsupportedOperationException
    }
    //Reads all the bytes from a file.
    public static def List<String>	readAllLines(Path path, Charset cs  ) {
        throw new UnsupportedOperationException
    }
    //Read all lines from a file.
    public static def <A extends BasicFileAttributes>
    A	readAttributes(Path path, Class<A> type, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Reads a file's attributes as a bulk operation.
    public static def Map<String,Object>	readAttributes(Path path, String attributes, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Reads a set of file attributes as a bulk operation.
    public static def Path	readSymbolicLink(Path link) {
        throw new UnsupportedOperationException
    }
    //Reads the target of a symbolic link (optional operation).
    public static def Path	setAttribute(Path path, String attribute, Object value, LinkOption... options) {
        throw new UnsupportedOperationException
    }
    //Sets the value of a file attribute.
    public static def Path	setLastModifiedTime(Path path, FileTime time) {
        throw new UnsupportedOperationException
    }
    //Updates a file's last modified time attribute.
    public static def Path	setOwner(Path path, UserPrincipal owner) {
        throw new UnsupportedOperationException
    }
    //Updates the file owner.
    public static def Path	setPosixFilePermissions(Path path, Set<PosixFilePermission> perms) {
        throw new UnsupportedOperationException
    }
    //Sets a file's POSIX permissions.
    public static def long	size(Path path) {
        throw new UnsupportedOperationException
    }
    //Returns the size of a file (in bytes).
    public static def Path	walkFileTree(Path start, FileVisitor<? super Path> visitor) {
        throw new UnsupportedOperationException
    }
    //Walks a file tree.
    public static def Path	walkFileTree(Path start, Set<FileVisitOption> options, int maxDepth, FileVisitor<? super Path> visitor) {
        throw new UnsupportedOperationException
    }
    //Walks a file tree.
    public static def Path	write(Path path, byte[] bytes, OpenOption... options) {
        throw new UnsupportedOperationException
    }
    //Writes bytes to a file.
    public static def Path	write(Path path, Iterable<? extends CharSequence> lines, Charset cs, OpenOption... options) {
        throw new UnsupportedOperationException
    }
    //Write lines of text to a file.
}