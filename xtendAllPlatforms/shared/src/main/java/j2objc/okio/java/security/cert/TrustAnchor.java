package j2objc.okio.java.security.cert;

import java.security.PublicKey;
import java.security.cert.X509Certificate;
import javax.security.auth.x500.X500Principal;

/**
 * Created by jasmsison on 29/02/16.
 */
@SuppressWarnings("all")
public class TrustAnchor {
  /**
   * Creates an instance of TrustAnchor where the most-trusted CA is specified as a distinguished name and public key.
   */
  public TrustAnchor(final String caName, final PublicKey pubKey, final byte[] nameConstraints) {
  }
  
  /**
   * Creates an instance of TrustAnchor where the most-trusted CA is specified as an X500Principal and public key.
   */
  public TrustAnchor(final X500Principal caPrincipal, final PublicKey pubKey, final byte[] nameConstraints) {
  }
  
  /**
   * Creates an instance of TrustAnchor with the specified X509Certificate and optional name constraints, which are intended to be used as additional constraints when validating an X.509 certification path.
   */
  public TrustAnchor(final X509Certificate trustedCert, final byte[] nameConstraints) {
  }
  
  public X509Certificate getTrustedCert() {
    throw new UnsupportedOperationException();
  }
  
  public X500Principal getCA() {
    throw new UnsupportedOperationException();
  }
  
  public String getCAName() {
    throw new UnsupportedOperationException();
  }
  
  public PublicKey getCAPublicKey() {
    throw new UnsupportedOperationException();
  }
  
  public byte[] getNameConstraints() {
    throw new UnsupportedOperationException();
  }
  
  @Override
  public String toString() {
    throw new UnsupportedOperationException();
  }
}
