package j2objc.okio.java.security.cert

import java.security.PublicKey
import javax.security.auth.x500.X500Principal // TODO determine existence in jre_emul
import java.security.cert.X509Certificate // TODO determine existence in jre_emul
import java.lang.UnsupportedOperationException

/**
 * Created by jasmsison on 29/02/16.
 */
class TrustAnchor {


    /**
     *  Creates an instance of TrustAnchor where the most-trusted CA is specified as a distinguished name and public key.
     */
    new (String caName, PublicKey pubKey, byte[] nameConstraints) {}


    /**
     * Creates an instance of TrustAnchor where the most-trusted CA is specified as an X500Principal and public key.
     */
    new(X500Principal caPrincipal, PublicKey pubKey, byte[] nameConstraints) {}

    /**
     * Creates an instance of TrustAnchor with the specified X509Certificate and optional name constraints, which are intended to be used as additional constraints when validating an X.509 certification path.
     */
    new(X509Certificate trustedCert, byte[] nameConstraints) {}

    public def X509Certificate getTrustedCert() {
        throw new UnsupportedOperationException
    }

    public def X500Principal getCA() {
        throw new UnsupportedOperationException
    }

    public def String getCAName() {
        throw new UnsupportedOperationException
    }

    public def PublicKey getCAPublicKey() {
        throw new UnsupportedOperationException
    }

    public def byte[] getNameConstraints() {
        throw new UnsupportedOperationException
    }

    override String toString() {
        throw new UnsupportedOperationException
    }

}