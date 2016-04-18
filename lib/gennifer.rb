require "gennifer/version"
require 'fileutils'
require 'erb'

# TODO: command to generate new recipes with commented hint/tutorial
# TODO: write tests and test in windows
# TODO: better treatment for duplicate files in bin folder
# TODO: put help text in recipe and make the help command auto read it

module Gennifer
  def self.gen(argv)

    argv0 = argv[0] || ''
    argv1 = argv[1] || ''

    if (argv0 == 'install' && (Dir.exists?(File.expand_path('~/.gennifer'))==true)) then
      puts "
      It seems that you have already installed Gennifer before since ~/.gennifer exists.

      If you insist, please backup your custom recipes, resources, and settings (all the contents in ~/.gennifer). Then remove the folder ~/.gennifer and re-run 'gen install'.

      "
      return
    elsif (argv0 == 'forcedinstall') then
      FileUtils.rm_rf(File.expand_path('~/.gennifer'))
      install_gennifer
      return
    end

    if (Dir.exists?(File.expand_path('~/.gennifer'))==false) then
      install_gennifer
    end

    require File.expand_path('~/.gennifer/settings.rb', __FILE__)
    Dir[File.expand_path('~/.gennifer/recipes/**/*.rb')].each {|file| require file }


    if (argv0 == 'help' or argv0 == '') then
      help_text(argv1)
    else
      recipe_class = get_recipe_class(argv1)
      if recipe_class then
        use_recipe(recipe_class,argv0,argv)
      else
        recipe_class = get_recipe_class_from_path(argv0)
        if recipe_class then
          use_recipe(recipe_class,argv0,argv)
        elsif Settings::USEDEFAULT == true then
          use_recipe(DefaultRecipe,argv0,argv)
        else
          puts "Recipe not found"
        end
      end
    end
  end

  def self.get_recipe_class_from_path(full_name)
    original_name = File.basename(full_name)
    ext_name_list = File.basename(full_name).split('.')
    base_name = ext_name_list.delete_at(0)
    combined_ext_name = ext_name_list.join('_')
    trial_list = [original_name] + [combined_ext_name] + ext_name_list + [base_name]

    trial_list.each do |trial|
      recipe_class = get_recipe_class(trial)
      if recipe_class then
        return recipe_class
      end
    end

    return nil
  end

  def self.use_recipe(recipe_class, full_name, argv)

    if recipe_class then
      require File.expand_path('../recipe_helper.rb', __FILE__)
      recipe_setup(recipe_class)
      jr = recipe_class.new(File.expand_path('./'+ full_name ), argv)
      jr.generate
    end
    return recipe_class
  end

  def self.help_text(argv1)

    if argv1 == 'install' then
      puts "
      gen install                   install the default settings and recipe
      "
    elsif argv1 == 'article' then
      puts "
      gen myproject article         generate a latex article project
      "
    elsif argv1 == 'exam' then
      puts "
      gen myproject exam            generate a latex exam project
      "
    elsif argv1 == 'exe' then
      puts "
      gen myfile.rb exe             generate a ruby file and make it executable
      "
    elsif argv1 == 'bin' then
      puts "
      gen myfile.rb bin             generate a ruby file and make it executable,
                                    move the file to the bin folder and use the
                                    editor to open the file.
      "
    else
      puts "
      gen install                   install the default settings and recipe
      gen myproject article         generate a latex article project
      gen myproject exam            generate a latex exam project
      gen myproject letter          generate a latex letter project
      gen myfile.rb                 generate a ruby file with name myfile.rb
      gen myfile rb                 generate a ruby file with name myfile
      gen myfile.rb exe             generate a ruby file and make it executable
      gen myfile.rb bin             generate a ruby file and make it executable,
                                    move the file to the bin folder and use the
                                    editor to open the file.
      "
    end
  end

  def self.install_gennifer
    FileUtils.mkdir_p(File.expand_path('~/.gennifer'))
    FileUtils.cp_r(Dir[File.expand_path('../../default/*', __FILE__)], File.expand_path('~/.gennifer'))
    puts "Gennifer default settings installed"
  end

  def self.get_recipe_class(recipe_text)
    begin
      recipe_class = Object.const_get(recipe_text.capitalize.gsub(/_(.)/) {|e| $1.upcase} + "Recipe")
    rescue
      # puts "Recipe not found"
    end
    recipe_class
  end
end
