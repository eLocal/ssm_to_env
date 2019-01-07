# frozen_string_literal: true

require "ssm_to_env/version"

module SsmToEnv
  #
  # params - Hash with keys being AWS SSM keys and values being environment variables to set
  #
  def self.load!(ssm_key_to_env_name_map, region: 'us-east-1')
    require 'aws-sdk-ssm'
    client = Aws::SSM::Client.new(region: region)
    client.get_parameters(names: ssm_key_to_env_name_map.keys, with_decryption: true).parameters.each do |param|
      ENV[ssm_key_to_env_name_map[param.name]] = param.value
    end
  end
end
