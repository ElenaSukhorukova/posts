require 'rails_helper'

RSpec.describe RatingsController, type: :controller do
   include_context 'when it needed post and user'

  let(:new_rating_params) do |ex|
    value = ex.metadata[:value] || 5

    {
      rating: {
        user_id: user.id,
        post_id: posts.id,
        value: value
      }
    }
  end

  describe 'create' do
    it 'creates a new ratings' do
      post :create, params: new_rating_params, format: :turbo_stream

      rating = Rating.last

      expect(response).to have_http_status(:ok)
      expect(rating.user_id).to eq(new_rating_params.dig(:rating, :user_id))
    end

    context 'invalid request' do
      it 'checks flash of an invalid user', value: 6 do
        post :create, params: new_rating_params, format: :html

        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(root_path)
        expect(subject).to set_flash[:danger]
      end
    end

    context "header 'Accept: application/json'" do
      include_context 'when it needed headers'

      before do
        request.headers.merge(header)
      end

      it 'creates a new post' do
        post :create, params: new_rating_params

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end
    end
  end
end
