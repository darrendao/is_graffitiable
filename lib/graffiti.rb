class Graffiti < ActiveRecord::Base
  belongs_to :graffitiable, :polymorphic => true

  validates_presence_of :name
  validates_presence_of :value
  validates_presence_of :graffitiable_id
  validates_presence_of :graffitiable_type
  def to_s
    name
  end
end
