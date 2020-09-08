require 'nexus_repo_manager/repo_factory'

RSpec.describe 'NexusRepoManager::RepoFactory' do
  describe '.build_repo' do
    it 'returns a Docker repo' do
      data = {'format' => 'docker'}
      expect(NexusRepoManager::RepoFactory.build_repo(data))
        .to be_a(NexusRepoManager::DockerRepo)
    end

    it 'returns a Maven repo' do
      data = {'format' => 'maven2'}
      expect(NexusRepoManager::RepoFactory.build_repo(data))
        .to be_a(NexusRepoManager::MavenRepo)
    end

    it 'returns a Npm repo' do
      data = {'format' => 'npm'}
      expect(NexusRepoManager::RepoFactory.build_repo(data))
        .to be_a(NexusRepoManager::NpmRepo)
    end

    it 'returns a Pypi repo' do
      data = {'format' => 'pypi'}
      expect(NexusRepoManager::RepoFactory.build_repo(data))
        .to be_a(NexusRepoManager::PypiRepo)
    end

    it 'returns a Raw repo' do
      data = {'format' => 'raw'}
      expect(NexusRepoManager::RepoFactory.build_repo(data))
        .to be_a(NexusRepoManager::RawRepo)
    end

    it 'returns a Rubygems repo' do
      data = {'format' => 'rubygems'}
      expect(NexusRepoManager::RepoFactory.build_repo(data))
        .to be_a(NexusRepoManager::RubygemsRepo)
    end

    it 'returns a Yum repo' do
      data = {'format' => 'yum'}
      expect(NexusRepoManager::RepoFactory.build_repo(data))
        .to be_a(NexusRepoManager::YumRepo)
    end

    it 'returns an error when an unsupported format is pased in' do
      error = 'error'
      data = {'format' => 'unsupported'}
      expect(NexusRepoManager::RepoFactory).to receive(:unsupported_format).and_return(error)
      expect(NexusRepoManager::RepoFactory.build_repo(data)).to eq(error)
    end
  end
end
