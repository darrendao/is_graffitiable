module IsGraffitiable
  class GraffitiMap < Hash
    def initialize(args={})
      args.each do |key, value|
        self[key] = value
      end
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end
      
  module ClassMethods
    def is_graffitiable
      has_many :graffitis, :as => :graffitiable, :dependent => :destroy

      before_validation :initialize_graffitis, :validate_graffitis
      after_create :save_graffitis
      after_update :save_graffitis
          
      include IsGraffitiable::InstanceMethods
    end
  end
      
  module InstanceMethods
    def graffiti_map
      @graffiti_map = GraffitiMap.new
      graffitis.each do |graffiti|
        @graffiti_map[graffiti.name] = graffiti.value 
      end
      @graffiti_map
    end

    def initialize_graffitis
      return unless @graffiti_map
      new_graffiti_map = @graffiti_map.clone
      @new_graffitis = []

      graffitis.each do |graffiti|
        new_graffiti_map.delete(graffiti.name)
      end

      @old_graffitis = graffitis.reject{|graffiti| @graffiti_map.keys.include?(graffiti.name)}

      new_graffiti_map.each do |key,value|
        @new_graffitis << Graffiti.create(:name => key, :value => value)
      end
    end

    def validate_graffitis
      return true unless @graffiti_map

      @new_graffitis.each do |graffiti|
        unless graffiti.valid?
          errors.add("Graffiti", "is invalid")
          return false
        end
      end
      return true
    end
 
    def save_graffitis
      return unless @graffiti_map
        
      self.class.transaction do
        if @old_graffitis.any?
          @old_graffitis.each(&:destroy)
        end
        @new_graffitis.each do |graffiti|
          graffitis << graffiti
        end
      end
      true
    end
  end # InstanceMethods
end # IsGraffitiable

ActiveRecord::Base.send(:include, IsGraffitiable)
