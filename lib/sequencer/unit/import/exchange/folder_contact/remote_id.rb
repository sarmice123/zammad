# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Sequencer::Unit::Import::Exchange::FolderContact::RemoteId < Sequencer::Unit::Import::Common::Model::Attributes::RemoteId
  private

  def attribute
    :item_id
  end
end
