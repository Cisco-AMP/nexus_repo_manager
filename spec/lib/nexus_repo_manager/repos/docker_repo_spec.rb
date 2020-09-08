require 'nexus_repo_manager/repos/repo'
require 'nexus_repo_manager/repos/docker_repo'

RSpec.describe 'NexusRepoManager::DockerRepo' do
  let(:data) { {
    'online' => 'online',
    'storage' => 'storage',
    'cleanup' => 'cleanup',
    'group' => 'group',
    'proxy' => 'proxy',
    'negativeCache' => 'negativeCache',
    'httpClient' => 'httpClient',
    'routingRule' => 'routingRule',
    'docker' => 'docker',
    'dockerProxy' => 'dockerProxy'
  } }

  describe '#generate_options' do
    describe 'with standard data' do
      before(:each) do
        @repo = NexusRepoManager::DockerRepo.new(data)
      end

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

      it 'supports docker settings' do
        expect(@repo.generate_options['docker']).to eq(data['docker'])
      end

      it 'supports dockerProxy settings' do
        expect(@repo.generate_options['dockerProxy']).to eq(data['dockerProxy'])
      end
    end

    describe 'with Docker Hub proxy type' do
      before(:each) do
        data['dockerProxy'] = {'indexType' => 'HUB'}
        data['httpClient'] = {'authentication' => {}}
        @repo = NexusRepoManager::DockerRepo.new(data)
      end

      it 'sets a docker username' do
        expect(@repo.generate_options['httpClient']['authentication']['username'])
          .to eq(ENV['DOCKER_HUB_USERNAME'])
      end

      it 'sets a docker password' do
        expect(@repo.generate_options['httpClient']['authentication']['password'])
          .to eq(ENV['DOCKER_HUB_PASSWORD'])
      end
    end
  end
end
