From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Mon, 29 Jul 2013 14:05:53 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307291359520.14405@axis700.grange>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
 <51F2ADA2.2030503@wwwdotorg.org>  <Pine.LNX.4.64.1307262215110.27439@axis700.grange>
  <51F2EBD4.1060603@wwwdotorg.org>  <Pine.LNX.4.64.1307290753090.14405@axis700.grange>
  <Pine.LNX.4.64.1307290903360.14405@axis700.grange>  <1375095053.3340.7.camel@hornet>
  <Pine.LNX.4.64.1307291312300.14405@axis700.grange> <1375098159.3340.29.camel@hornet>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:54171 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab3G2MF7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 29 Jul 2013 08:05:59 -0400
In-Reply-To: <1375098159.3340.29.camel@hornet>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>

On Mon, 29 Jul 2013, Pawel Moll wrote:

> On Mon, 2013-07-29 at 12:27 +0100, Guennadi Liakhovetski wrote:
> > On Mon, 29 Jul 2013, Pawel Moll wrote:
> > 
> > > On Mon, 2013-07-29 at 08:18 +0100, Guennadi Liakhovetski wrote:
> > > > A short addendum. At least with Renesas SoCs I see the situation in the 
> > > > following way: new SoC versions appear relatively frequently. 
> > > 
> > > What frequency are we talking about? Once per year? Once per month? I'm
> > > not trying to be picky, it really makes a difference...
> > 
> > Definitely not every month - not until now in the mainline at least. I 
> > currently count 9 SoCs, added since 2010, which makes about 2-3 SoCs per 
> > year.
> 
> So this is actually a slower rate that I've faced in my previous life
> working for a silicon vendor ;-) And my experience is that the IPs were
> different between the SoCs indeed but:
> 
> 1. Not all of them at the same time (so no extra compatible values for
> others).

No, that's exactly the problem. We absolutely do not want to write 
compatible="vendor,soc-v1"; in a .dts file for SoC v2 just because we 
currently think, that we don't have to distinguish between those SoC 
versions in this specific driver. I think we all know it quite well, that 
there are (practically) always differences - sometimes documented, 
sometimes undocumented. And if you later find out, that you do have to 
differentiate in the driver - it's too late. Even if we disregard the 
argument of ugliness of having to set compatibility with soc-v1, soc-v2, 
soc-v3 in different DT nodes on an SoC v4.

Thanks
Guennadi

> 2. When there was a change it required change in a driver as well (so
> adding a compatible value is not an issue).
> 3. The changes were *completely* unpredictable (so even comprehensive
> list of DT properties wouldn't help)
> 
> To summarize, count this as another vote for using compatible rather
> then "universal & future-proof" set of properties. Unless there is a
> very good rationale for it (I'm sure such cases exist)
> 
> Thanks!
> 
> Pawel
> 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
