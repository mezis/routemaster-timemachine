class Event < ActiveRecord::Base
  # disable STI
  self.inheritance_column = :_type_disabled

  scope :between_t, lambda { |start_epoch_time, end_epoch_time| where(t: start_epoch_time..end_epoch_time) }
end
