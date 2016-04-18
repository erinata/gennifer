# Gennifer

This is a gem for generating files or projects using recipes and templates. Everything is done by a simple command 'gen'

## Installation

To install the gem:

    $ gem install gennifer

To put default settings in the folder ~/.gennifer

    $ gen install

## Basic Usage

The gem is customizable but it also comes with a bunch of default functionality
out of the box.

To generate a latex article project (with the tex file, the bib file, the figure folder, and .gitignore file):

    $ gen project_name article

To generate a latex beamer project instead:

    $ gen project_name beamer

Or just a simple tex file:

    $ gen file_name.tex tex

To generate a sublime-project file in the current folder to make the current folder a sublime text project:

    $ jem project_name sublime

To generate a ruby file with the name testing.rb :

    $ gen testing.rb ruby

To generate a python file with the name testing.py :

    $ gen testing.py python

In fact gennifer would recognize the extension name so that

    $ gen testing.rb
    $ gen testing.py

also work as expected.

To see the help text:

    $ gen help

## Advanced Usage

### Settings

If you have tried `gen project_name article`, you probably notice that the file
contain names and information of the author. The default name is Gennifer Lynn
Connelly and there are default values for other information too. You can change
the values in the file ~/.gennifer/settings.rb. The system settings are those
settings which will alter the behaviour of the program. And the users Settings
are variables which is available in the recipes. 

### Make your own recipes

All the recipes are stored in the folder ~/.gennifer/recipes. Each files
contains a recipe which can be used with the command `gen`. Each recipe should
be in the following format.


    class ArticleRecipe
      def recipe
        create @full_path
        create (@full_path + "/#{@full_name}.tex"), 'latex_article.tex'
        erb (@full_path + "/#{@full_name}.tex")
        create (@full_path + "/reference.bib"), 'reference.bib'
        create (@full_path + "/.gitignore"), 'gitignore_latex'
        create (@full_path + '/figures')
        create (@full_path + "/figures/sample-figure.pdf"), 'sample-figure.pdf'
      end
    end

Apart from coding the whole recipe using ruby (like using mkdir, cp, mv in
FileUtils), there are several method you can use in the recipe. For example,
`create` will create a new directory in the target location if only the location
is specified. And it will copy a file/directory
from the resources folder if a resources location is specified in the second
argument.

A bunch of variables are available in the recipe. For example, if you run
`gen myarticle article` from the location ~/Document/projects/, then

    @current_dir   # ~/Document/projects/
    @resources     # ~/.gennifer/resources/
    @full_name     # myarticle
    @base_name     # myarticle
    @ext_name      #
    @recipe        # ArticleRecipe
    @target_dir    # ~/Document/projects/
    @full_path     # ~/Document/projects/myarticle/

If you run `gen ../myfile.rb` from the location ~/Document/projects/, then

    @current_dir   # ~/Document/projects/
    @resources     # ~/.gennifer/resources/
    @full_name     # myfile.rb
    @base_name     # myfile
    @ext_name      # .rb
    @recipe        # RbRecipe
    @target_dir    # ~/Document/
    @full_path     # ~/Document/myfile.rb


The class name should be in capitalized camelcase and ended with the word
Recipe. For example, the command `gen project_name article` will invoke the
recipe `ArticleRecipe`.

The file name and file structure inside the folder ~/.gennifer/recipes are not
important. You can use the folder structure to organize the recipes.

### Recipe by file names

When the recipe is not specifed, gennifer will use the file name to try to
identify the recipe. For example,

    $ gen cat.rb

Gennifer will try the recipes in the following order: CatRbRecipe, RbRecipe, CatRecipe. Among the default recipes, the RbRecipe would be used. A more
complicated example would be

    $ gen application.html.erb

Gennifer will try the recipes in the following order: ApplicationHtmlErbRecipe,
HtmlErbRecipe, ErbRecipe, HtmlRecipe, ApplicationRecipe.

If everything tried and still there is no recipe found, Gennifer will use the
DefaultRecipe. This recipe is specified in the file ~/.gennifer/recipes/default.rb


### Special recipes

Among all the recipes, there are three of them which are special. The
AfterRecipe, BeforeRecipe, and DefaultRecipe. As mentioned before, the
DefaultRecipe is the recipe which is called when no suitable recipe is found
for a certain file/project name. The BeforeRecipe is the recipe which is run
before any recipes and the AfterRecipe is run after any recipes.


### Other arguments

You can supply extra arugments to the `gen` command to customize the behaviour
of each recipe. All extra arguments are available in the recipe. For example,

    $ gen testing.rb exe

will generate a testing.rb file and make the file executable. This is specified
in the first line of the AfterRecipe (`executable @full_path if check_argv('exe')`). The part `check_argv('exe')` check whether `exe` is
included in the arguments and it can be used to check for other extra arguments.


### ERB support

You can use the method erb in recipe (see ArticleRecipe). This will use erb to
process the file before it is generated. Gennifer uses erb to fill in
information like name and address using the information specified in the
settings.rb.

### Combining multiple recipes

You can invoke another recipe by using `invoke(TargetRecipe)` in the recipe
file. Notice that the program wont stop if you recursively invoke the same
recipe from itself.

## License

This gem is not released for public use yet.
