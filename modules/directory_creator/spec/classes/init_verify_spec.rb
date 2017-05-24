require 'spec_helper'
describe 'directory_creator' do

  context 'Verification with default values for all parameters' do
    it { is_expected.to compile.and_raise_error(/expects a value for parameter 'directory'/) }
  end

  context 'Verification with directory parameter set to not absolute path' do
    let(:params) {{
      :directory => 'no/an/absolute/path'
    }}
    it { is_expected.to compile.and_raise_error(/not an absolute path/) }
  end

  context 'Verification with directory parameter set to an empty string' do
    let(:params) {{
      :directory => ''
    }}
    it { is_expected.to compile.and_raise_error(/not an absolute path/) }
  end

  context 'Verification with directory parameter set' do
    let(:params) {{
      :directory => '/var/lib/foo'
    }}
    it { is_expected.to compile }
    it do
      is_expected.to contain_file('/var/lib/foo').with({
        :ensure => 'directory',
        :owner  => 'root',
        :group  => 'root',
      })
    end
  end

  context 'Verification with custom owner and group' do
    let(:params) {{
      :directory => '/var/lib/foo',
      :owner     => 'fizz',
      :group     => 'buzz',
    }}
    it { is_expected.to compile }
    it do
      is_expected.to contain_file('/var/lib/foo').with({
        :ensure => 'directory',
        :owner  => 'fizz',
        :group  => 'buzz',
      })
    end
  end
end
