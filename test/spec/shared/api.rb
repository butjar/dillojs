# encoding: UTF-8

shared_examples 'api' do
  describe service 'dillojs-api' do
    it { expect(subject).to be_enabled }
    it { expect(subject).to be_running }
  end
end
