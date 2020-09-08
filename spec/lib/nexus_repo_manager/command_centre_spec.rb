require 'nexus_repo_manager/command_centre'

RSpec.describe 'NexusRepoManager::CommandCentre' do

  before(:each) do
    @command_centre = NexusRepoManager::CommandCentre.new('qa')
  end

  describe '#all_repo_names' do
    it 'gets a list of all repositories in Nexus' do
      list = ['repo1', 'repo2']
      expect(@command_centre.nexus_api).to receive(:list_repository_names).and_return(list)
      @command_centre.all_repo_names
    end
  end

  describe '#run' do
    let(:repo) { double }
    let(:repo_name) { 'repo_name' }

    let(:group_repo) { double }
    let(:group_repo_name) { 'group_repo_name' }

    before(:each) do
      allow(repo).to receive(:name).and_return(repo_name)
      allow(repo).to receive(:type).and_return('type')
      allow(repo).to receive(:format).and_return('format')

      allow(group_repo).to receive(:name).and_return(group_repo_name)
      allow(group_repo).to receive(:type).and_return('group')
      allow(group_repo).to receive(:format).and_return('format')
    end

    it 'creates a repo' do
      @command_centre.repos = [repo]
      expect(@command_centre).to receive(:all_repo_names).and_return([])
      expect(repo).to receive(:create).with(@command_centre.nexus_api).and_return(true)
      expect { @command_centre.run }.to output(/creating/i).to_stdout
    end

    it 'skips a repo if it already exists' do
      @command_centre.repos = [repo]
      expect(@command_centre).to receive(:all_repo_names).and_return([repo_name])
      expect(repo).to_not receive(:create)
      expect { @command_centre.run }.to output(/skipping/i).to_stdout
    end

    it 'outputs a warning when repo creation fails' do
      @command_centre.repos = [repo]
      expect(@command_centre).to receive(:all_repo_names).and_return([])
      expect(repo).to receive(:create).with(@command_centre.nexus_api).and_return(false)
      expect { @command_centre.run }.to output(/warning/i).to_stdout
    end

    it 'creates group repos last' do
      @command_centre.repos = [group_repo, repo]
      expect(@command_centre).to receive(:all_repo_names).and_return([])
      expect(repo).to receive(:create).with(@command_centre.nexus_api).and_return(true)
      expect(group_repo).to receive(:create).with(@command_centre.nexus_api).and_return(true)
      expect { @command_centre.run }.to output(/#{repo_name}.*#{group_repo_name}/m).to_stdout
    end
  end
end