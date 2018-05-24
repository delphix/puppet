require 'spec_helper'

describe 'delphix::targethost' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let :params do
        {
          'delphix_user'     => 'delphix',
          'delphix_group'    => 'delphix',
          'delphix_mount'    => '/mnt/delphix',
          'delphix_toolkit'  => '/home/delphix/toolkit',
          'delphix_ssh_user' => '',
          'delphix_ssh_key'  => '',
        }
      end

      it { is_expected.to compile }
    end
  end
end
