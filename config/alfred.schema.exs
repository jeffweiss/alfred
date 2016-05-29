@moduledoc """
A schema is a keyword list which represents how to map, transform, and validate
configuration values parsed from the .conf file. The following is an explanation of
each key in the schema definition in order of appearance, and how to use them.

## Import

A list of application names (as atoms), which represent apps to load modules from
which you can then reference in your schema definition. This is how you import your
own custom Validator/Transform modules, or general utility modules for use in
validator/transform functions in the schema. For example, if you have an application
`:foo` which contains a custom Transform module, you would add it to your schema like so:

`[ import: [:foo], ..., transforms: ["myapp.some.setting": MyApp.SomeTransform]]`

## Extends

A list of application names (as atoms), which contain schemas that you want to extend
with this schema. By extending a schema, you effectively re-use definitions in the
extended schema. You may also override definitions from the extended schema by redefining them
in the extending schema. You use `:extends` like so:

`[ extends: [:foo], ... ]`

## Mappings

Mappings define how to interpret settings in the .conf when they are translated to
runtime configuration. They also define how the .conf will be generated, things like
documention, @see references, example values, etc.

See the moduledoc for `Conform.Schema.Mapping` for more details.

## Transforms

Transforms are custom functions which are executed to build the value which will be
stored at the path defined by the key. Transforms have access to the current config
state via the `Conform.Conf` module, and can use that to build complex configuration
from a combination of other config values.

See the moduledoc for `Conform.Schema.Transform` for more details and examples.

## Validators

Validators are simple functions which take two arguments, the value to be validated,
and arguments provided to the validator (used only by custom validators). A validator
checks the value, and returns `:ok` if it is valid, `{:warn, message}` if it is valid,
but should be brought to the users attention, or `{:error, message}` if it is invalid.

See the moduledoc for `Conform.Schema.Validator` for more details and examples.
"""
[
  extends: [],
  import: [],
  mappings: [
    "alfred.Elixir.Alfred.Robot.adapter": [
      commented: false,
      datatype: :atom,
      default: Hedwig.Adapters.HipChat,
      doc: "Provide documentation for alfred.Elixir.Alfred.Robot.adapter here.",
      hidden: false,
      to: "alfred.Elixir.Alfred.Robot.adapter"
    ],
    "alfred.Elixir.Alfred.Robot.name": [
      commented: false,
      datatype: :binary,
      default: "Alfred",
      doc: "Provide documentation for alfred.Elixir.Alfred.Robot.name here.",
      hidden: false,
      to: "alfred.Elixir.Alfred.Robot.name"
    ],
    "alfred.Elixir.Alfred.Robot.aka": [
      commented: false,
      datatype: :binary,
      default: "!",
      doc: "Provide documentation for alfred.Elixir.Alfred.Robot.aka here.",
      hidden: false,
      to: "alfred.Elixir.Alfred.Robot.aka"
    ],
    "alfred.Elixir.Alfred.Robot.jid": [
      commented: false,
      datatype: :binary,
      default: "587458_3985539@chat.hipchat.com",
      doc: "Provide documentation for alfred.Elixir.Alfred.Robot.jid here.",
      hidden: false,
      to: "alfred.Elixir.Alfred.Robot.jid"
    ],
    "alfred.Elixir.Alfred.Robot.password": [
      commented: false,
      datatype: :binary,
      default: "not_my_real_password",
      doc: "Provide documentation for alfred.Elixir.Alfred.Robot.password here.",
      hidden: false,
      to: "alfred.Elixir.Alfred.Robot.password"
    ],
    "alfred.Elixir.Alfred.Robot.rooms": [
      commented: false,
      datatype: [ list: :binary ],
      default: ["587458_testing@conf.hipchat.com", "587458_elixircontinuousdelivery@conf.hipchat.com"],
      doc: "Provide documentation for alfred.Elixir.Alfred.Robot.rooms here.",
      hidden: false,
      to: "alfred.Elixir.Alfred.Robot.rooms"
    ]
  ],
  transforms: [
    "alfred.Elixir.Alfred.Robot.rooms": fn conf ->
      conf
      |> Conform.Conf.get("alfred.Elixir.Alfred.Robot.rooms")
      |> Enum.map(fn {key, rooms} -> Enum.map(rooms, fn (name) -> {name, []} end)  end)
      |> List.last
    end
  ],
  validators: []
]
