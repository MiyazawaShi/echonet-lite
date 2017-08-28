# -*- encoding: utf-8 -*-
# stub: echonet_lite 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "echonet_lite".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.metadata = { "allowed_push_host" => "TODO: Set to 'http://mygemserver.com'" } if s.respond_to? :metadata=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shigeaki Miyazawa".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-08-28"
  s.description = "ECHONET Lite Libraly for Ruby".freeze
  s.email = ["miyazawa.shige@gmail.com".freeze]
  s.homepage = "https://github.com/MiyazawaShi/echonet-lite".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "ECHONET Lite Libraly for Ruby".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<ipaddress>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<ipaddress>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.15"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<ipaddress>.freeze, [">= 0"])
  end
end
