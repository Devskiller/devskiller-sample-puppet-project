require 'spec_helper'
describe 'directory_creator' do

  context 'with default values for all parameters' do
    it { is_expected.to compile.and_raise_error(/expects a value for parameter 'directory'/) }
  end

  context 'with directory parameter set to not absolute path' do
    let(:params) {{
      :directory => 'no/an/absolute/path'
    }}
    it { is_expected.to compile.and_raise_error(/"no\/an\/absolute\/path" is not an absolute path/) }
  end

  context 'with directory parameter set' do
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
end
