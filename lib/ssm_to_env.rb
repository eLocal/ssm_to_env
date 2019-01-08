# frozen_string_literal: true

require 'ssm_to_env/version'

module SsmToEnv
  class Loader
    attr_reader :ssm_key_to_env_name_map, :target_hash, :with_decryption, :region
    def initialize(ssm_key_to_env_name_map, target_hash, region, with_decryption: true)
      @ssm_key_to_env_name_map = ssm_key_to_env_name_map
      @region = region
      @target_hash = target_hash
      @with_decryption = with_decryption
    end

    def client
      require 'aws-sdk-ssm'
      @client ||= Aws::SSM::Client.new(region: region)
    end

    def ssm_parameters
      @ssm_parameters ||= client.get_parameters(
        names: ssm_key_to_env_name_map.keys, with_decryption: with_decryption
      ).parameters
    end

    def load!
      ssm_parameters.each do |param|
        target_hash[ssm_key_to_env_name_map[param.name]] = param.value
      end

      target_hash
    end
  end
  #
  # params - Hash with keys being AWS SSM keys and values being environment variables to set
  #
  def self.load!(ssm_key_to_env_name_map, region: 'us-east-1')
    SsmToEnv::Loader.new(ssm_key_to_env_name_map, ENV, region).load!
  end
end
