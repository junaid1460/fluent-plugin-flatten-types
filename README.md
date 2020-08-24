# fluent-plugin-flatten-types

[Fluentd](https://fluentd.org/) filter plugin annotate types.
Annotates json object end value to avoid conflicts with random overlaping data.

## Installation

### RubyGems

```
$ gem install fluent-plugin-flatten-types
```

#### Usage

```

<filter **>
  @type flatten_types
</filter>
```

#### Input

```json
{
  "name": "junaid",
  "type": 20,
  "values": [1, "2323", { "name": "randy" }],
  "random_json": {
    "__str__": true,
    "response": {
      "code": "AX12312",
      "message": "Cannot parse"
    }
  }
}
```

#### Output

```json
{
  "name_s": "junaid",
  "type_n": 20,
  "values_a": [{ "v_n": 1 }, { "v_n": "2323" }, { "v": { "name": "randy" } }],
  "random_json_s": "{\"__str__\":true,\"response\":{\"code\":\"AX12312\",\"message\":\"Cannot parse\"}}"
}
```

#### key transforms based on type

| type           | example               | tranform                        |
| -------------- | --------------------- | ------------------------------- |
| number         | `"type": 20`          | `"type_n": 20`                  |
| string         | `"name": "kaleo"`     | `"name_s": "kaleo"`             |
| array          | `"values": [...]`     | `"values_a": [...]`             |
| array[element] | `[2, "3"]`            | `[{ "v_n" : 2 }, {"v_s": "3"}]` |
| boolean        | `"is_enabled": false` | `"is_enabled_b": false`         |
| map            | `"object": {}`        | `"object": {}`                  |

Additional feature.

setting `__str__` to `true` in any map will stringify the map

## Copyright

- Copyright(c) 2020- junaid junaid1460@gmail.com
- License
  - Apache License, Version 2.0
