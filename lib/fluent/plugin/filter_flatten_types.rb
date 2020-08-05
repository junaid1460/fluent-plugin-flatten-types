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
require 'json'

def flatten_record(record, result, thisKey)
  if record.is_a? Hash
    subrecord = {}
    result.store(thisKey, subrecord)
    record.each do |key, value|
      flatten_record(value, subrecord, key)
    end
  elsif record.is_a? Array
    subarray = []
    result.store(thisKey + '_a', subarray)
    record.each_with_index do |elem, index|
      subrecord = {}
      subarray.push(subrecord)
      flatten_record(elem, subrecord, 'v')
    end
  elsif !!record == record
    result.store(thisKey + '_b', record)
  elsif record.is_a? String 
    result.store(thisKey + '_s', record)
  elsif record.is_a? Numeric
    result.store(thisKey + '_n', record)
  else
    result.store(thisKey + '_u', record)
  end
  return result
end

def flatten(record)
  result = {}
  record.each do |key, value|
      flatten_record(value, result, key)
  end
  if record['stringify'] == true
      result.store('source_string', record.to_json)
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
