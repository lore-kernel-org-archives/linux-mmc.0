From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC] mmc: add DT bindings for more MMC capability flags
Date: Wed, 6 Feb 2013 18:32:24 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1302061817120.13474@axis700.grange>
References: <Pine.LNX.4.64.1301231743190.26301@axis700.grange>
 <20130206151549.GA11609@e106331-lin.cambridge.arm.com>
 <Pine.LNX.4.64.1302061720390.13474@axis700.grange> <1923973.xHEn0Jh3IU@wuerfel>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:61672 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab3BFRcb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 12:32:31 -0500
In-Reply-To: <1923973.xHEn0Jh3IU@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Rutland <mark.rutland@arm.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>

On Thu, 7 Feb 2013, Arnd Bergmann wrote:

> On Wednesday 06 February 2013 17:25:42 Guennadi Liakhovetski wrote:
> > 
> > Thank for pointing me out at that thread. However, I don't think 
> > MMC_CAP_POWER_OFF_CARD has anything to do with compatibility or hardware 
> > revisions. At least I haven't yet come across any sd/mmc hosts, that also 
> > supply card power. You could "derive" this flag from the presence of a 
> > regulator, capable of changing its status (switching on / off), but even 
> > then you're not guaranteed, that you actually can (and want to) power the 
> > card off at run-time - the regulator can be shared etc. So, an explicit 
> > flag is needed.
> 
> It sounds like something that should be handled in a controller specific
> way I think. E.g. on SDHCI, there seems to always be a method to power
> down the card using the SDHCI_POWER_CONTROL register, even without
> any external regulators.

If I understand correctly, that register only controls card bus power. 
Further sdhci.c uses regulators (host->vmmc) to power up and down the 
card.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
