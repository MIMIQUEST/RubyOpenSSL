require 'openssl'

def encrypt(plaintext, key)
  cipher = OpenSSL::Cipher.new("AES-128-CBC")
  cipher.encrypt
  cipher.key = key
  iv = cipher.random_iv
  encrypted = cipher.update(plaintext) + cipher.final
  [encrypted, iv]
end

def decrypt(encrypted, key, iv)
  cipher = OpenSSL::Cipher.new("AES-128-CBC")
  cipher.decrypt
  cipher.key = key
  cipher.iv = iv
  plaintext = cipher.update(encrypted) + cipher.final
  plaintext
end

key = OpenSSL::Random.random_bytes(16)
plaintext = "nihao"

encrypted, iv = encrypt(plaintext, key)
puts "Encrypted: #{encrypted.unpack("H*")}"
puts "IV: #{iv.unpack("H*")}"

decrypted = decrypt(encrypted, key, iv)
puts "Decrypted: #{decrypted}"
