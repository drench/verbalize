require 'verbalize/action'

describe 'Interactor class inheritance' do
  let(:parent) { Class.new { include Verbalize::Action; def call; arg; end } }
  let(:child) { Class.new(parent) }

  context 'with required input' do
    before { parent.send(:input, :arg) }

    it { expect(parent.call!(arg: :value)).to eq(child.call!(arg: :value)) }
  end

  context 'with an optional input' do
    context 'with no default value' do
      before { parent.send(:input, optional: [:arg]) }

      context 'when passing in a value' do
        it 'uses the provided value' do
          expect(parent.call!(arg: :value))
            .to eq(:value)
            .and eq(child.call!(arg: :value))
        end
      end

      context 'when not passing in a value' do
        it 'defaults to nil' do
          expect(parent.call!).to be_nil.and eq(child.call!)
        end
      end
    end

    context 'with a static default value' do
      before { parent.send(:input, optional: [arg: 'static default']) }

      context 'when passing in a value' do
        it 'uses the provided value' do
          expect(parent.call!(arg: :value))
            .to eq(:value)
            .and eq(child.call!(arg: :value))
        end
      end

      context 'when not passing in a value' do
        it 'uses the default' do
          expect(parent.call!).to eq('static default').and eq(child.call!)
        end
      end
    end

    context 'with a dynamic default value' do
      before { parent.send(:input, optional: [arg: -> { 'dynamic default'}]) }

      context 'when passing in a value' do
        it 'uses the provided value' do
          expect(parent.call!(arg: :value))
            .to eq(:value)
            .and eq(child.call!(arg: :value))
        end
      end

      context 'when not passing in a value' do
        it 'uses the default' do
          expect(parent.call!).to eq('dynamic default').and eq(child.call!)
        end
      end
    end
  end
end
