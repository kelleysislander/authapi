class AuthenticationCode < ActiveRecord::Base
  attr_accessible :account_id, :hash_code

  belongs_to :account

  validates_uniqueness_of   :hash_code, :scope => :account_id
  validates_numericality_of :account_id

  def to_s
    hash_code
  end

  def send_email! email
    Pony.mail(
      :to       => email,
      :from     => 'authapi-noreply@semaphoremobile.com',
      :subject  => 'AuthAPI - Authentication Codes',
      :body     => "The following authentication key has been generated: #{hash_code}",
      :via      => :sendmail,
      :via_options => {
        :arguments => '-t -i -f authapi-noreply@semaphoremobile.com'
      }
    )

    puts "Sent email to #{email}"
  end

  def self.random
    (('0'..'9').to_a | ('a'..'f').to_a).sort_by{rand}.join
  end

  def self.generate account_id, quantity, email
    codes = []
    quantity.to_i.times do
      codes << create(
        :account_id => account_id,
        :hash_code  => self.random
      )
    end

    body = "The following authentication keys have been generated:\n\n"
    body << codes.collect { |c| c.hash_code }.join("\n")

    Pony.mail(
      :to       => email,
      :from     => 'authapi-noreply@semaphoremobile.com',
      :subject  => 'AuthAPI - Authentication Codes',
      :body     => body,
      :via      => :sendmail,
      :via_options => {
        :arguments => '-t -i -f authapi-noreply@semaphoremobile.com'
      }
    )

    puts "Sent email to #{email}: \n\n #{body}"
  end
end
