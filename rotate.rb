#!/usr/bin/env ruby

require 'fileutils'
require 'logger'

require 'origami'
include Origami

PDF_PATH = ENV['PDF_PATH']

class RotatePDF
  attr_accessor :import_files, :export_path
  def initialize(import_files: nil, export_path: nil)
    @import_files = import_files
    @export_path  = export_path
  end
  def create_folder
    FileUtils.mkdir_p(export_path)
  end
  def process_files
    Dir[import_files].each do |file|
      rotate_pages(file)
    end
  end
  private
  def rotate_pages(file)
    pdf = PDF.read file, lazy: true
    pdf.pages.each { |page| page.setRotate 90 }
    pdf.save "/#{PDF_PATH}/export/%s" % file.split('/').last
  end
end

@rotate_pdf = RotatePDF.new(
  export_path: "#{PDF_PATH}/export",
  import_files: "#{PDF_PATH}/*.pdf"
)

begin
  @rotate_pdf.create_folder
  @rotate_pdf.process_files
rescue => exception
  Logger.debug(exception)
end

exit 0
