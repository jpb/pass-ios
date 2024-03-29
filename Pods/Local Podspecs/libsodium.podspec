Pod::Spec.new do |s|
  s.name         = "libsodium"
  s.version      = "0.3.1"
  s.summary      = "Sodium is a portable, cross-compilable, installable, packageable, API-compatible version of NaCl."
  s.homepage     = "https://github.com/jedisct1/libsodium"
  s.license      = { :type => "BSD",
										 :text => <<-LICENSE
Copyright © 2013
Frank Denis <j at pureftpd dot org>

Permission to use, copy, modify, and distribute this software for any purpose with or without fee is hereby granted, provided that the above copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

										 LICENSE
	}



  s.author   = { "Frank Dennis" => "j@pureftpd.org" }
  s.source   = { :git => 'https://github.com/kballenegger/libsodium.git', :tag => '0.3.1' }
  s.ios.deployment_target = '4.0'
  s.osx.deployment_target = '10.6'

  s.header_mappings_dir = 'src/libsodium/include'

  files = FileList['src/libsodium/**/*.{c,h,data}']
  files.exclude('**/*try.*')
  files.exclude('**/*version.*')
  files.exclude('src/libsodium/crypto_scalarmult/curve25519/donna_c64/')

  
  s.source_files = files 



 end
