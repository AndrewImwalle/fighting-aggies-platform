# require 'streamio-ffmpeg'
require 'csv'
class PracticeVideo < ApplicationRecord
  has_one_attached :clip
  before_save :store_metadata
  validates :description,
            presence: true

  validates :video_name,
            presence: true,
            uniqueness: { case_sensitive: false }

  validates :clip,
            presence: true

  validate :unique_video_file

  validate :correct_video_type

  def create_practice_data
    output_hashes = []
    CSV.foreach('db/seeds/route_instances.csv', headers: true) do |row|
      hash = row.to_hash
      original_string = filename
      new_string = if original_string
                     original_string.slice(0, original_string.length - 4)
                   else
                     'invalid_practice_id'
                   end
      hash['practice_id'] = new_string
      hash['timestamp_start'] = int_to_time_string(hash['timestamp_start'].to_i)
      hash['timestamp_end'] = int_to_time_string(hash['timestamp_end'].to_i)
      datetime_format = '%m/%d/%Y'
      hash['date'] = DateTime.strptime(hash['date'], datetime_format)

      output_hashes << hash
    end
    output_hashes.shuffle!
    output_hashes[0..499].each_with_index do |item, _index|
      RouteInstance.create!(item)
    end
  end

  def delete_practice_data(filename)
    new_string = if filename
                   filename.slice(0, filename.length - 4)
                 else
                   'invalid_practice_id'
                 end
    RouteInstance.where(practice_id: new_string).delete_all
  end

  private

  def store_metadata
    self.filename = clip.filename
    self.video_upload_date = Time.now.utc.iso8601
  end

  def int_to_time_string(milliseconds)
    seconds, milliseconds = milliseconds.divmod(1000)
    minutes, seconds = seconds.divmod(60)
    hours, minutes = minutes.divmod(60)
    format('%<hours>02d:%<minutes>02d:%<seconds>02d.%<milliseconds>03d', hours:, minutes:, seconds:, milliseconds:)
  end

  def correct_video_type
    return unless clip.attached? && !clip.content_type.in?(%w[video/mp4])

    errors.add(:clip, 'must be a mp4')
  end

  def unique_video_file
    return if filename

    return unless clip.attached? && PracticeVideo.where.not(id:).exists?(filename: clip.filename.to_s)

    errors.add(:clip, 'has already been uploaded')
  end
end
