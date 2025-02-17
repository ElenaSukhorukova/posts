require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:new_post_params) do |ex|
    title = ex.metadata[:title] || Faker::Quote.robin
    login = ex.metadata[:login] || Faker::Name.first_name

    {
      post: {
        title: title,
        body: Faker::Quote.yoda,
        ip: Faker::Internet.ip_v4_address,
        user_attributes: {
          login: login
        }
      }
    }
  end

  describe 'index' do
    it 'checks html format of response' do
      get :index

      pp subject

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
      expect(response.content_type).to eq "text/html; charset=utf-8"
    end

    context "header 'Accept: application/json'" do
      include_context 'when it needed headers'

      before do
        request.headers.merge(header)
      end

      it 'checks json format of response' do
        get :index

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end
    end
  end

  describe 'new' do
    it 'shows a new template' do
      get :new

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:new)
    end
  end

  describe 'create' do
    it 'creates a new post' do
      post :create, params: new_post_params

      post = Post.last

      expect(response).to have_http_status(:found)
      expect(post.title).to eq(new_post_params.dig(:post, :title))
      expect(response).to redirect_to(root_path)
      expect(subject).to set_flash[:success]
    end

    context 'invalid request' do
      it 'checks flash of an invalid user', login: " " do
        post :create, params: new_post_params

        expect(response).to have_http_status(:bad_request)
        expect(response).to render_template(:new)
        expect(subject).to set_flash.now[:danger]
      end

      it 'checks flash of an invalid post', title: "Ph" do
        post :create, params: new_post_params

        expect(response).to have_http_status(:bad_request)
        expect(response).to render_template(:new)
        expect(subject).to set_flash.now[:danger]
      end
    end

    context "header 'Accept: application/json'" do
      include_context 'when it needed headers'

      before do
        request.headers.merge(header)
      end

      it 'creates a new post' do
        post :create, params: new_post_params

        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq "application/json; charset=utf-8"
      end
    end
  end
end
