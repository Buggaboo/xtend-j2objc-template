package j2objc.okio.java.nio.file.attribute

import java.lang.Comparable
import java.security.Principal // TODO determine existence jre_emul.jar

/**
 * Created by jasmsison on 29/02/16.
 */
interface FileAttribute<T> {
    def String name()
    def T value()
}

interface AttributeView { def String name() }

interface FileAttributeView extends AttributeView
{
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/attribute/FileAttributeView.html
}

interface BasicFileAttributes {
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/attribute/BasicFileAttributes.html
}

class FileTime implements Comparable<FileTime>
{

    override compareTo(FileTime another) {
        throw new UnsupportedOperationException()
    }

    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/attribute/FileTime.html
}

interface UserPrincipal extends Principal
{
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/attribute/UserPrincipal.html
}

class PosixFilePermission
{
    // TODO https://docs.oracle.com/javase/7/docs/api/java/nio/file/attribute/PosixFilePermissions.html
}

