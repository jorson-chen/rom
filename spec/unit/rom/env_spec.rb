require 'spec_helper'

describe ROM::Env do
  include_context 'users and tasks'

  before { setup.relation(:users) }

  it 'exposes repositories on method-missing' do
    expect(rom.default).to be(rom.repositories[:default])
  end

  it 'responds to methods corresponding to repository names' do
    expect(rom).to respond_to(:default)
  end

  it 'raises exception when unknown repository is referenced' do
    expect { rom.not_here }.to raise_error(NoMethodError)
  end
end
