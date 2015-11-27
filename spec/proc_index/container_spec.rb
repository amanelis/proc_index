require 'spec_helper'
require 'proc_index'

require 'open3'

describe ProcIndex::Container do
  context '.new' do
    let(:data) {
      stdin, stdout, stderr = Open3.popen3("ps aux")
      data = stdout.read
      data
    }

    subject { ProcIndex::Container.new(ProcIndex::Fields, data) }

    it { expect(subject).to_not be_nil }
    it { expect(subject.body).to_not be_nil }
    it { expect(subject.key).to_not be_nil }
    it { expect(subject.fields).to eq(ProcIndex::Fields) }
  end
end
