class BeforeRecipe
  def recipe
    puts('Generating ' + @full_name) if Settings::VERBOSE
  end
end
