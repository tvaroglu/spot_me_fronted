class EventFacade
  def self.get_events(user_id)
    events = EventService.get_events(user_id)
    return [] unless events[:data]

    events[:data].map { |event| Event.new(event) }
  end

  def self.create_event(params)
    EventService.create_event(params)
  end

  def self.delete_event(params)
    EventService.delete_event(params)
  end
end
