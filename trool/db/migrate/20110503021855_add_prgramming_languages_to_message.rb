class AddPrgrammingLanguagesToMessage < ActiveRecord::Migration
  def self.up
    add_column :messages, :c_format, :boolean
    add_column :messages, :objc_format, :boolean
    add_column :messages, :sh_format, :boolean
    add_column :messages, :python_format, :boolean
    add_column :messages, :lisp_format, :boolean
    add_column :messages, :elisp_format, :boolean
    add_column :messages, :librep_format, :boolean
    add_column :messages, :scheme_format, :boolean
    add_column :messages, :smalltalk_format, :boolean
    add_column :messages, :java_format, :boolean
    add_column :messages, :csharp_format, :boolean
    add_column :messages, :awk_format, :boolean
    add_column :messages, :object_pascal_format, :boolean
    add_column :messages, :ycp_format, :boolean
    add_column :messages, :tcl_format, :boolean
    add_column :messages, :perl_format, :boolean
    add_column :messages, :perl_brace_format, :boolean
    add_column :messages, :php_format, :boolean
    add_column :messages, :gcc_internal_format, :boolean
    add_column :messages, :gcf_internal_format, :boolean
    add_column :messages, :qt_format, :boolean
    add_column :messages, :qt_plural_format, :boolean
    add_column :messages, :kde_format, :boolean
    add_column :messages, :boost_format, :boolean
  end

  def self.down
    remove_column :messages, :boost_format
    remove_column :messages, :kde_format
    remove_column :messages, :qt_plural_format
    remove_column :messages, :qt_format
    remove_column :messages, :gcf_internal_format
    remove_column :messages, :gcc_internal_format
    remove_column :messages, :php_format
    remove_column :messages, :perl_brace_format
    remove_column :messages, :perl_format
    remove_column :messages, :tcl_format
    remove_column :messages, :ycp_format
    remove_column :messages, :object_pascal_format
    remove_column :messages, :awk_format
    remove_column :messages, :csharp_format
    remove_column :messages, :java_format
    remove_column :messages, :smalltalk_format
    remove_column :messages, :scheme_format
    remove_column :messages, :librep_format
    remove_column :messages, :elisp_format
    remove_column :messages, :lisp_format
    remove_column :messages, :python_format
    remove_column :messages, :sh_format
    remove_column :messages, :objc_format
    remove_column :messages, :c_format
  end
end
