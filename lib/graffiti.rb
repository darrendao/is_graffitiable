class Graffiti < ActiveRecord::Base
  belongs_to :graffitiable, :polymorphic => true

  validates_presence_of :name
  validates_presence_of :value
  def to_s
    name
  end
end
