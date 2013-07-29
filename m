From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Mon, 29 Jul 2013 14:37:35 +0100
Message-ID: <1375105055.10990.14.camel@hornet>
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
	 <1375103234.10990.8.camel@hornet>
	 <Pine.LNX.4.64.1307291523120.14405@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1307291523120.14405@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 2013-07-29 at 14:30 +0100, Guennadi Liakhovetski wrote:
> Yes, this is also a possibility, but it seems only a little bit better. 
> Why should a DT node on SoC vN have a compatible string with SoC vK for 
> some random for an abstract user absolutely unrelated SoC version?... And 
> that vK would be different for different devices... So on SoC v5 MMC can 
> be compatible with with v1, sound with v2, camera with v3... Don't you 
> think it would look like a mess?

It won't be SoC v5 MMC then. It will be just MMC vX. SoC v6 will still
have MMC vX, but SoC v7 already MMC vY (where, most likely, Y=X+1). I
appreciate the fact that the SoC datasheets don't always explicitly
mention the IP revision, but it's still there. Also, quite often the
differences don't lie in the IP itself (it costs a lot of money to
license a new version of eg. MMC host controller from Synopsys), but in
the glue logic/adaptation layer etc. But in such case it probably should
be described in the tree itself. Which gets us to square one :-)

Pawel

PS. Of course MMC vY may be just a superset of vX, so then it will be
compatible with "MMC vY", "MMC vX".


