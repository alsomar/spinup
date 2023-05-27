require 'extensions' unless defined?(SketchupExtension)

module ASM_Extensions
  module SpinUp

    # Variables
    PLUGIN_NAME = 'SpinUp'.freeze
    PLUGIN_VERSION = '1.0.3'.freeze
    PLUGIN_DESCRIPTION = 'Rotate multiple components or groups in place.'.freeze
    PLUGIN_AUTHOR = 'Alejandro Soriano'.freeze
    PLUGIN_ID = File.basename(__FILE__, '.rb')

    # Paths
    PATH_ROOT = File.dirname(__FILE__)
    PATH_ICON = File.join(PATH_ROOT, PLUGIN_ID, "icons")
    FILE_DATA = File.join(PATH_ROOT, PLUGIN_ID, PLUGIN_ID+"_data.rb")
    FILE_MAIN = File.join(PATH_ROOT, PLUGIN_ID, PLUGIN_ID+"_main.rb")

    # Extension Initialization
    EXT_DATA = SketchupExtension.new(PLUGIN_NAME, FILE_MAIN)

    # Info
    EXT_DATA.creator = PLUGIN_AUTHOR
    EXT_DATA.version = PLUGIN_VERSION
    EXT_DATA.copyright = "2022-#{Time.now.year}, #{PLUGIN_AUTHOR}"
    EXT_DATA.description = PLUGIN_DESCRIPTION

    # Register and load the extension on first install
    Sketchup.register_extension(EXT_DATA, true)

  end # module SpinUp
end # module ASM_Extensions
