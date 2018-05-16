require 'spec_helper'
describe 'tcpwrappers' do
  context 'with default values for all parameters' do
    it { should contain_class('tcpwrappers') }
  end
end
