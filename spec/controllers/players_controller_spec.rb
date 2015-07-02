require 'rails_helper'

RSpec.describe PlayersController, type: :controller do

  let(:valid_attributes) {
    FactoryGirl.attributes_for(:player1)
  }

  let(:invalid_attributes) {
    {firstname: '', lastname: '', email: 'aaa@com'}
  }

  let(:valid_session) { {} }

  context 'user is logged' do

    before do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in create(:user)
    end

    describe "GET #index" do
      it "assigns all players as @players" do
        player = Player.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:players)).to eq([player])
      end
    end

    describe "GET #show" do
      it "assigns the requested player as @player" do
        player = Player.create! valid_attributes
        get :show, {:id => player.to_param}, valid_session
        expect(assigns(:player)).to eq(player)
      end
    end

    describe "GET #new" do
      it "assigns a new player as @player" do
        get :new, {}, valid_session
        expect(assigns(:player)).to be_a_new(Player)
      end
    end

    describe "GET #edit" do
      it "assigns the requested player as @player" do
        player = Player.create! valid_attributes
        get :edit, {:id => player.to_param}, valid_session
        expect(assigns(:player)).to eq(player)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Player" do
          expect {
            post :create, {:player => valid_attributes}, valid_session
          }.to change(Player, :count).by(1)
        end

        it "assigns a newly created player as @player" do
          post :create, {:player => valid_attributes}, valid_session
          expect(assigns(:player)).to be_a(Player)
          expect(assigns(:player)).to be_persisted
        end

        it "redirects to the created player" do
          post :create, {:player => valid_attributes}, valid_session
          expect(response).to redirect_to(Player.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved player as @player" do
          post :create, {:player => invalid_attributes}, valid_session
          expect(assigns(:player)).to be_a_new(Player)
        end

        it "re-renders the 'new' template" do
          post :create, {:player => invalid_attributes}, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {firstname: 'Alex', lastname: 'Coper', email: 'alex.coper@example.localhost'}
        }

        it "updates the requested player" do
          player = Player.create! valid_attributes
          put :update, {:id => player.to_param, :player => new_attributes}, valid_session
          player.reload
          expect(player.firstname).to eq('Alex')
          expect(player.lastname).to eq('Coper')
          expect(player.email).to eq('alex.coper@example.localhost')
        end

        it "assigns the requested player as @player" do
          player = Player.create! valid_attributes
          put :update, {:id => player.to_param, :player => valid_attributes}, valid_session
          expect(assigns(:player)).to eq(player)
        end

        it "redirects to the player" do
          player = Player.create! valid_attributes
          put :update, {:id => player.to_param, :player => valid_attributes}, valid_session
          expect(response).to redirect_to(player)
        end
      end

      context "with invalid params" do
        it "assigns the player as @player" do
          player = Player.create! valid_attributes
          put :update, {:id => player.to_param, :player => invalid_attributes}, valid_session
          expect(assigns(:player)).to eq(player)
        end

        it "re-renders the 'edit' template" do
          player = Player.create! valid_attributes
          put :update, {:id => player.to_param, :player => invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested player" do
        player = Player.create! valid_attributes
        expect {
          delete :destroy, {:id => player.to_param}, valid_session
        }.to change(Player, :count).by(-1)
      end

      it "redirects to the players list" do
        player = Player.create! valid_attributes
        delete :destroy, {:id => player.to_param}, valid_session
        expect(response).to redirect_to(players_url)
      end
    end
  end


  context 'user is not logged' do

    describe "GET #index" do
      it "assigns all players as @players" do
        player = Player.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:players)).to eq([player])
      end
    end

    describe "GET #show" do
      it "assigns the requested player as @player" do
        player = Player.create! valid_attributes
        get :show, {:id => player.to_param}, valid_session
        expect(assigns(:player)).to eq(player)
      end
    end

    describe "GET #new" do
      it "redirects to the sign in form" do
        get :new, {}, valid_session
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "GET #edit" do
      it "redirects to the sign in form" do
        player = Player.create! valid_attributes
        get :edit, {:id => player.to_param}, valid_session
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "does not create a new Player" do
          expect {
            post :create, {:player => valid_attributes}, valid_session
          }.to change(Player, :count).by(0)
        end

        it "redirects to the sign in form" do
          post :create, {:player => valid_attributes}, valid_session
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) {
          {firstname: 'Alex', lastname: 'Coper', email: 'alex.coper@example.localhost'}
        }

        it "does not update the requested player" do
          player = Player.create! valid_attributes
          put :update, {:id => player.to_param, :player => new_attributes}, valid_session
          player.reload
          expect(player.firstname).to_not eq('Alex')
          expect(player.lastname).to_not eq('Coper')
          expect(player.email).to_not eq('alex.coper@example.localhost')
        end

        it "redirects to the sign in form" do
          player = Player.create! valid_attributes
          put :update, {:id => player.to_param, :player => valid_attributes}, valid_session
          expect(response).to redirect_to(new_user_session_path)
        end
      end
    end

    describe "DELETE #destroy" do
      it "does not destroy the requested player" do
        player = Player.create! valid_attributes
        expect {
          delete :destroy, {:id => player.to_param}, valid_session
        }.to change(Player, :count).by(0)
      end

      it "redirects to the sign in form" do
        player = Player.create! valid_attributes
        delete :destroy, {:id => player.to_param}, valid_session
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
