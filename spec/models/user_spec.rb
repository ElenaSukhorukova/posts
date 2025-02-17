require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    context 'validations' do
      it { should validate_presence_of(:login) }
      it { should validate_uniqueness_of(:login).case_insensitive }
    end

    context 'associations' do
      it { should have_many(:posts) }
      it { should have_many(:ratings) }
    end
  end
end
