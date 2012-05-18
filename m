From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 07/29] mmc: add a function to get a regulator, supplying
 card's Vdd
Date: Fri, 18 May 2012 17:39:39 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205181727320.23140@axis700.grange>
References: <1336057558-11031-1-git-send-email-g.liakhovetski@gmx.de>
 <1336057558-11031-8-git-send-email-g.liakhovetski@gmx.de>
 <20120503154252.GO3955@opensource.wolfsonmicro.com>
 <Pine.LNX.4.64.1205181059560.23140@axis700.grange>
 <20120518151837.GD4039@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:55126 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755456Ab2ERPjm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 18 May 2012 11:39:42 -0400
In-Reply-To: <20120518151837.GD4039@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, 18 May 2012, Mark Brown wrote:

> On Fri, May 18, 2012 at 11:28:31AM +0200, Guennadi Liakhovetski wrote:
> 
> > 1. A regulator that can (in principle) change state, i.e., switch on and 
> > off. Such a regulator is good to keep for the runtime to power up and down 
> > the card.
> 
> > 2. A regulator, that cannot switch, but at least can tell its supplied 
> > voltage is used ones to read out supported voltages and released again.
> 
> This doesn't make sense, you can only change the voltages if you hold a
> reference to the regulator.

Yes, that's obviously a thinko. I forgot, that mmc also switches between 
different voltages, not only powers on and off.

> > 3. A regulator that can do none of the above is defined as "useless"
> 
> > > You may also run into trouble on boards that use the ability to disable
> > > unused regulators at the end of boot - they'll power things off even
> > > without the ability to change status at runtime.
> 
> > Aha, you mean, I shouldn't put() the regulator, even if it cannot change 
> > status itself?
> 
> Yes, you ought to to be safe and like I say if you want to manage the
> voltage then you need to keep a reference to the regulator.
> 
> > Can this also happen with a dummy regulator?
> 
> Obviously not,

Well, I certainly understand, that a dummy regulator cannot switch power 
by itself:-) Well, theoretically it can happen, that the board code / OF 
is missing the required entry and a shared regulator will be powered off, 
that also powers mmc, but that's obviously a bug.

> though if you've got explicit code in to handle dummy
> regulators you're rather missing the point.  Their entire purpose is to
> provide a crutch to keep the system going if bits are missing from the
> bindings, they're not intended to be used in production.

I was thinking about what to use to power off the card if both a platform 
callback (legacy) and a regulator are available (see, e.g., "[PATCH 
08/29] mmc: sh_mmcif: add regulator support"). But perhaps giving 
preference to the regulator is bogus. Maybe I should just switch both, or 
even give preference to the call-back. What do you think? Switching both 
is, perhaps, the safest bet.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
