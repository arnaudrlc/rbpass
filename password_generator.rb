=begin
Generates a complex password using Ruby 3.1.1
Author: Arnaud Ralec

/!\ The following script has been written with the purpose of learning Ruby.
Hence, it may not fit Ruby writting conventions, nor be written in the most effective manner.
=end

require 'securerandom'


SPECIAL_CHARACTERS = Array["@", "#", "_", "-", "!", "?", "&"]
ALPHABET = "AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz"
DIGITS = "0123456789"


class PasswordLengthError < StandardError
  def initialize(msg="A valid password must contain at least 8 characters.")
    super
    @message = msg
  end
end


def get_ratios(password_total_length)
  letters = password_total_length / 2
  schars = digits = letters / 4
  return letters, digits, schars
end


# Generates a complex password.
def password_generator(password_total_length=12)
  begin
    if password_total_length >= 8 then
      pwd = Array.new
      letters_amount, digits_amount, schars_amount = *get_ratios(password_total_length)
      for i in 0...letters_amount  # In Ruby: .. is inclusive, ... is exclusive.
        pwd.push ALPHABET[SecureRandom.random_number(ALPHABET.length())]
      end
      for i in 0...digits_amount
        pwd.push DIGITS[SecureRandom.random_number(DIGITS.length())]
      end
      for i in 0...schars_amount
        pwd.push SPECIAL_CHARACTERS[SecureRandom.random_number(SPECIAL_CHARACTERS.length())]
      end
      pwd = pwd.shuffle
      return pwd.join("")
    else
      raise PasswordLengthError
    end
  rescue PasswordLengthError => e
    puts e.message
  end
end


pwd = password_generator(15)
if pwd then
  print pwd
end