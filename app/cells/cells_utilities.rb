module CellsUtilities
  extend ActiveSupport::Concern

  included do
    helper_method :flash, :ancestor_controller, :namespace, :controller_name
  end

  def namespace
    @namespace ||= extract_namespace
  end

  def extract_namespace
    ancestor_controller.class.to_s.split('::').first.underscore
  end

  def ancestor_controller
    @ancestor_controller ||= extract_ancestor_controller
  end

  def controller_name
    ancestor_controller.class.to_s.split('::').last.underscore.chomp("_controller")
  end

  def extract_ancestor_controller
    parent = parent_controller
    while  parent.class.to_s.end_with?("Cell")
      parent = parent.parent_controller
    end
    parent
  end

  def flash
    ancestor_controller.flash
  end
end

