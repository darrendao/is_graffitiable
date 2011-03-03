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
      has_many :graffitis, :as => :graffitiable
          
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

    def save_graffitis
      return unless @graffiti_map
        
      new_graffiti_map = @graffiti_map.clone
      updated_graffiti_map = {}
 
      graffitis.each do |graffiti|
        new_graffiti_map.delete(graffiti.name)
      end

      old_graffitis = graffitis.reject{|graffiti| @graffiti_map.keys.include?(graffiti.name)}
          
      self.class.transaction do
        if old_graffitis.any?
          old_graffitis.each(&:destroy)
        end
        new_graffiti_map.each do |key,value|
          graffitis << Graffiti.create(:name => key, :value => value)
        end
      end
          
      true
    end
  end # InstanceMethods
end # IsGraffitiable

ActiveRecord::Base.send(:include, IsGraffitiable)
