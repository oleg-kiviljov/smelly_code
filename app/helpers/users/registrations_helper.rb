module Users::RegistrationsHelper

  def fetch_themes
    themes = Pygments.styles
    unwanted_themes = %w{ bw rrt borland default }
    additional_themes = %w{ github zenburn }
    # Remove unwanted themes and add additional themes
    themes = (themes - unwanted_themes) + additional_themes
    themes.sort! {|a, z| a <=> z }
    themes.map! {|theme| theme.capitalize }
  end

end
