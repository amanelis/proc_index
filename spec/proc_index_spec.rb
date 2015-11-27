require 'spec_helper'
require 'proc_index'

describe ProcIndex do
  describe '.ps' do
    context 'returns true' do
      it { expect(ProcIndex.ps).to_not be_nil }
    end
  end
end
