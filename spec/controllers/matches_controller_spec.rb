require 'rails_helper'

RSpec.describe MatchesController, type: :controller do

  before do
    player1 = FactoryGirl.create(:player1)
    player2 = FactoryGirl.create(:player2)
  end

  let(:valid_attributes) {
    {date: '22-04-2015', winner_id: 1, loser_id: 2, loser_score: '5'}
  }

  let(:invalid_attributes) {
    {date: 'a', winner: 100, loser: 101, loser_score: '10'}
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all matches as @matches" do
      match = Match.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:matches)).to eq([match])
    end
  end

  context 'user is logged' do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:user)
    end

    describe "GET #new" do
      it "assigns a new match as @match" do
        get :new, {}, valid_session
        expect(assigns(:match)).to be_a_new(Match)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Match" do
          expect {
            post :create, {:match => valid_attributes}, valid_session
          }.to change(Match, :count).by(1)
        end

        it "assigns a newly created match as @match" do
          post :create, {:match => valid_attributes}, valid_session
          expect(assigns(:match)).to be_a(Match)
          expect(assigns(:match)).to be_persisted
        end

        it "redirects to the list of matches" do
          post :create, {:match => valid_attributes}, valid_session
          expect(response).to redirect_to(matches_path)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved match as @match" do
          post :create, {:match => invalid_attributes}, valid_session
          expect(assigns(:match)).to be_a_new(Match)
        end

        it "re-renders the 'new' template" do
          post :create, {:match => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end
  end

  context 'user is not logged' do

    describe "GET #new" do
      it "redirects to the sign in form" do
        get :new, {}, valid_session
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "does not create a new Match" do
          expect {
            post :create, {:match => valid_attributes}, valid_session
          }.to change(Match, :count).by(0)
        end

        it "redirects to the sign in form" do
          post :create, {:match => valid_attributes}, valid_session
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end
  end

end
