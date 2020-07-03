class InformationProvision < ApplicationRecord
  belongs_to :game

  validates :owner, presence: true, length: { maximum: 50 }
  validates :title, presence: true, length: { maximum: 100 }
  validates :name, length: { maximum: 50 }
  validates :contact, length: { maximum: 100 }
  #通常のvalidatesで文字制限すると改行を２文字にカウントする為に独自バリデーション
  validate :text_length
  validates :date, presence: true
  validate  :date_not_before_today

  def date_not_before_today
    errors.add(:date, "は今日以降のものを選択してください") if date.nil? || date < Date.today
  end

  def text_length
    content_for_validation = text.gsub(/\r\n/,"a")
    if content_for_validation.length > 2000
      errors.add(:text, "は2000文字以内で入力してください。")
    end
  end
end
