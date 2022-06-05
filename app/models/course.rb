# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string           default("")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state      :integer          default(0)
#
class Course < ApplicationRecord

    has_many :videos
    has_many :categories, through: :videos, source: :categories

    has_many :comments, as: :commentable
    
    enum state: [:draft, :published] # ? - !

    def duration
        videos.sum('videos.duration')
    end
    
    def self.has_videos
        # joins("INNER JOIN videos ON courses.id = videos.course_id").where(videos: { visible: true })
        # joins("INNER JOIN videos ON courses.id = videos.course_id").where("videos.visible =? ", true )
        joins(:videos).where(videos: { visible: true })
        # joins(:videos).where("videos.visible =? ", true )
    end

    def self.has_video_with_duration
        joins(:videos).where(videos: { visible: true }).where("videos.duration > ?", 10).uniq
    end

    def self.no_has_videos
        joins("LEFT JOIN videos ON courses.id = videos.course_id").where("videos.id is NULL")
    end

end
