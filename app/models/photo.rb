# coding: utf-8
class Photo < ApplicationRecord
  belongs_to :album
  #mount_uploader :picture, ImgupUploader
  #has_one_attached :picture
  has_one_attached :picture do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  validates :album_id, presence: true
  #validate  :picture_size
  validate  :album_size
  validates :picture, content_type:{ in: %w[image/jpeg image/gif image/png],
                                  message: "must be a valid image format" },
                                  size:         { less_than: 1.megabytes,
                                    message: "should be less than 1MB" }

  def self.combine_photos(photos)
    # =>  Convert the carrierwave attachment(image)
    files = photos.map{|p| p.image.file.to_file}
    orginal_filename = photos.first.name

    # => Create a new file
    new_file = File.open(orginal_filename, 'w')



    # => Create new photo's object with the combined file
    final_photo = Photo.new
    final_photo.name = orginal_filename
    #final_photo.image = new_file
    #final_photo.picture.attach(photos)
    # => Remove all parts of the image
    #photos.destroy_all

    return final_photo
  end

  private
    # 验证上传的图像大小
  

    def album_size
      if album_id.to_i < 1
        errors.add(:album_id, "Please select album")
      end
    end

end
