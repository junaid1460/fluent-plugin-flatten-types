#
# Copyright 2020- TODO: Write your name
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require "fluent/plugin/filter"
def is_number? string
  return string.to_i.to_s == string.to_s  ||  string.to_f.to_s == string.to_s
end

def flatten_record(record, result, prefix="")
  if record.is_a? Hash
    
    record.each do |key, value|
      current_prefix = prefix + '_' + key
      flatten_record(value, result, current_prefix  )
    end
  elsif record.is_a? Array
    record.each_with_index do |elem, index|
      current_prefix = prefix + '_' + index.to_s
      flatten_record(elem, result, current_prefix )
    end
  else
      if is_number?(record)
          result.store(prefix + '_n', record)
          result.store(prefix, "s:" + record.to_s)
      else
          result.store(prefix, record)
      end
  end
  return result
end

def flatten(record)
  result = {}
  record.each do |key, value|
      flatten_record(value, result, key)
  end
  return result
end

module Fluent
  module Plugin
    class FlattenTypesFilter < Fluent::Plugin::Filter
      Fluent::Plugin.register_filter("flatten_types", self)

      def filter(tag, time, record)
        return flatten(record)
      end
    end
  end
end
