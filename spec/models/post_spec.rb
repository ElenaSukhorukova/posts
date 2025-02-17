require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    context 'validations' do
      it { should validate_presence_of(:title) }
      it { should validate_length_of(:title).is_at_least(3).is_at_most(50) }

      it { should validate_presence_of(:ip) }
      it { should validate_length_of(:ip).is_at_least(9).is_at_most(15) }

      it { should validate_presence_of(:body) }
      it { should validate_length_of(:body).is_at_most(5000) }
    end

    context 'associations' do
      it { should belong_to(:user) }
      it { should have_many(:ratings) }
    end
  end
end
