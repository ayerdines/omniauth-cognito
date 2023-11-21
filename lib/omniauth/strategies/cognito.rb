# frozen_string_literal: true

require "uri"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Cognito < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = "openid email profile phone aws.cognito.signin.user.admin"

      option :name, "cognito"
      option :scope, DEFAULT_SCOPE
      option :client_options, {
        site: "https://mydomain.auth.ap-south-1.amazoncognito.com",
        authorize_url: "/oauth2/authorize",
        token_url: "/oauth2/token",
        user_info_url: "/oauth2/userInfo",
        response_type: "code",
        auth_scheme: "request_body"
      }

      uid { raw_info["sub"] }

      info do
        {
          name: raw_info["name"],
          email: raw_info["email"],
          first_name: raw_info["given_name"],
          last_name: raw_info["family_name"],
          preferred_username: raw_info["preferred_username"],
          phone_number: raw_info["phone_number"],
          phone_number_verified: raw_info["phone_number_verified"],
          email_verified: raw_info["email_verified"]
        }
      end

      def user_info_url
        URI.join(options.client_options.site, options.client_options.user_info_url).to_s
      end

      def raw_info
        @raw_info ||= access_token.get(options.client_options.user_info_url).parsed
      end

      def callback_url
        options[:redirect_uri] || (full_host + callback_path)
      end
    end
  end
end
