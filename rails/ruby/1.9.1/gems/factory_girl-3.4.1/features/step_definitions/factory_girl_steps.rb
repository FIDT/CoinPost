module FactoryGirlDefinitionsHelper
  def append_file_to_factory_girl_definitions_path(path_to_file)
    FactoryGirl.definition_file_paths ||= []
    FactoryGirl.definition_file_paths << path_to_file
  end
end

World(FactoryGirlDefinitionsHelper)

When /^"([^"]*)" is added to Factory Girl's file definitions path$/ do |file_name|
  new_factory_file = File.join(current_dir, file_name.gsub(".rb", ""))

  append_file_to_factory_girl_definitions_path(new_factory_file)

  step %{I find definitions}
end

When /^"([^"]*)" is added to Factory Girl's file definitions path as an absolute path$/ do |file_name|
  new_factory_file = File.expand_path(File.join(current_dir, file_name.gsub(".rb", "")))

  append_file_to_factory_girl_definitions_path(new_factory_file)

  step %{I find definitions}
end

When /^I create a "([^"]*)" instance from Factory Girl$/ do |factory_name|
  FactoryGirl.create(factory_name)
end

Given /^these super users exist:$/ do |table|
  headers = table.headers + ["admin"]
  rows    = table.rows.map { |row| row + [true] }
  new_table = Cucumber::Ast::Table.new([headers] + rows)
  step %{the following person exists:}, new_table
end

When /^I find definitions$/ do
  FactoryGirl.find_definitions
end

When /^I reload factories$/ do
  FactoryGirl.reload
end
