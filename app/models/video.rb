# == Schema Information
#
# Table name: videos
#
#  id          :integer          not null, primary key
#  title       :string
#  description :string
#  visible     :boolean          default(FALSE)
#  duration    :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  course_id   :integer          not null
#
class Video < ApplicationRecord

    belongs_to :course
    has_many :video_categories
    has_many :comments, as: :commentable

    has_many :categories, through: :video_categories, after_add: :new_category
    
    has_many :categorias_visibles, -> { where('categories.visible = ?', true ) }, through: :video_categories, source: :category
    has_many :categorias_novisibles, -> { where('categories.visible = ?', false ) }, through: :video_categories, source: :category

    validates :title, presence: true
    validates :title, uniqueness: true
    validates :title, length: { maximum: 200, minimum: 2 }
    
    validate :validate_custome_title

    scope :has_duration, -> { where('duration >= ?', 0) }
    scope :has_description, -> { where.not(description:nil) }

    scope :has_description_and_duration, -> { has_description.has_duration }

    def has_description?
        !description.nil? && !description.empty?
    end

    private

    def new_category(category)
        puts ">>> Se añadio al vídeo #{title} la category #{category.title}"
    end

    def validate_custome_title
        self.errors.add(:title, 'No es posible usar ese título.') if self.title == 'CódigoFacilito'
    end

end
