require 'spec_helper'

describe Admin::UsersController do
  let!(:pupkin) { create(:user, admin: true) }
  let!(:hacker) { create(:user, email: "hacker@hack.er") }
  let!(:article) { create(:post, user_id: hacker.id) }
  let!(:comment) { create(:comment, user_id: hacker.id, commentable: article) }

  describe "GET 'index'" do
    it "assigns all users" do
      sign_in_as(pupkin)
      get 'index'
      assigns(:users).should =~[pupkin, hacker]
    end
  end

  describe "GET 'destroy'" do
    context "user is admin"
    it "should delete user with comments" do
      sign_in_as(pupkin)
      expect { delete :destroy, id: hacker.id }.to change { User.count }.by(-1)

    end

    context "user isn't admin"
    it "should NOT delete user" do
      sign_in_as(hacker)
      expect { delete :destroy, id: hacker.id }.to_not change { User.count }

    end
  end

  describe "GET 'update'" do
    def do_update(params = {})
      put :update, params
    end

    context "when user is admin" do
      it "should update user params" do
        sign_in_as(pupkin)

        expect { do_update id: hacker.id, user: { admin: true } }.to change { User.find(hacker.id).admin }.to(true)
      end

      it "should not update last admin for not admin" do
        sign_in_as(pupkin)
        expect { do_update id: pupkin.id, user: { admin: false } }.to_not change { User.find(pupkin.id).admin }.to(false)
      end

      it "should update last admin for not admin" do
        create(:user, email: "new@new.com", admin: true)
        sign_in_as(pupkin)
        expect { do_update id: pupkin.id, user: { admin: false } }.to change { User.find(pupkin.id).admin }.to(false)
      end
    end

    context "when user isn't admin" do
      it "should update user params" do
        sign_in_as(hacker)
        expect { do_update id: hacker.id, user: { admin: true } }.to_not change { User.find(hacker.id).admin }.to(true)
      end
    end
  end

end
