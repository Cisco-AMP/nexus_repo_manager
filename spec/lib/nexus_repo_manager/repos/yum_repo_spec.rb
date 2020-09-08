require 'nexus_repo_manager/repos/repo'
require 'nexus_repo_manager/repos/yum_repo'

RSpec.describe 'NexusRepoManager::YumRepo' do
  let(:data) { {
    'online' => 'online',
    'storage' => 'storage',
    'cleanup' => 'cleanup',
    'group' => 'group',
    'proxy' => 'proxy',
    'negativeCache' => 'negativeCache',
    'httpClient' => 'httpClient',
    'routingRule' => 'routingRule',
    'yum' => 'yum'
  } }

  before(:each) do
    @repo = NexusRepoManager::YumRepo.new(data)
  end

  describe '#generate_options' do
    it 'supports online settings' do
      expect(@repo.generate_options['online']).to eq(data['online'])
    end

    it 'supports storage settings' do
      expect(@repo.generate_options['storage']).to eq(data['storage'])
    end

    it 'supports cleanup settings' do
      expect(@repo.generate_options['cleanup']).to eq(data['cleanup'])
    end

    it 'supports group settings' do
      expect(@repo.generate_options['group']).to eq(data['group'])
    end

    it 'supports proxy settings' do
      expect(@repo.generate_options['proxy']).to eq(data['proxy'])
    end

    it 'supports negativeCache settings' do
      expect(@repo.generate_options['negativeCache']).to eq(data['negativeCache'])
    end

    it 'supports httpClient settings' do
      expect(@repo.generate_options['httpClient']).to eq(data['httpClient'])
    end

    it 'supports routingRule settings' do
      expect(@repo.generate_options['routingRule']).to eq(data['routingRule'])
    end

    it 'supports yum settings' do
      expect(@repo.generate_options['yum']).to eq(data['yum'])
    end
  end
end
