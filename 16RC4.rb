require 'openssl'

def rc4(key, message)
  cipher = OpenSSL::Cipher.new('RC4')
  cipher.encrypt
  cipher.key = key
  encrypted = cipher.update(message) + cipher.final
  encrypted.unpack('H*')[0].upcase
end

key = 'secret_key'
message = 'my message'

puts rc4(key, message)
