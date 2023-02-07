#Please see the loader file for information on the license and author info.
module ASM_Extensions
  module SpinUp

    def self.apply_spinup
      model = Sketchup.active_model
      entities = model.entities

      prompts = ["Rotation Angle (degrees): ", "Rotation Axis (X/Y/Z): "]
      defaults = [45, "Z"]
      list = ["", "X|Y|Z"]

      begin
        input = UI.inputbox(prompts, defaults, list, "SpinUp!")
        degrees = input[0].to_f
        axis = input[1]

        rotation_axis = case axis.upcase
        when "X"
          X_AXIS
        when "Y"
          Y_AXIS
        when "Z"
          Z_AXIS
        else
          raise ArgumentError, "Invalid rotation axis"
        end

        if model.selection.empty?
          UI.messagebox("Nothing selected")
          return
        end

        selection = model.selection.to_a
        groups_and_components = selection.select { |e| e.is_a?(Sketchup::Group) || e.is_a?(Sketchup::ComponentInstance) }
        if selection.size != groups_and_components.size
          UI.messagebox("Some selected objects are not groups or components and will not be rotated")
        end

        model.start_operation("SpinUp", true)
        groups_and_components.each do |selected|
          rotation = Geom::Transformation.rotation(selected.bounds.center, rotation_axis, degrees.degrees)
          selected.transform!(rotation)
        end
        model.commit_operation

      rescue ArgumentError
        UI.messagebox("Invalid angle")
        retry
      end
    end # apply_spinup

    unless file_loaded?(__FILE__)
      menu = UI.menu("Extensions")
      menu.add_item("SpinUp") { ASM_Extensions::SpinUp.apply_spinup }
      file_loaded(__FILE__)
    end

  end # module SpinUp
end # module ASM_Extensions
