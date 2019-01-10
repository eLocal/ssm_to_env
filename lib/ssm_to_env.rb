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
      @ssm_parameters ||= load_ssm_parameters
    end

    def load!
      ssm_parameters.each do |param|
        target_hash[ssm_key_to_env_name_map[param.name]] = param.value
      end

      target_hash
    end

    private

    def load_ssm_parameters
      rv = []

      # Get 10 parameters at a time as this is a SSM limitation
      ssm_key_to_env_name_map.keys.each_slice(10) do |keys|
        rv += client.get_parameters(names: keys, with_decryption: with_decryption).parameters
      end

      rv
    end
  end
  #
  # params - Hash with keys being AWS SSM keys and values being environment variables to set
  #
  def self.load!(ssm_key_to_env_name_map, region: 'us-east-1')
    SsmToEnv::Loader.new(ssm_key_to_env_name_map, ENV, region).load!
  end
end
