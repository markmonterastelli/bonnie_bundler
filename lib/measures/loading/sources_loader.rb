module Measures
  
  # Utility class for loading measure definitions into the database from source files
  class SourcesLoader 

    def self.load(sources_dir, user, measures_yml, vsac_user, vsac_password)
      Measures::Loader.clear_sources
      measure_details_hash = Measures::Loader.parse_measures_yml(measures_yml)

      sources_dirs = Dir.glob(File.join(sources_dir,'*'))
      sources_dirs.each_with_index do |measure_dir, index|
          measure = load_measure(measure_dir, user, vsac_user, vsac_password, measure_details_hash)
          puts "(#{index+1}/#{sources_dirs.count}): measure #{measure.measure_id} successfully loaded."
      end

    end

    def self.load_measure(measure_dir, user, vsac_user, vsac_password, measure_details_hash)
      xml_path = Dir.glob(File.join(measure_dir, '*.xml')).first
      html_path = Dir.glob(File.join(measure_dir, '*.html')).first

      xml_contents = File.read xml_path
      parser = Loader.get_parser(xml_contents)
      version = Loader.get_version(parser)
      hqmf_set_id = parser.parse_fields(xml_contents, version)['set_id']

      measure_details = measure_details_hash[hqmf_set_id]

      measure = load_measure_xml(xml_path, user, vsac_user, vsac_password, measure_details, false, true)

      Measures::Loader.save_sources(measure, xml_path, html_path)

      measure.populations.each_with_index do |population, population_index|
        measure.map_fns[population_index] = measure.as_javascript(population_index)
      end

      measure.save!
      measure
    end

    def self.load_measure_xml(xml_path, user, vsac_user, vsac_password, measure_details, overwrite_valuesets=true, cache=false)

      begin
        value_set_oids = Measures::ValueSetLoader.get_value_set_oids_from_hqmf(xml_path, cache)
      rescue Exception => e
        raise HQMFException.new "Error Loading HQMF" 
      end
      begin
        Measures::ValueSetLoader.load_value_sets_from_vsac(value_set_oids, vsac_user, vsac_password, user, overwrite_valuesets)
      rescue Exception => e
        raise VSACException.new "Error Loading Value Sets from VSAC: #{e.message}" 
      end

      begin
        value_set_models = Measures::ValueSetLoader.get_value_set_models(value_set_oids,user)
        measure = Measures::Loader.load(user, xml_path, value_set_models, measure_details)
        
        measure.save!
        measure
      rescue Exception => e
        raise HQMFException.new "Error Loading HQMF" 
      end

    end


  end
end