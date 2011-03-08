class Graffiti < ActiveRecord::Base
  belongs_to :graffitiable, :polymorphic => true

  validates_presence_of :name
  validates_presence_of :value
  validates_presence_of :graffitiable_id
  validates_presence_of :graffitiable_type
  validates_uniqueness_of :name, :scope => [:graffitiable_id, :graffitiable_type]
  def to_s
    name
  end
end
