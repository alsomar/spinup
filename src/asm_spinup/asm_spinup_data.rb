module ASM_Extensions
    module SpinUp
      # METHODS
      def self.user_input(prompts, defaults, list)
        UI.inputbox(prompts, defaults, list, "SpinUp")
      rescue ArgumentError
        UI.messagebox("Invalid input")
        nil
      end
  
      def self.get_axis(axis)
        case axis.upcase
        when "X"
          Geom::Vector3d.new(1, 0, 0)
        when "Y"
          Geom::Vector3d.new(0, 1, 0)
        when "Z"
          Geom::Vector3d.new(0, 0, 1)
        else
          UI.messagebox("Invalid rotation axis")
          nil
        end
      end
  
      def self.get_entities(selection)
        entities = selection.select { |e| e.is_a?(Sketchup::Group) || e.is_a?(Sketchup::ComponentInstance) }
        if selection.size != entities.size
          UI.messagebox("Some selected objects are not groups or components and will not be rotated")
        end
        entities
      end
  
      def self.rotate_entities(model, entities, rotation_axis, degrees)
        return if entities.empty?
  
        model.start_operation("SpinUp", true)
        entities.each do |entity|
          rotation = Geom::Transformation.rotation(entity.bounds.center, rotation_axis, degrees.degrees)
          entity.transform!(rotation)
        end
        model.commit_operation
      end
  
      # PROCESS
      def self.apply_spinup
        model = Sketchup.active_model
        entities = model.entities
  
        prompts = ["Rotation Angle (degrees): ", "Rotation Axis (X/Y/Z): "]
        defaults = [45, "Z"]
        list = ["", "X|Y|Z"]
  
        selection = model.selection.to_a
        if selection.empty?
          UI.messagebox("SpinUp: Please select at least one group or component.")
          return
        end
  
        input = user_input(prompts, defaults, list)
        return unless input && input.all?
  
        degrees = input[0].to_f
        axis = input[1]
  
        rotation_axis = get_axis(axis)
        return unless rotation_axis
  
        entities = get_entities(selection)
  
        rotate_entities(model, entities, rotation_axis, degrees)
      end
    end # Module SpinUp
  end  # Module ASM_Extensions