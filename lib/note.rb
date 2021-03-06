require "rdiscount"


module Sinatryll
  class Note
    attr_accessor :file, :path, :html, :name, :category, :id, :url

    @@id = 0

    def initialize(site, category, filename, parent='')
      @category = category
      @filename = filename
      @path = create_path(parent)
      @file = File.open(@path)
      @name = File.basename(@path, ".*" )
      @id = "#{@@id += 1}-#{@name}"
      @url = "/notes/#{@category}/#{@id}"
      @markdown = File.read(@path)
      @html = RDiscount.new(@markdown, :smart, :filter_html).to_html
      site.notes << self
    end

    def create_path parent
      if parent.empty?
        "#{Sinatryll::App.notes_directory}/#{category}/#{@filename}"
      else
        "#{Sinatryll::App.notes_directory}/#{parent}/#{category}/#{@filename}"
      end
    end

  end
end