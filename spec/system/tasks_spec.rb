require 'rails_helper'

describe 'タスク管理機能', type: :system do
  # let を使って上のを共通化
  # ユーザーAを作成しておく
  # ユーザーBも作成
  let!(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@example.com') }
  let!(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@example.com') }
  # ユーザーAのタスクを作成
  let!(:task_a) { FactoryBot.create(:task, name: '最初のタスク', user: user_a ) }
  
  before do
    
    visit login_path
    fill_in 'メールアドレス', with: login_user.email
    fill_in 'パスワード', with: login_user.password
    click_button 'ログインする'
   end 
  
  # 
  # 一覧表示機能のテスト
  # 
  describe '一覧表示機能'  do
    context 'ユーザーAがログインしているとき' do 
      let(:login_user){ user_a }

      
      it 'ユーザーAが作成したタスクが表示される' do
        # 作成済みのタスクの名称が画面上に表示されていることを確認
        expect(page).to have_content '最初のタスク'
        # 直訳） ページに、期待する。 → 最初のタスクというコンテンツを
      end
      
    end
    
    # ユーザーBにはユーザーAのタスクが表示されないことをテスト
    context 'ユーザーBでログインしているとき' do
      let(:login_user){ user_b }

      it 'ユーザーAが作成したタスクが表示されない' do
        expect(page).to have_no_content '最初のタスク'
      end
    end 
  end
  
  # 
  # 詳細表示機能のテスト
  # 
  describe '詳細表示機能' do
    context 'ユーザーAがログインしているとき' do
      let(:login_user){ user_a }
      
      before do
        visit task_path(task_a)
      end 
      it 'ユーザーAが作成したタスクが表示される' do
        expect(page).to have_content '最初のタスク'
      end 
    end 
  end 
  
  # 
  # 新規作成のテスト
  # 
  describe '新規作成機能' do
    let(:login_user){ user_a }
    
    before do
      visit new_task_path
      fill_in 'Name', with: task_name
      click_button 'Create Task'
    end
    
    context '新規画面で名称を入力したとき' do
      let(:task_name){ '新規作成のテストを書く' }
      
      it '正常に登録される' do
        expect(page).to have_selector '.alert-success', text: '新規作成のテストを書く'
      end
    end
    
    # 不要にした！ 名前なしで自動作成される設計なので
    # context '新規作成画面で名称を入力しなかったとき' do
      
    #   it 'エラーとなる' do
    #     within '#error_explanation' do
    #       expect(page).to have_content '名称を入力してください'
    #     end 
    #   end 
    # end 
    
  end 
end

