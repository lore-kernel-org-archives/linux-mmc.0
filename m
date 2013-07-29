From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Mon, 29 Jul 2013 14:07:14 +0100
Message-ID: <1375103234.10990.8.camel@hornet>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
	 <51F2ADA2.2030503@wwwdotorg.org>
	 <Pine.LNX.4.64.1307262215110.27439@axis700.grange>
	 <51F2EBD4.1060603@wwwdotorg.org>
	 <Pine.LNX.4.64.1307290753090.14405@axis700.grange>
	 <Pine.LNX.4.64.1307290903360.14405@axis700.grange>
	 <1375095053.3340.7.camel@hornet>
	 <Pine.LNX.4.64.1307291312300.14405@axis700.grange>
	 <1375098159.3340.29.camel@hornet>
	 <Pine.LNX.4.64.1307291359520.14405@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1307291359520.14405@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2013-07-29 at 13:05 +0100, Guennadi Liakhovetski wrote:
> No, that's exactly the problem. We absolutely do not want to write 
> compatible="vendor,soc-v1"; in a .dts file for SoC v2 just because we 
> currently think, that we don't have to distinguish between those SoC 
> versions in this specific driver. I think we all know it quite well, that 
> there are (practically) always differences - sometimes documented, 
> sometimes undocumented. And if you later find out, that you do have to 
> differentiate in the driver - it's too late. Even if we disregard the 
> argument of ugliness of having to set compatibility with soc-v1, soc-v2, 
> soc-v3 in different DT nodes on an SoC v4.

First of all I think your example calls for more than one compatible
string - if it seems that soc,v2 is almost like soc,v1, make it
compatible = "soc-v2", "soc-v1" and don't touch the driver (as in: keep
it compatible with "soc-v1" only). Then, when the realisation comes, you
can simply add the "soc-v2" of_device_id with .data pointing at new
features.

Now the other thing - do you have a driver for a SoC at all? What I mean
is that in most cases it's the components/peripherals/IPs (whatever you
call them) matter, not the SoC itself, so the SoC compatible value can
be unique if you wish (and, if it is a *.dtsi, it will be compatbile
with "simple-bus" anyway ;-). Then the IP nodes can follow the rule
above.

Hope it makes some sense?

Pawel


