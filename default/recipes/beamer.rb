
class BeamerRecipe
  def recipe
    create @full_path
    create (@full_path + "/#{@full_name}.tex"), 'latex_beamer.tex'
    erb (@full_path + "/#{@full_name}.tex")
    create (@full_path + "/reference.bib"), 'reference.bib'
    create (@full_path + "/.gitignore"), 'gitignore_latex'
    create (@full_path + '/figures')
    create (@full_path + "/figures/sample-figure.pdf"), 'sample-figure.pdf'

  end


  def example
  	'gen MyProjectName beamer'
  end
  
  def explanation
  	'generate a latex beamer project'
  end

end
