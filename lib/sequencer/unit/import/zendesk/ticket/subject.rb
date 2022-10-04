# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Sequencer::Unit::Import::Zendesk::Ticket::Subject < Sequencer::Unit::Common::Provider::Named

  uses :resource

  private

  def subject
    resource.subject || resource.description || '-'
  end
end
