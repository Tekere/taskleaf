class Task < ApplicationRecord
  validates :name, presence: true
  validates :name, length: {maximum: 30}
  # 同じカラムなら合体も可
  # validates :name, presence: true,length: {maximum: 30}
  
  validate :validate_name_not_including_comma
  
  before_validation :set_nameless_name
  
  
  private
  
  # 独自バリデーションルールの追加 （private内で定義する）
  # 上で validate を宣言する
  def validate_name_not_including_comma
    errors.add(:name, 'にカンマを含めることはできません') if name&.include?(',')
  end
  
  # コールバック関数を定義 呼び出されるタイミングは上で定義する
  def set_nameless_name
    self.name = '名前なし' if name.blank?
  end
  
end
