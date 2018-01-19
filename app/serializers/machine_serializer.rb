class MachineSerializer < ApplicationSerializer
  attributes :ip, :model, :id, :place, :serial

  has_one :template, serializer: TemplateSerializer do
    object.template
  end
end
