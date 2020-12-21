module JwtRequestHeaderHelper
  def headers_jwt_bearer_token
    headers = {}
    headers['Authorization'] = jwt_bearer_token
    headers
  end

  def jwt_bearer_token
    payload = {
      "iss": "bmb-starter-logistic.github.com",
      "aud": "ssr-client",
      "sub": "api",
      "name": "Quote app",
      "role": "dynamic",
      "exp": 2.day.from_now.to_i
    }
    
    jwt_token = JwtGenerator.encode(payload)
    "Bearer #{jwt_token}"
  end
end