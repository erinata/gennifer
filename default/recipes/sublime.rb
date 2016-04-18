
class SublimeRecipe
  def recipe
    create (@target_dir + '/' + @full_name + '.sublime-project'), 'sublime-project'
  end
end
