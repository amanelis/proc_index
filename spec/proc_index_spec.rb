require 'spec_helper'
require 'proc_index'

describe ProcIndex do
  describe '.ps' do
    context 'returns an instance of ProcIndex::Container' do
      subject { ProcIndex.ps }
      it { expect(subject).to_not be_nil }
      it { expect(subject.body).to_not be_nil }
    end
  end

  describe '.search' do
    context 'returns a collection of Hashie::Mash objects' do
      subject { ProcIndex.search('ruby') }
      it { expect(subject).to_not be_nil }
      it { expect(subject.count).to be > 1}
    end
  end
end
