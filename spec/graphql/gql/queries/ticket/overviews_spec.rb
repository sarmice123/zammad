# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

require 'rails_helper'

RSpec.describe Gql::Queries::Ticket::Overviews, type: :graphql do

  context 'when fetching ticket overviews' do
    let(:agent)     { create(:agent) }
    let(:query)     { gql.read_files('shared/entities/ticket/graphql/queries/ticket/overviews.graphql') }
    let(:variables) { { withTicketCount: false } }

    before do
      gql.execute(query, variables: variables)
    end

    context 'with an agent', authenticated_as: :agent do
      it 'has agent overview' do
        expect(gql.result.nodes.first).to include('name' => 'My Assigned Tickets', 'link' => 'my_assigned', 'prio' => 1000, 'active' => true,)
      end

      it 'has view and order columns' do
        expect(gql.result.nodes.first).to include(
          'viewColumns'  => include({ 'key' => 'title', 'value' => 'Title' }),
          'orderColumns' => include({ 'key' => 'created_at', 'value' => 'Created at' }),
        )
      end

      context 'without ticket count' do
        it 'does not include ticketCount field' do
          expect(gql.result.nodes.first).not_to have_key('ticketCount')
        end
      end

      context 'with ticket count' do
        let(:variables) { { withTicketCount: true } }

        it 'includes ticketCount field' do
          expect(gql.result.nodes.first['ticketCount']).to eq(0)
        end
      end
    end

    context 'with a customer', authenticated_as: :customer do
      let(:customer) { create(:customer) }

      it 'has customer overview' do
        expect(gql.result.nodes.first).to include('name' => 'My Tickets', 'link' => 'my_tickets', 'prio' => 1100, 'active' => true,)
      end
    end

    it_behaves_like 'graphql responds with error if unauthenticated'
  end
end
