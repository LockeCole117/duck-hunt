require File.expand_path('../../test_helper', __FILE__)


describe ObjectSchemas::Schemas::SchemaDefinition, "defining an object through a block" do
	it "should accept a block through the `define` method and use it create a new instance of the class" do
		schema = TestSchema.define do |s|
			s.strict!
		end

		schema.strict_mode.must_equal true
		schema.strict_mode?.must_equal true
	end

	it "should still call the `initialize` method defined in the class when `define` is used" do
		# skip "Need to find a way to call both initialize methods"
		schema = TestSchema.define do |s|
			s.strict!
		end

		schema.strict_mode.must_equal true
		schema.strict_mode?.must_equal true
		schema.favorite_show.must_equal "Doctor Who"
	end

	it "should default the `strict mode` to `false`" do
		schema = TestSchema.define do |s|
		end

		schema.strict_mode.must_equal false
		schema.strict_mode?.must_equal false
	end

	it "should be able to define a property in the schema" do
		schema = TestSchema.define do |s|
			s.test "name"
		end

		schema.properties.size.must_equal 1
		schema.properties["name"].name.must_equal "name"
		schema.properties["name"].required?.must_equal true
	end

	it "should be able to set the options of a property in the schema" do
		schema = TestSchema.define do |s|
			s.test "name", :required => false
		end

		schema.properties.size.must_equal 1
		schema.properties["name"].name.must_equal "name"
		schema.properties["name"].required?.must_equal false
	end
end

describe ObjectSchemas::Schemas::SchemaDefinition, "defining an object without a block" do
	it "should default the strict mode to false" do
		schema = TestSchema.new
		schema.strict_mode.must_equal false
		schema.strict_mode?.must_equal false
	end

	it "should allow the strict mode to be set" do
		schema = TestSchema.new
		schema.strict!
		schema.strict_mode.must_equal true
		schema.strict_mode?.must_equal true
	end
end

describe ObjectSchemas::Schemas::SchemaDefinition, "defining properties" do
	it "should be able to add a new property to the schema, which is required by default" do
		schema = TestSchema.new
		schema.test "name"
		schema.properties.size.must_equal 1
		schema.properties["name"].name.must_equal "name"
		schema.properties["name"].required.must_equal true
		schema.properties["name"].required?.must_equal true
	end

	it "should allow a property to be explictly set as required" do
		schema = TestSchema.new
		schema.test "name", :required => true
		schema.test "item", "required" => true

		schema.properties.size.must_equal 2

		schema.properties["name"].name.must_equal "name"
		schema.properties["name"].required.must_equal true
		schema.properties["name"].required?.must_equal true
		schema.properties["item"].name.must_equal "item"
		schema.properties["item"].required.must_equal true
		schema.properties["item"].required?.must_equal true
	end

	it "should allow a property to be set as not required" do
		schema = TestSchema.new

		schema.test "name", :required => false
		schema.test "item", "required" => false

		schema.properties.size.must_equal 2
		schema.properties["name"].name.must_equal "name"
		schema.properties["name"].required.must_equal false
		schema.properties["name"].required?.must_equal false
		schema.properties["item"].name.must_equal "item"
		schema.properties["item"].required.must_equal false
		schema.properties["item"].required?.must_equal false
	end

	it "should prevent a property from being defined multiple times in a schema" do
		schema = TestSchema.new
		schema.test "name"

		lambda {
			schema.test "name"
		}.must_raise(ObjectSchemas::PropertyAlreadyDefined)
	end

	it "should ensure the list of properties cannot be modified" do
		schema = TestSchema.new
		schema.test "name"
		schema.properties.size.must_equal 1

		schema.properties["malicious"] = "muwah ha ha"
		schema.properties.size.must_equal 1

		lambda{
			schema.properties = {:malicious => "mwuah ha ha"}
		}.must_raise(NameError)
	end

	it "should ensure the list of required properties cannot be modified" do
		schema = TestSchema.new
		schema.test "name"
		lambda{
			schema.required_properties = {:malicious => "mwuah ha ha"}
		}.must_raise(NameError)
	end
end