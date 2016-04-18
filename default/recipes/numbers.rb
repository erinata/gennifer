class NumbersRecipe
  def recipe
    create @full_path, 'numbers.txt'
    erb @full_path
  end
end
