# Auto-generate a dedicated, indexable page for every tag used across the
# site, so the tag cloud in tags.md never links to a 404.
#
# Pages are emitted at /tags/<slug>/ using the `tag` layout. New tags get a
# page automatically on the next build — no need to hand-create tags/<slug>.md.
module TagPages
  class Generator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      dir = site.config["tag_dir"] || "tags"

      site.tags.each_key do |tag|
        slug = Jekyll::Utils.slugify(tag)
        site.pages << TagPage.new(site, site.source, File.join(dir, slug), tag)
      end
    end
  end

  class TagPage < Jekyll::Page
    def initialize(site, base, dir, tag)
      @site = site
      @base = base
      @dir  = dir
      @name = "index.html"

      process(@name)

      @data = {
        "layout"    => "tag",
        "tag"       => tag,
        "title"     => "Tag: #{tag}",
        "permalink" => "/#{dir}/",
      }
    end
  end
end
