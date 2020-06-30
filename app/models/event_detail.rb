class EventDetail < ApplicationRecord
  belongs_to :event
  belongs_to :game
  belongs_to :user
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true
  
  validates :owner, presence: true, length: { maximum: 50 }
  validates :title, presence: true, length: { maximum: 100 }
  #通常のvalidatesで文字制限すると改行を２文字にカウントする為に独自バリデーション
  validate :text_length
  validates :date, presence: true
  validate  :date_not_before_today

  has_one_attached :image

  scope :game_search, ->(name) {
    where(game_id: name.to_i) if name.present?
  }

  scope :tags_search, ->(tags, titles, owners) {
    if tags.present? || titles.present? || owners.present?
      where(id: tags).or(where(id: titles)).or(where(id: owners))
    end
  }
  
  def date_not_before_today
    errors.add(:date, "は今日以降のものを選択してください") if date.nil? || date < Date.today
  end

  validate :validate_image

  def validate_image
    return unless image.attached?
    if image.blob.byte_size > 5.megabytes
      errors.add(:image, I18n.t('ファイルサイズが5Mまでです'))
    elsif !image?
      errors.add(:image, I18n.t('投稿できるファイルは画像のみです'))
    end
  end

  def image?
    %w[image/jpg image/jpeg image/gif image/png].include?(image.blob.content_type)
  end

  def text_length
    content_for_validation = text.gsub(/\r\n/,"a")
    if content_for_validation.length > 2000
      errors.add(:text, "は2000文字以内で入力してください。")
    end
  end
end
