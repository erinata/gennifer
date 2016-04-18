
class ExamRecipe
  def recipe
    create @full_path
    create (@full_path + "/#{@file_name}.tex"), 'latex_exam.tex'
    create (@full_path + "/.gitignore"), 'gitignore_latex'
  end
end
