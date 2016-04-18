
class ExampleRecipe   # This is the name of the recipe, it's in Capitalized CamelCase ended with 'Recipe'. This recipe can be invoked by 'jen FILENAME example'.
  def recipe  # every recipe file must containt the method 'recipe'.
    # put the code which generates the files here. Here is a list of helper methods:


    # To make new directory:
      # create DIRECTORY_NAME
    # To copy directory from resources:
      # create "#{@target_dir}/DIRECTORY_NAME", "RESOURCES_NAME"
    # To copy file from resources:
      # create (@target_dir + "/FILE_NAME"), "RESOURCES_NAME"
    # To invoke another recipe
      # invoke(AnotherRecipe)
    # To evaluate the file using erb
      # erb(FILENAME)
    # To get whether a word is in the argument or new_location
      # check_argv(WORD)
    # To make a file executable
      # executable FILENAME

    # Here are the available variables
      # @current_dir
      # @resources
      # @full_name
      # @base_name
      # @ext_name
      # @recipe
      # @target_dir
      # @full_path

  end
end
