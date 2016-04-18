
class LetterRecipe
  def recipe
    create @full_path
    create (@full_path + "/#{@full_name}.tex"), 'latex_letter.tex'
    erb (@full_path + "/#{@full_name}.tex")
    create (@full_path + "/.gitignore"), 'gitignore_latex'
    create (@full_path + '/figures')
    create (@full_path + "/figures/sample-letterhead.pdf"), 'sample-letterhead.pdf'
    create (@full_path + "/figures/sample-signature.pdf"), 'sample-signature.pdf'
  end
end
