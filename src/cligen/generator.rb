module Cligen
    # This class is responsible for generating HTML pages using ERB templates.
    class Generator
        # Generates a page.
        # Receives path to a template file (full) and an array (or Hash) with template data.
        # Returns a string - compiled template.
        def generate_page(template_file, data)
            @data = data
            ERB.new(File.read(template_file)).result(binding)
        end
    end
end
