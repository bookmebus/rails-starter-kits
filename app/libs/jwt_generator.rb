class JwtGenerator
  # "jti"=>"c4b5", "display_name"=>nil, "sub"=>"1", "scp"=>"api_user", "aud"=>nil, "iat"=>1597058071, "exp"=>1597058971
  def self.encode(payload)
    payload[:exp] = expired_time if payload[:exp].blank?
    
    JWT.encode(payload, self.secret_key, 'HS256')
  end

  def self.decode(token)
    decoded = JWT.decode(token, self.secret_key, true, { algorithm: 'HS256' })

    body = decoded[0]
    body.with_indifferent_access
  end

  def self.expired_time
    1.day.from_now.to_i
  end

  def self.secret_key
    ENV['DEVISE_JWT_SECRET_KEY']
  end

end