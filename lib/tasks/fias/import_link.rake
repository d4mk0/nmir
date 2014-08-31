namespace :fias do
  desc "Link locations from fias"
  task link_locations: :environment do
    record_count = Location.count
    current_record_count = 0
    slice_count = 300
    summ_count = record_count / slice_count
    index = 0
    Location.find_in_batches(batch_size: slice_count) do |group|
      time = Time.now
      group.each do |record|
        parent_location = Location.where(aoguid: record.parentguid).first
        if parent_location.present?
          record.location_id = parent_location.id
          record.save
        end
        current_record_count += 1
      end
      time_for_slice = Time.now - time
      index += 1
      seconds = (summ_count - index) * time_for_slice.to_i
      days = seconds / 86400
      hours = seconds / 3600
      minutes = (seconds - (hours * 3600)) / 60
      seconds = (seconds - (hours * 3600) - (minutes * 60))
      puts "Link locations:#{current_record_count}/#{record_count}/Time:#{days}:#{hours}:#{minutes}:#{seconds}"
    end
  end

  desc "Calc child count for locations from fias"
  task calc_child_count: :environment do
    record_count = Location.count
    current_record_count = 0
    slice_count = 300
    summ_count = record_count / slice_count
    index = 0
    Location.find_in_batches(batch_size: slice_count) do |group|
      time = Time.now
      group.each do |record|
        record.children_count = Location.where(location_id: record.id).count
        record.save
        current_record_count += 1
      end
      time_for_slice = Time.now - time
      index += 1
      seconds = (summ_count - index) * time_for_slice.to_i
      days = seconds / 86400
      hours = seconds / 3600
      minutes = (seconds - (hours * 3600)) / 60
      seconds = (seconds - (hours * 3600) - (minutes * 60))
      puts "Calc child count:#{current_record_count}/#{record_count}/Time:#{days}:#{hours}:#{minutes}:#{seconds}"
    end
  end

end