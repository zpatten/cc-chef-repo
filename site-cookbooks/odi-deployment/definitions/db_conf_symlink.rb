define :db_conf_symlink, :params => {} do
  source_path = File.join [
                              params[:shared_dir],
                              'config',
                              params[:name]
                          ]

  [
      '',
      'config'
  ].each do |portion|
    target_path = File.join [
                                params[:current_dir],
                                portion,
                                params[:name]
                            ]

    begin
      File.unlink target_path
    rescue
      nil
    end
    File.symlink source_path, target_path
  end
end