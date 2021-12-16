# frozen_string_literal: true

RSpec.describe WoW::DBC do
  it 'has a version number' do
    expect(WoW::DBC::VERSION).not_to be nil
  end
end
