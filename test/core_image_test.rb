require 'rubygems'
require 'riot'
require './lib/core_image.rb'

context 'Core Image' do
  
  setup {CoreImage.new("./test/images/test.png")}
  
  context '.scale(1.5)' do
    asserts("Image was scaled up by 150%") {topic.scale(1.5).size == {:width => 75, :height => 75}}
  end
  
  context '.scale(0.6)' do
    asserts("Image was scaled down by 60%") {topic.scale(0.6).size == {:width => 30, :height => 30}}
  end
  
  context '.scale_to_size(300)' do
    asserts("Image was scaled to fit within 500px") {topic.scale_to_size(300).size == {:width => 300, :height => 300}}
  end
  
  context '.rotate(90)' do
    setup {topic.rotate(90).color_at(10, 40)}
    asserts("Image was rotated by 90 degrees") {topic == {:red => 0, :green => 0, :blue => 255, :alpha => 1.0}}
  end
  
  context '.rotate(-90)' do
    setup {topic.rotate(-90).color_at(40, 10)}
    asserts("Image was rotated by -90 degrees") {topic == {:red => 0, :green => 0, :blue => 255, :alpha => 1.0}}
  end
  
  context '.flip_horizontally' do
    setup {topic.flip_horizontally.color_at(40, 10)}
    asserts("Image was flipped on its x-axis") {topic == {:red => 0, :green => 0, :blue => 255, :alpha => 1.0}}
  end
  
  context '.flip_vertically' do
    setup {topic.flip_vertically.color_at(10, 40)}
    asserts("Image was flipped on its y-axis") {topic == {:red => 0, :green => 0, :blue => 255, :alpha => 1.0}}
  end
  
  context '.crop' do
    setup {topic.crop(0, 0, 25, 25)}
    asserts("Image was cropped to a 25 pixel box starting in lower left") {topic.size == {:width => 25, :height => 25} and topic.color_at(10, 2) == {:red => 0, :green => 128, :blue => 0, :alpha => 1.0}}
  end
  
  context '.color_at' do
    # selecting blue area
    setup {topic.color_at(10, 10)}
    asserts("Blue equals R:0, G:0, B:255, A:1.0") {topic == {:red => 0, :green => 0, :blue => 255, :alpha => 1.0}}
  end
  
  context '.to_bitmap' do
    setup {topic.to_bitmap}
    asserts("Is a bitmap") {topic.class.to_s == "OSX::NSBitmapImageRep"}
  end
  
  context '.to_cgimage' do
    setup {topic.to_cgimage}
    asserts("Is a cgimage") {topic.class.to_s == "OSX::NSObject"}
  end
  
  context '.size' do
    asserts("Size equals 50x50") {topic.size == {:width => 50, :height => 50}}
  end
  
  context '.size_to_fit_maximum(350)' do
    asserts("Returns 350x350 ratio of 7.0") {topic.size_to_fit_maximum(350) == {:height=>350, :width=>350, :ratio=>7.0}}
  end
  
  context '.revert' do
    asserts("Image reverts to original") {topic.ciimage = topic.flip_horizontally.revert.ciimage}
  end
  
end