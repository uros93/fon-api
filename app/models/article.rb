class Article < ActiveModelSerializers::Model
	derive_attributes_from_names_and_fix_accessors
  attributes :title, :description, :link, :image
end