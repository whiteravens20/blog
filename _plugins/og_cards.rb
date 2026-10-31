# Give every post its own link preview, so a post shared on Mastodon or anywhere else
# shows its title instead of the banner all the pages share. A card is a small HTML page
# that the browser on the build machine turns into a PNG. With no browser, or when one
# card fails, the post keeps the default image, because a preview must never stop a post
# from going out. Production builds only: it takes a second or two per post.
require "base64"
require "cgi"
require "fileutils"
require "tmpdir"

module OgCards
  BROWSERS = %w[google-chrome chromium chromium-browser].freeze
  DIR = "assets/og"

  def self.browser
    BROWSERS.find { |name| system("command -v #{name} > /dev/null 2>&1") }
  end

  def self.embed(source, path, type)
    "data:#{type};base64,#{Base64.strict_encode64(File.binread(File.join(source, path)))}"
  end

  # "RomM: One Browsable Library" has the project's name before the colon: it goes large,
  # the rest below it. A title without a colon stands alone.
  def self.html(source, title)
    name, rest = title.split(/:\s+/, 2)
    inter = ->(weight, file) { "@font-face{font-family:Inter;font-weight:#{weight};src:url(#{embed(source, "assets/fonts/#{file}", "font/woff2")})}" }
    <<~HTML
      <!doctype html><meta charset="utf-8">
      <style>
      #{inter.call(500, "Inter-Medium.woff2")}
      #{inter.call(600, "Inter-SemiBold.woff2")}
      #{inter.call(700, "Inter-Bold.woff2")}
      @font-face{font-family:Mono;src:url(#{embed(source, "assets/fonts/JetBrainsMono-Regular.woff2", "font/woff2")})}
      *{margin:0;box-sizing:border-box}
      html,body{width:1200px;height:630px;overflow:hidden;background:#0b0c10}
      body{position:relative;display:flex;flex-direction:column;padding:56px 84px 52px 92px;font-family:Inter}
      .bar{position:absolute;inset:0 auto 0 0;width:10px;background:linear-gradient(#66fcf1,#45a29e)}
      header{display:flex;align-items:center;gap:20px;font-size:32px;font-weight:600;color:#c5c6c7}
      header img{width:76px;height:76px}
      main{flex:1;display:flex;flex-direction:column;justify-content:center;padding-bottom:12px}
      h1{font-size:#{name.length > 24 ? 68 : 92}px;line-height:1.08;font-weight:700;color:#66fcf1;letter-spacing:-.015em;text-wrap:balance}
      p{margin-top:22px;font-size:#{rest.to_s.length > 62 ? 44 : 52}px;line-height:1.2;font-weight:500;color:#e8eaed;letter-spacing:-.01em;text-wrap:balance}
      footer{font-family:Mono;font-size:28px;color:#8892a0}
      </style>
      <div class="bar"></div>
      <header><img src="#{embed(source, "assets/images/logo-256.png", "image/png")}" alt="">White Ravens Blog</header>
      <main><h1>#{CGI.escapeHTML(name)}</h1>#{rest ? "<p>#{CGI.escapeHTML(rest)}</p>" : ""}</main>
      <footer>blog.whiteravens.net</footer>
    HTML
  end

  def self.render(browser, html, png)
    Dir.mktmpdir do |dir|
      page = File.join(dir, "card.html")
      File.write(page, html)
      system(browser, "--headless", "--no-sandbox", "--disable-gpu", "--hide-scrollbars", "--force-device-scale-factor=1",
             "--window-size=1200,630", "--virtual-time-budget=3000", "--user-data-dir=#{dir}/profile",
             "--screenshot=#{png}", "file://#{page}", out: File::NULL, err: File::NULL) && File.exist?(png)
    end
  end

  class Generator < Jekyll::Generator
    safe true
    priority :low

    def generate(site)
      return unless Jekyll.env == "production"

      browser = OgCards.browser
      return Jekyll.logger.warn("OgCards:", "no browser here, posts keep the default image") unless browser

      out = site.in_source_dir(".jekyll-cache", "og-cards")
      FileUtils.mkdir_p(File.join(out, DIR))
      made = site.posts.docs.count do |post|
        name = "#{post.data["slug"]}.png"
        next false unless OgCards.render(browser, OgCards.html(site.source, post.data["title"]), File.join(out, DIR, name))

        site.static_files << Jekyll::StaticFile.new(site, out, DIR, name)
        post.data["image"] = "/#{DIR}/#{name}"
      end
      Jekyll.logger.info("OgCards:", "#{made} of #{site.posts.docs.size} posts have their own card")
    end
  end
end
