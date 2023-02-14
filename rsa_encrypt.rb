require 'openssl'

def encrypt_rsa(plain_text, public_key)
  public_key = OpenSSL::PKey::RSA.new(public_key)
  encrypted_data = public_key.public_encrypt(plain_text)
  encrypted_data.unpack("H*").first
end

def decrypt_rsa(encrypted_text, private_key)
  private_key = OpenSSL::PKey::RSA.new(private_key)
  decrypted_data = private_key.private_decrypt(
    [encrypted_text].pack("H*")
  )
  decrypted_data
end

private_key = OpenSSL::PKey::RSA.generate(2048)
public_key = private_key.public_key

plain_text = "nihao"
encrypted_text = encrypt_rsa(plain_text, public_key)
puts "Encrypted text: #{encrypted_text}"

decrypted_text = decrypt_rsa(encrypted_text, private_key)
puts "Decrypted text: #{decrypted_text}"
