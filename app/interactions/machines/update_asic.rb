module Machines
  class UpdateAsic < ::ApplicationInteraction

    object :machine, class: Machine

    def execute
      return self if machine.model == 'M3'
      begin
        RestClient.post(asic_url, params, headers)
        machine.reload.save_stat
      rescue
        errors.add(:machine, "#{machine.ip} didn't respond")
      end
      self
    end

    private

    def params
       {
        _ant_pool1url: template.url1,
        _ant_pool1user: template.worker1,
        _ant_pool1pw: template.password1,
        _ant_pool2url: template.url2,
        _ant_pool2user: template.worker2,
        _ant_pool2pw: template.password2,
        _ant_pool3url: template.url3,
        _ant_pool3user: template.worker3,
        _ant_pool3pw: template.password3,
        _ant_nobeeper: false,
        _ant_notempoverctrl: false,
        _ant_fan_customize_switch: template.fan,
        _ant_fan_customize_value: template.fan_value,
        _ant_freq: template.freq
      }
    end

    def headers
      {
        'Authorization' => 'Digest username="root", realm="antMiner Configuration", nonce="99555087629fb07166425ba8fc60c615", uri="/cgi-bin/set_miner_conf.cgi", response="7bcba76120421826a1cef56dcc325a3c", qop=auth, nc=000000fe, cnonce="ed43ab12d34cd46c"',
      }
    end

    def template
      @template ||= machine.template
    end

    def asic_url
      'http://' + machine.ip + '/cgi-bin/set_miner_conf.cgi'
    end

  end
end
