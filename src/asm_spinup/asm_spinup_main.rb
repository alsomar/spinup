# Please see the loader file for information on the license and author info.
module ASM_Extensions
  module SpinUp
    require FILE_DATA

    ICON_EXT = Sketchup.platform == :platform_win ? 'svg' : 'pdf'

    def self.icon(basename)
      File.join(PATH_ICON, "#{basename}.#{ICON_EXT}")
    end

    # Add Toolbar
    toolbar = UI::Toolbar.new "SpinUp"

    # Button for SpinUp
    cmd_axes = UI::Command.new("SpinUp") {
      ASM_Extensions::SpinUp.apply_spinup
    }
    cmd_axes.tooltip = "SpinUp"
    cmd_axes.status_bar_text = "Rotate multiple components or groups in place"
    cmd_axes.small_icon = self.icon("asm_spinup_16")
    cmd_axes.large_icon = self.icon("asm_spinup_24")
    toolbar = toolbar.add_item cmd_axes

    toolbar.show
  end # module SpinUp

  unless defined?(@spinup_loaded)
    UI.menu("Extensions").add_item("SpinUp") { ASM_Extensions::SpinUp.apply_spinup }
    @spinup_loaded = true
  end

end # module ASM_Extensions