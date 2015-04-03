require 'active_support'
require 'active_support/core_ext'
require 'json'
require 'colorize'
require 'highline/import'
require_relative 'lib/serializer'
require_relative 'lib/animal'
require_relative 'lib/herbivorous'
require_relative 'lib/predator'
require_relative 'lib/wolf'
require_relative 'lib/cat'
require_relative 'lib/cow'
require_relative 'lib/horse'

@animal_list = []

def print_animal_list
  puts "Animal list: #{@animal_list.join(', ')}\n".green
end

loop do
  choose do |action|
    action.prompt = 'Please choose an action'.red

    action.choice('Add an Animal') do
      choose do |animal|
        animal.prompt = 'Choose an animal'.yellow

        [Cat, Wolf, Horse, Cow].each do |animal_class|
          animal.choice(animal_class.to_s) do
            @animal_list << animal_class.new

            @animal_list.last.name = ask('Enter name') do |q|
              q.validate = /[A-z]*/
            end
          end
        end
        print_animal_list
      end
    end

    action.choice('Save animal list to file') do
      File.open('list.json', 'w') { |file| file.write(Serializer.serialize_array(@animal_list)) }
    end

    action.choice('Load animal list from file') do

    end

    action.choices('Exit') { exit }
  end
end
