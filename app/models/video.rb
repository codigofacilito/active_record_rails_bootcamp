# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  visible     :boolean
#  duration    :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Video < ApplicationRecord

    validates :title, presence: true
    validates :title, uniqueness: true
    validates :title, length: { maximum: 200, minimum: 2 }
    
    validate :validate_custome_title
    validate :validate_custome_attr

    before_create :send_mail, if: :has_description?
    after_update :show_title

    before_save :show_title

    scope :has_duration, -> { where('duration >= ?', 0) }
    scope :has_description, -> { where.not(description:nil) }

    scope :has_description_and_duration, -> { has_description.has_duration }

    def has_description?
        !description.nil? && !description.empty?
    end

    def self.custome_join
        where(description:nil)
        .where(duration:0)
        .order('id DESC')
    end

    private

    def send_mail
        puts ">>>> Send Mail"
    end

    def show_title
        puts ">>>> Nos encontramos en el método Show Title"
    end

    def validate_custome_title
        self.errors.add(:title, 'No es posible usar ese título.') if self.title == 'CódigoFacilito'
    end

end
