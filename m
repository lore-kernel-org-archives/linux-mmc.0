From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Mon, 29 Jul 2013 13:27:13 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307291312300.14405@axis700.grange>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
 <51F2ADA2.2030503@wwwdotorg.org>  <Pine.LNX.4.64.1307262215110.27439@axis700.grange>
  <51F2EBD4.1060603@wwwdotorg.org>  <Pine.LNX.4.64.1307290753090.14405@axis700.grange>
  <Pine.LNX.4.64.1307290903360.14405@axis700.grange> <1375095053.3340.7.camel@hornet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1375095053.3340.7.camel@hornet>
Sender: linux-sh-owner@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, 29 Jul 2013, Pawel Moll wrote:

> On Mon, 2013-07-29 at 08:18 +0100, Guennadi Liakhovetski wrote:
> > A short addendum. At least with Renesas SoCs I see the situation in the 
> > following way: new SoC versions appear relatively frequently. 
> 
> What frequency are we talking about? Once per year? Once per month? I'm
> not trying to be picky, it really makes a difference...

Definitely not every month - not until now in the mainline at least. I 
currently count 9 SoCs, added since 2010, which makes about 2-3 SoCs per 
year.

Thanks
Guennadi

> > With compatibility strings we have to change _all_ Renesas drivers for _each_ 
> > SoC version even if just to add a new struct of_device_id entry. This 
> > doesn't seem very productive to me.
> 
> There is at least precedence in the MMC world - have a look at
> drivers/mmc/host/mmci.c and the struct variant_data... There seem to be
> a new variant every 6 months or so (I must admit guilt of of making some
> of them ;-) coming from two different companies.
> 
> And although it's a primecell (aka amba_bus) device, so the compatibilty
> string remains the same, the struct amba_id was being extended every
> time which is pretty much the same thing.
> 
> Pawel
> 
> PS. Having said all that I'm hoping the MMCI evolution has finally
> stopped so no new variants will be needed ;-)

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
