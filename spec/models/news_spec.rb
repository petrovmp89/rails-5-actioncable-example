require "rails_helper"

RSpec.describe News, type: :model do
  describe 'validations' do
    it { should validate_presence_of :header }
    it { should validate_presence_of :annotation }
    it { should validate_presence_of :expired_at }
    it { should validate_presence_of :date }
  end
end
