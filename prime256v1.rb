require 'openssl'

def encrypt_ecc(plaintext, curve_name)
  group = OpenSSL::PKey::EC.generate(curve_name).group
  public_key = OpenSSL::PKey::EC.new(group)
  public_key.generate_key
  private_key = public_key.private_key

  cipher = OpenSSL::Cipher::AES.new(128, :CBC)
  cipher.encrypt
  cipher.key = private_key.public_encrypt(cipher.random_key)

  encrypted = cipher.update(plaintext) + cipher.final
  [encrypted, public_key]
end

def decrypt_ecc(ciphertext, public_key)
  private_key = OpenSSL::PKey::EC.new(public_key)
  private_key = private_key.private_key

  cipher = OpenSSL::Cipher::AES.new(128, :CBC)
  cipher.decrypt
  cipher.key = private_key.private_decrypt(cipher.key)

  plaintext = cipher.update(ciphertext) + cipher.final
  plaintext
end

plaintext = 'nihao'
curve_name = 'prime256v1'
encrypted, public_key = encrypt_ecc(plaintext, curve_name)
puts "Encrypted message: #{encrypted}"

decrypted = decrypt_ecc(encrypted, public_key)
puts "Decrypted message: #{decrypted}"
