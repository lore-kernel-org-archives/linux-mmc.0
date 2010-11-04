From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Thu, 04 Nov 2010 13:01:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1011041257270.18581@xanadu.home>
References: <1288869390-20465-1-git-send-email-linus.walleij@stericsson.com>
 <4CD2B1FF.6030708@csr.com> <4CD2C240.8030400@stericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:38114 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab0KDRCF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Nov 2010 13:02:05 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBD00G88DYU8QR0@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 04 Nov 2010 13:01:43 -0400 (EDT)
In-reply-to: <4CD2C240.8030400@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: David Vrabel <david.vrabel@csr.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ghorai Sukumar <s-ghorai@ti.com>, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@nokia.com>, Kyungmin Park <kmpark@infradead.org>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>

On Thu, 4 Nov 2010, Linus Walleij wrote:

> David Vrabel wrote:
> > Linus Walleij wrote:
> >> @@ -148,14 +148,19 @@ static int mmc_runtime_suspend(struct device *dev)
> >>  {
> >>  	struct mmc_card *card = mmc_dev_to_card(dev);
> >>  
> >> +	mmc_gate_clock(card->host);
> >>  	return mmc_power_save_host(card->host);
> >>  }
> > 
> > Haven't you tied the clock gating to the power on/off state of the
> > card/host?  This looks like the wrong thing to me.  Surely we want to
> > gate the clock even if the card (or SDIO functions) are active?
> 
> You're probably right :-/
> 
> Since the runtime_pm_get/put calls are balanced for the host
> enable/disable case and the clock gating is orthogonal,
> I need to create an orthogonal instance of hooks, maybe it's
> easiest to just spawn a second dummy device like mmc0_clk
> for this to be able to use the runtime PM hooks?

Maybe the runtime PM stuff is not the right abstraction for this?  Like 
I said before, the host controller driver should do opportunistic power 
savings on its own and remain transparent to the core layer and the 
card.  But power saving on the card should be controlled by the core 
code or the function driver.  So there shouldn't be any coupling between 
those, even if the host controller driver is in the middle.


Nicolas
