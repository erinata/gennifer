
class TestRecipe
  def recipe
    puts "Testing"
    puts 'Name: ' + Settings::NAME
    puts 'Email: ' + Settings::EMAIL

    puts @argv
    #
    invoke(Test2Recipe)

  end
end
