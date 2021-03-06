module JsonSearch
  module Searchable
  
    module ClassMethods
      def all_from_json(json = {})
        json = JSON.parse(json) if json.is_a?(String)
    
        if json.is_a?(Array)
          json = { "conditions" => { "and" => json } }
        end
    
        if json["conditions"].blank? && !json["and"].blank?
          json = { "conditions" => json }
        end
    
        json["model"] = name
        json["repository"] = default_repository_name
    
        DataMapper::Query.from_hash(json).all
      end
    end
  
  end
end