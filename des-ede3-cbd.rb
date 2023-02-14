require 'openssl'

def des_encrypt(plain_text, key)
  cipher = OpenSSL::Cipher.new('DES-EDE3-CBC')
  cipher.encrypt
  cipher.key = key
  cipher.iv = key
  encrypted_text = cipher.update(plain_text) + cipher.final
  encrypted_text
end

def des_decrypt(encrypted_text, key)
  cipher = OpenSSL::Cipher.new('DES-EDE3-CBC')
  cipher.decrypt
  cipher.key = key
  cipher.iv = key
  plain_text = cipher.update(encrypted_text) + cipher.final
  plain_text
end

key = OpenSSL::Cipher.new('DES-EDE3-CBC').random_key
plain_text = 'nihao'
encrypted_text = des_encrypt(plain_text, key)
decrypted_text = des_decrypt(encrypted_text, key)

puts "Plain Text: #{plain_text}"
puts "Encrypted Txt: #{encrypted_text}"
puts "Decrypted Txt: #{decrypted_text}"
