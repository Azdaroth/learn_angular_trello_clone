class PaginatingDecorator < Draper::CollectionDecorator
  delegate :current_page, :per_page, :offset, :total_entries, :next_page,
    :total_pages, :in_groups_of, :where, :includes
end
