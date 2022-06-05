# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  visible    :boolean          default(TRUE)
#
class Category < ApplicationRecord

    has_many :video_categories

end
