module Users::RegistrationsHelper

  def fetch_themes
    themes = Dir.glob('vendor/assets/stylesheets/pygments/*')
    themes.map! { |stylesheet| stylesheet.split('/')[4].gsub('.css', '') }
    themes.map! {|theme| theme.capitalize }
  end

end
