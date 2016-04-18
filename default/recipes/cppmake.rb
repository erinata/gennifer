
class CppMakeRecipe
  def recipe
    create @full_path
    create (@full_path + "/#{@full_name}.cpp"), 'cpp_file.cpp'
    create (@full_path + "/Makefile"), 'Makefile'
    create (@full_path + "/.gitignore"), 'gitignore_basic'
  end
end
