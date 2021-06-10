class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    # @tasks = Task.all
    
    # ユーザーに紐付くタスク一覧を取得(作成日でソート)
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
    # @task = Task.find(params[:id])
    
    # ユーザーに紐付くタスクの中から検索
    @tasks = set_task
  end

  def new
    @task = Task.new
  end

  def create
    # @taskに代入しておくことで、バリデーションエラー時に値を引き継げる
    # @task = Task.new(task_params)
    
    # user_idもくっつけるバージョン
    # 素直にやる
    # @task = Task.new(task_params.merge(user_id: current_user.id)) 
    # has_many belongs_to を定義してオブジェクト指向的に書く
    @task = current_user.tasks.new(task_params)
    
    
    # バリデーションに引っかかった場合の条件分岐 saveメソッドはバリデーション結果がbooleanで返る
    if @task.save
      redirect_to tasks_url, notice: "タスク「#{@task.name}」を登録しました" 
    else
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    task = Task.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "タスク「#{task.name}を更新しました」"
  end
  
  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}を削除しました」"
  end
  
  private
    def task_params
      params.require(:task).permit(:name, :description)
    end
    
    def set_task
      @task = current_user.tasks.find(params[:id])
    end
end
