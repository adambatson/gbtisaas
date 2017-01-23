module ApplicationHelper
	helper_method :draw_nav

	def draw_nav(text, path, target_controller, target_action)
		is_active = target_controller == ProviderController and controller.action_name == target_action;
		content_tag(:li,
			content_tag(:a, 
				text + ( (is_active) ? content_tag(:span, "(current)", :class=>"sr-only") : "" ), 
			:href=>path)
		:class=>(is_active) ? 'active' : nil);
	end
end