require 'spec_helper'

describe SerialPreference::SafeYamlCoder do
  describe '.load' do
    it 'returns an empty hash when safe loading fails' do
      allow(Psych).to receive(:safe_load).and_raise(Psych::DisallowedClass)

      expect(described_class.load('--- !ruby/object:Kernel {}')).to eq({})
    end

    it 'loads symbols safely when supported by psych' do
      yaml = "---\n:foo: :bar\n"
      data = described_class.load(yaml)
      expect(data).to eq(foo: :bar)
    end
  end
end
