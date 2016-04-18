
class SimpleRecipe
  def recipe
    create @full_path
    create (@full_path + "/#{@full_name}.tex"), 'latex_simple.tex'
    create (@full_path + "/.gitignore"), 'gitignore_latex'
  end
end
