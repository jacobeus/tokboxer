Gem::Specification.new do |s|
  s.name = %q{tokboxer}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Nicolas Jacobeus"]
  s.date = %q{2008-11-26}
  s.description = %q{This is a ruby implementation of the TokBox API. Tokbox is a free video calling / video mailing platform (see http://www.tokbox.com).  All API methods specified in the Tokbox Developer API wiki (http://developers.tokbox.com/index.php/API) are implemented but not all objects yet. So you may have to dig into the hash returned by the call (XML converted to a Ruby hash).  For the moment, this gem currently specifically serves our needs for the implementation of video conversations and video mails on iStockCV (www.istockcv.com), an online recruitment network which we are developing. Your needs may vary so feel free to contact me (nj@belighted.com).}
  s.email = ["nj@belighted.com"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "website/index.txt"]
  s.files = ["History.txt", "Manifest.txt", "PostInstall.txt", "README.rdoc", "Rakefile", "config/website.yml.sample", "lib/TokBoxer.rb", "lib/TokBoxer/Api.rb", "lib/TokBoxer/Call.rb", "lib/TokBoxer/User.rb", "lib/TokBoxer/VMail.rb", "script/console", "script/destroy", "script/generate", "script/txt2html", "spec/TokBoxer_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/rspec.rake", "website/index.html", "website/index.txt", "website/javascripts/rounded_corners_lite.inc.js", "website/stylesheets/screen.css", "website/template.html.erb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/njacobeus/tokboxer/}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tokboxer}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{This is a ruby implementation of the TokBox API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<xml-simple>, [">= 1.0.11"])
      s.add_development_dependency(%q<newgem>, [">= 1.0.5"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<xml-simple>, [">= 1.0.11"])
      s.add_dependency(%q<newgem>, [">= 1.0.5"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<xml-simple>, [">= 1.0.11"])
    s.add_dependency(%q<newgem>, [">= 1.0.5"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
