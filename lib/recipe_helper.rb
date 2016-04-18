def recipe_setup(jr)
  jr.class_eval do
    def initialize(full_path, argv)
        @argv = argv
        @current_dir = Dir.pwd
        @resources = File.expand_path('~/.jennifer/resources')
        @full_name = File.basename(full_path)
        @base_name = File.basename(full_path,'.*')
        @ext_name = File.extname(full_path)
        @recipe = self.class
        @target_dir = File.expand_path('./'+ full_path + '/..')
        #@project_dir = File.expand_path('./'+ full_path )
        @full_path = full_path
    end

    def generate
      if File.exists?(@full_path)
        puts(@full_path + ' already exists.')
      else
        invoke(BeforeRecipe)
        recipe
        invoke(AfterRecipe)
      end
    end

    def create(target, resource=nil)
      if resource.nil?
        FileUtils.mkdir_p(File.expand_path(target))
      else
        FileUtils.cp_r(File.expand_path("#{@resources}/#{resource}"),File.expand_path(target))
      end
      puts "Create #{File.expand_path(target)}" if Settings::VERBOSE
    end

    # def file(target, resource=nil)
    #   if resource.nil?
    #     FileUtils.touch(File.expand_path(target))
    #   else
    #     FileUtils.cp_r(File.expand_path("#{@resources}/#{resource}"),File.expand_path(target))
    #   end
    #   puts "Create #{File.expand_path(target)}" if Settings::VERBOSE
    # end
    #
    # def directory(target, resource=nil)
    #   if resource.nil?
    #     FileUtils.mkdir_p(File.expand_path(target))
    #   else
    #     FileUtils.cp_r(File.expand_path("#{@resources}/#{resource}"),File.expand_path(target))
    #   end
    #   puts "Create #{File.expand_path(target)}" if Settings::VERBOSE
    # end

    def invoke(invoke_class)
      recipe_setup(invoke_class)
      new_recipe = invoke_class.new(@full_path, @argv)
      new_recipe.recipe
    end

    def check_argv(check)
      if @argv.include?(check) then
        return true
      else
        return false
      end
    end

    def executable(file)
      FileUtils.chmod 0755, file
    end

    def erb(full_path)
      erb = File.read(full_path)
      File.open(full_path, 'w') { |file| file.write(ERB.new(erb,0,'-').result(binding)) }
    end
  end
end
