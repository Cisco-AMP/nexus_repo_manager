require 'nexus_repo_manager/repos/repo'

RSpec.describe 'NexusRepoManager::Repo' do
  let(:api) { double }

  describe '#create' do
    let(:data) { {
        'name' => 'name',
        'format' => 'format'
    } }

    it 'creates a group repo' do
      data['type'] = 'group'
      repo = NexusRepoManager::Repo.new(data)

      expect(repo).to receive(:generate_group_members).and_return([])
      expect(repo).to_not receive(:generate_proxy_url)
      expect(repo).to receive(:generate_options).and_return({})

      expect(api).to receive(:create_repository_format_group)
      repo.create(api)
    end

    it 'creates a hosted repo' do
      data['type'] = 'hosted'
      repo = NexusRepoManager::Repo.new(data)

      expect(repo).to_not receive(:generate_group_members)
      expect(repo).to_not receive(:generate_proxy_url)
      expect(repo).to receive(:generate_options).and_return({})

      expect(api).to receive(:create_repository_format_hosted)
      repo.create(api)
    end

    it 'creates a proxy repo' do
      data['type'] = 'proxy'
      repo = NexusRepoManager::Repo.new(data)

      expect(repo).to_not receive(:generate_group_members)
      expect(repo).to receive(:generate_proxy_url).and_return('')
      expect(repo).to receive(:generate_options).and_return({})

      expect(api).to receive(:create_repository_format_proxy)
      repo.create(api)
    end

    it 'returns an error when an unsupported type is pased in' do
      error = 'error'
      data['type'] = 'unsupported'
      repo = NexusRepoManager::Repo.new(data)

      expect(repo).to_not receive(:generate_group_members)
      expect(repo).to_not receive(:generate_proxy_url)
      expect(repo).to_not receive(:generate_options)

      expect(repo).to receive(:unsupported_type).and_return(error)
      expect(repo.create(api)).to eq(error)
    end
  end
end