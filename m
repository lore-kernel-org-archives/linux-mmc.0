From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Mon, 29 Jul 2013 11:21:19 -0600
Message-ID: <51F6A48F.9090309@wwwdotorg.org>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>  <51F2ADA2.2030503@wwwdotorg.org>  <Pine.LNX.4.64.1307262215110.27439@axis700.grange>  <51F2EBD4.1060603@wwwdotorg.org>  <Pine.LNX.4.64.1307290753090.14405@axis700.grange>  <Pine.LNX.4.64.1307290903360.14405@axis700.grange>  <1375095053.3340.7.camel@hornet>  <Pine.LNX.4.64.1307291312300.14405@axis700.grange>  <1375098159.3340.29.camel@hornet>  <Pine.LNX.4.64.1307291359520.14405@axis700.grange> <1375103234.10990.8.camel@hornet> <Pine.LNX.4.64.1307291523120.14405@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1307291523120.14405@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Pawel Moll <pawel.moll@arm.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On 07/29/2013 07:30 AM, Guennadi Liakhovetski wrote:
> On Mon, 29 Jul 2013, Pawel Moll wrote:
> 
>> On Mon, 2013-07-29 at 13:05 +0100, Guennadi Liakhovetski wrote:
>>> No, that's exactly the problem. We absolutely do not want to write 
>>> compatible="vendor,soc-v1"; in a .dts file for SoC v2 just because we 
>>> currently think, that we don't have to distinguish between those SoC 
>>> versions in this specific driver. I think we all know it quite well, that 
>>> there are (practically) always differences - sometimes documented, 
>>> sometimes undocumented. And if you later find out, that you do have to 
>>> differentiate in the driver - it's too late. Even if we disregard the 
>>> argument of ugliness of having to set compatibility with soc-v1, soc-v2, 
>>> soc-v3 in different DT nodes on an SoC v4.
>>
>> First of all I think your example calls for more than one compatible
>> string - if it seems that soc,v2 is almost like soc,v1, make it
>> compatible = "soc-v2", "soc-v1" and don't touch the driver (as in: keep
>> it compatible with "soc-v1" only). Then, when the realisation comes, you
>> can simply add the "soc-v2" of_device_id with .data pointing at new
>> features.
> 
> Yes, this is also a possibility, but it seems only a little bit better. 
> Why should a DT node on SoC vN have a compatible string with SoC vK for 
> some random for an abstract user absolutely unrelated SoC version?...

Precisely because the HW /is/ compatible.

If the HW interface (registers) in two chips A and B is such that a
driver for chip A can be expected to run unmodified on chip B too
(albeit perhaps without yet supporting any new features, or perhaps not
running at full performance etc.), then chip B /is/ compatible with chip
A, and it makes sense to mark it so in DT. That way, an old kernel which
had support for chip A can run on chip B. A newer kernel might come
along later with explicit support for chip B, and hence run faster
and/or expose new features, but the driver for chip A can still work on
chip B.

> And 
> that vK would be different for different devices... So on SoC v5 MMC can 
> be compatible with with v1, sound with v2, camera with v3... Don't you 
> think it would look like a mess?

I don't consider that a mess, no. It's nice evolutionary HW design:-)
