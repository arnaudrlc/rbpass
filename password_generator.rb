# Generates a complex password using Ruby 3.1.1
# Author: Arnaud Ralec
# /!\ The following script has been written out of curiosity, with the sole purpose of learning about Ruby.
# Hence, it may not fit Ruby writting conventions, nor be written in the most effective manner.

require 'securerandom'

SPECIAL_CHARACTERS = ['@', '#', '_', '-', '!', '?', '&'].freeze
ALPHABET = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz'.freeze
DIGITS = '0123456789'.freeze

# Error thrown when trying to generate unsecure passwords.
class PasswordLengthError < StandardError
  def initialize(msg = 'A valid password must contain at least 8 characters.')
    super
    @message = msg
  end
end

def get_ratios(password_total_length)
  letters = password_total_length / 2
  schars = digits = letters / 2
  [letters - 1, digits, schars]
end

# Generates a complex password.
def password_generator(password_total_length = 12)
  raise PasswordLengthError unless password_total_length >= 8

  pwd = []
  letters_amount, digits_amount, schars_amount = *get_ratios(password_total_length)
  (0...letters_amount).each do
    pwd.push ALPHABET[SecureRandom.random_number(ALPHABET.length)]
  end
  (0...digits_amount).each do
    pwd.push DIGITS[SecureRandom.random_number(DIGITS.length)]
  end
  (0...schars_amount).each do
    pwd.push SPECIAL_CHARACTERS[SecureRandom.random_number(SPECIAL_CHARACTERS.length)]
  end
  pwd = pwd.shuffle
  pwd.join('')
rescue PasswordLengthError => e
  puts e.message
end

pwd = password_generator 15
print pwd if pwd
