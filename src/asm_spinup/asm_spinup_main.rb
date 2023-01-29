#Please see the loader file for information on the license and author info.
module ASM_Extensions
  module SpinUp

    model = Sketchup.active_model
    entities = model.entities

    prompts = ["Rotation Angle (degrees): ", "Rotation Axis (X/Y/Z): "]
    defaults = [45, "Z"]
    list = ["", "X|Y|Z"]

    begin
      input = UI.inputbox(prompts, defaults, list, "Enter Rotation Angle and Axis")
      degrees = Integer(input[0])
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

      model.start_operation("SpinUp", true)
      model.selection.each do |selected|
        rotation = Geom::Transformation.rotation(selected.bounds.center, rotation_axis, degrees.degrees)
        selected.transform!(rotation)
      end
      model.commit_operation

    rescue ArgumentError
      UI.messagebox("Invalid angle")
      retry
    end

  end # module SpinUp

  file_loaded(__FILE__)
end # module ASM_Extensions