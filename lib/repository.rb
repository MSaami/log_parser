# frozen_string_literal: true

# class which holds all of the visits
class Repository
  def initialize
    @visits = {}
  end

  def increment_visit(path:, ip:)
    visits[path] ||= []
    visits[path] << ip
  end

  def count_visits
    sort_and_reverse(visits.map { |path, visit| [path, visit.size] })
  end

  def unique_count_visits
    sort_and_reverse(visits.map { |path, visit| [path, visit.uniq.size] })
  end

  private

  attr_reader :visits

  def group_by_path
    visits.group_by { |visit| visit[:path] }
  end

  def sort_and_reverse(grouped_data)
    grouped_data.sort_by { |_path, count| -count }
  end
end
