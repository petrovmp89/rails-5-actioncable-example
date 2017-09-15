require "rails_helper"

RSpec.describe News, type: :model do
  describe 'common validations' do
    it { should validate_presence_of :header }
    it { should validate_presence_of :annotation }
    it { should validate_presence_of :date }
  end

  describe 'validations for authored' do
    before { subject.authored_item = true }
    it { should validate_presence_of :expired_at }
  end
end
