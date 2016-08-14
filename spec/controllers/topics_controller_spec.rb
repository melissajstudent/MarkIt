require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  before do
    @user = User.create!(email: 'member@example.com', password: 'helloworld', password_confirmation: 'helloworld')
    @user.confirm
    sign_in @user
    @my_topic = Topic.create!(title: Faker::Lorem.word, user: @user)
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: @my_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: @my_topic.id}
      expect(response).to render_template :show
    end

    it "assigns my_topic to @topic" do
      get :show, {id: @my_topic.id}
      expect(assigns(:topic)).to eq(@my_topic)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST create" do
    it "increases the number of topics by 1" do
      expect{ post :create, {topic: {title: Faker::Lorem.word}}}.to change(Topic,:count).by(1)
    end

    it "redirect to the new topic" do
      post :create, {topic: {title: Faker::Lorem.word}}
      expect(response).to redirect_to Topic.last
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {id: @my_topic.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the edit view" do
      get :edit, {id: @my_topic.id}
      expect(response).to render_template :edit
    end

    it "assigns topic to be updated to @topic" do
      get :edit, {id: @my_topic.id}
      topic_instance = assigns(:topic)

      expect(topic_instance.id).to eq @my_topic.id
      expect(topic_instance.title).to eq @my_topic.title
    end
  end

  describe "PUT update" do
    it "updates topic with expected attribute" do
      new_title = Faker::Lorem.word
      put :update, id: @my_topic.id, topic: { title: new_title }

      updated_topic = assigns(:topic)
      expect(updated_topic.id).to eq @my_topic.id
      expect(updated_topic.title).to eq new_title
    end

    it "redirects to the updated topic" do
      new_title = Faker::Lorem.word
      put :update, id: @my_topic.id, topic: { title: new_title }
      expect(response).to redirect_to @my_topic
    end
  end

  describe "DELETE destroy" do
    it "deletes the topic" do
      delete :destroy, {id: @my_topic.id }
      count = Topic.where({id: @my_topic.id}).size
      expect(count).to eq 0
    end

    it "redirects to topics index" do
      delete :destroy, {id: @my_topic.id}
      expect(response).to redirect_to root_url
    end
  end

end