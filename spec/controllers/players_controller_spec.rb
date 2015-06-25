require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  let(:player1) { create(:player1) }

  context 'user is not logged' do
	describe 'POST #create' do
	  context 'with valid attributes' do
	    it 'does not creates the player' do
	      post :create, player: attributes_for(:player1)
	      expect(Player.count).to eq(0)
	    end

	    it 'redirects to the "sign_in" action' do
	      post :create, player: attributes_for(:player1)
	      expect(response).to redirect_to new_user_session_path
	    end
	  end
	end

	describe 'POST #update' do
	  context 'with valid attributes' do
	    it 'redirects to the "sign_in" action' do
	      put :update, {:id => player1, :player => attributes_for(:player2)}
	      expect(response).to redirect_to new_user_session_path
	    end
	  end
	end

	describe 'DELETE #destroy' do
	  context 'with valid attributes' do
	    it 'redirects to the "sign_in" action' do
	      delete :destroy, {:id => player1}
	      expect(response).to redirect_to new_user_session_path
	    end
	  end
	end
  end

  context 'user is logged' do
    before do
	  @request.env["devise.mapping"] = Devise.mappings[:user]
	  sign_in create(:user)
	end

	describe 'POST #create' do
	  context 'with valid attributes' do
	    it 'creates the player' do
	      post :create, player: attributes_for(:player1)
	      expect(Player.count).to eq(1)
	    end

	    it 'redirects to the "show" action for the new player' do
	      post :create, player: attributes_for(:player1)
	      expect(response).to redirect_to Player.first
	    end
	  end

	  context 'with invalid attributes' do
        it 'does not create the player' do
          post :create, player: attributes_for(:player, firstname: nil)
          expect(Player.count).to eq(0)
      	end

        it 're-renders the "new" view' do
          post :create, player: attributes_for(:player, firstname: nil)
          expect(response).to render_template :new
        end
      end
	end

	describe 'POST #update' do
	  context 'with valid attributes' do
	    it 'redirects to the "show" action for the updated player' do
	      put :update, {:id => player1, :player => attributes_for(:player2)}
	      expect(response).to redirect_to Player.first
	    end
	  end
	end

	describe 'DELETE #destroy' do
	  context 'with valid attributes' do
	    it 'deletes the player' do
	      delete :destroy, {:id => player1}
	      expect(Player.count).to eq(0)
	    end
	  end
	end
  end

end
