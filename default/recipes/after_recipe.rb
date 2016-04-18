class AfterRecipe
  def recipe
    executable @full_path if check_argv('exe')
    `#{Settings::EDITOR} #{@full_path}` if check_argv('edit')

    if check_argv('bin') then
      new_location= File.expand_path(Settings::BINFOLDER + '/' + @full_name)
      if File.exists?(new_location)
        FileUtils.rm_rf(@full_path)
      else
        FileUtils.mv(@full_path , new_location)
      end
      executable new_location
      `#{Settings::EDITOR} #{new_location}`
    end

    puts(@full_name + ' generation finished') if Settings::VERBOSE
    
  end
end
