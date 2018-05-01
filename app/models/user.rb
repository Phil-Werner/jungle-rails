class User < ActiveRecord::Base

  has_secure_password

  validates :password, presence: true
  validates :password_confirmation, presence: true
  validates_length_of :password, minimum: 3
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :name, presence: true

  def self.authenticate_with_credentials(email, password)

    email_no_spaces = remove_white_space(email)

    email_case_insensitive = make_insensitive(email_no_spaces)

    user = User.find_by_email(email_case_insensitive)
    if (!user)
      return nil
    end

    if (user.authenticate(password))
      return user
    else
      return nil
    end
  end
end

def remove_white_space(email)
  improved_email = email

  while (improved_email[0] == ' ')
    temp = improved_email[1, improved_email.length - 1]
    improved_email = temp
  end

  while (improved_email[improved_email.length - 1] == ' ')
    temp = improved_email[0, improved_email.length - 2]
    improved_email = temp
  end
  return improved_email
end

def make_insensitive(email)
  improved_email = email.downcase
  return improved_email
end
