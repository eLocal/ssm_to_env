require 'aws-sdk-ssm'

RSpec.describe SsmToEnv do
  let(:param_value) { 'bar' }
  let(:ssm_key) { '/foo/bar' }
  let(:env_key) { 'FOOBAR' }

  let(:ssm_parameter) { instance_double('MockedParam', name: ssm_key, value: param_value) }
  let(:ssm_parameters) { instance_double('SSMResponse', parameters: [ssm_parameter]) }
  let(:stubbed_client) { instance_double('Aws::SSM::Client', get_parameters: ssm_parameters) }

  before do
    allow(Aws::SSM::Client).to receive(:new).and_return(stubbed_client)
    described_class.load!(ssm_key => env_key)
  end

  it "has a version number" do
    expect(SsmToEnv::VERSION).not_to be nil
  end

  it 'sets the ENV value' do
    expect(ENV[env_key]).to eq(param_value)
  end

  it 'calls SSM get_parameters' do
    expect(stubbed_client).to have_received(:get_parameters)
  end
end
