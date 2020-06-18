class Game < ApplicationRecord
  has_many :events
  has_one_attached :image

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
end
