require 'pxfinder/photography/lens_make'
require 'pxfinder/photography/camera_make'

module Pxfinder
  module Photography
    APPLE          = 'Apple'.freeze
    CANON          = 'Canon'.freeze
    CARL_ZEISS     = 'Carl Zeiss'.freeze
    FUJIFILM       = 'Fujifilm'.freeze
    HASSELBLAD     = 'Hasselblad'.freeze
    KONICA_MINOLTA = 'Konica Minolta'.freeze
    LEICA          = 'Leica'.freeze
    LENSBABY       = 'Lensbaby'.freeze
    NIKON          = 'Nikon'.freeze
    OLYMPUS        = 'Olympus'.freeze
    PANASONIC      = 'Panasonic'.freeze
    PENTAX         = 'Pentax'.freeze
    RICOH          = 'Ricoh'.freeze
    SAMSUNG        = 'Samsung'.freeze
    SAMYANG        = 'Samyang'.freeze
    SIGMA          = 'Sigma'.freeze
    SONY           = 'Sony'.freeze
    TAMRON         = 'Tamron'.freeze
    TOKINA         = 'Tokina'.freeze
    VOIGTLANDER    = 'Voigtlander'.freeze
    MODEL_NAMES    = {
      'DSLR-A100'    => 'A100',
      'DSLR-A100/S'  => 'A100',
      'DSLR-A200'    => 'A200',
      'DSLR-A230'    => 'A230',
      'DSLR-A290'    => 'A290',
      'DSLR-A300'    => 'A300',
      'DSLR-A300K/N' => 'A300',
      'DSLR-A330'    => 'A330',
      'DSLR-A330L/T' => 'A330',
      'DSLR-A350'    => 'A350',
      'DSLR-A350K/N' => 'A350',
      'DSLR-A380'    => 'A380',
      'DSLR-A390'    => 'A390',
      'DSLR-A450'    => 'A450',
      'DSLR-A500'    => 'A500',
      'DSLR-A550'    => 'A550',
      'DSLR-A560'    => 'A560',
      'DSLR-A580'    => 'A580',
      'DSLR-A700'    => 'A700',
      'DSLR-A850'    => 'A850',
      'DSLR-A900'    => 'A900',
      'ILCA-68'      => 'A68',
      'ILCA-77M2'    => 'A77 II',
      'ILCA-77M'     => 'A77 II',
      'ILCA-99M2'    => 'A99 II',
      'ILCE-3000'    => 'A3000',
      'ILCE-3500'    => 'A3500',
      'ILCE-5000'    => 'A5000',
      'ILCE-5100'    => 'A5100',
      'ILCE-6000'    => 'A6000',
      'ILCE-6300'    => 'A6300',
      'ILCE-6500'    => 'A6500',
      'ILCE-7'       => 'A7',
      'ILCE-7M2'     => 'A7 II',
      'ILCE-7R'      => 'A7R',
      'ILCE-7RM2'    => 'A7R II',
      'ILCE-7S'      => 'A7S',
      'ILCE-7SM2'    => 'A7S II',
      'ILCE-9'       => 'A9',
      'ILCE-QX1'     => 'AQX1',
      'NEX-3'        => 'NEX-3',
      'NEX-3C'       => 'NEX-3',
      'NEX-3N'       => 'NEX-3N',
      'NEX-5'        => 'NEX-5',
      'NEX-5C'       => 'NEX-5',
      'NEX-5N'       => 'NEX-5N',
      'NEX-5R'       => 'NEX-5R',
      'NEX-5T'       => 'NEX-5T',
      'NEX-6'        => 'NEX-6',
      'NEX-7'        => 'NEX-7',
      'NEX-C3'       => 'NEX-C3',
      'NEX-F3'       => 'NEX-F3',
      'SLT-A33'      => 'A33',
      'SLT-A35'      => 'A35',
      'SLT-A37'      => 'A37',
      'SLT-A55'      => 'A55',
      'SLT-A55V'     => 'A55',
      'SLT-A57'      => 'A57',
      'SLT-A58'      => 'A58',
      'SLT-A65'      => 'A65',
      'SLT-A65V'     => 'A65',
      'SLT-A77'      => 'A77',
      'SLT-A77V'     => 'A77',
      'SLT-A99'      => 'A99',
      'SLT-A99V'     => 'A99'
    }.freeze

    def lens_make(model_name)
      LensMake.name(model_name)
    end
    module_function :lens_make

    def camera_make(model_name)
      CameraMake.name(model_name)
    end
    module_function :camera_make

    def known?(manufacturer)
      all = [APPLE, CANON, CARL_ZEISS, FUJIFILM, HASSELBLAD, KONICA_MINOLTA,
             LEICA, LENSBABY, NIKON, OLYMPUS, PANASONIC, PENTAX, RICOH,
             SAMSUNG, SAMYANG, SIGMA, SONY, TAMRON, TOKINA, VOIGTLANDER]

      all.include?(manufacturer.capitalize)
    end
    module_function :known?

    def remove_make_from_name(name, make)
      return name if make.nil?

      if name.downcase.include?(make.downcase)
        name.gsub(/#{make}/i, '').strip
      else
        name
      end
    end
    module_function :remove_make_from_name

    def pretty_name(model_name, make)
      return model_name if make.nil?
      model_name = remove_make_from_name(model_name, make)

      # resolve camera name into its commercial name
      "#{make} #{decode(model_name) || model_name}".strip
    end
    module_function :pretty_name

    def decode(model_name)
      MODEL_NAMES[model_name.upcase.strip]
    end
    module_function :decode
    private_class_method :decode
  end
end
