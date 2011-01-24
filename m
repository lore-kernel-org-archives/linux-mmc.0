From: Nicolas Pitre <nico@fluxnic.net>
Subject: RE: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Mon, 24 Jan 2011 09:55:10 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101240944410.8580@xanadu.home>
References: <20110114082310.GB27523@intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
 <20110120050803.GA5732@void.printf.net>
 <AANLkTi=oOzU0fb+yGkKDkjviGWO8fq=k68+Syp+dWn5B@mail.gmail.com>
 <alpine.LFD.2.00.1101222358370.8580@xanadu.home>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7F44E6@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:63658 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751673Ab1AXOzL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Jan 2011 09:55:11 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFJ0028R83YE4D0@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 24 Jan 2011 09:55:11 -0500 (EST)
In-reply-to: <8250E4885F9967469CAC3FB5CBA2CE69934E7F44E6@irsmsx501.ger.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Tardy, Pierre" <pierre.tardy@intel.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Chris Ball <cjb@laptop.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.ml.walleij@gmail.com>

On Sun, 23 Jan 2011, Tardy, Pierre wrote:

> > 
> > First case:  you want to stop the clock _to_ the _card_ when not talking
> > to it.  That has nothing to do with power saving performed within the
> > host controller.  This is for reducing power consumption by the _card_
> > (and possibly by the clock generator).  The runtime PM stuff has no
> > business here as the decision to gate the clock on the card require
> > MMC/SD protocol knowledge.
> 
> Could not the mmcclock be a device on this own, and use rpm to manage its state?

Isn't that rather overkill?

The core stack may decide to tell the host controller to set the 
mmcclock to 400 kHz, 25 MHz, or even 0 Hz depending on various states 
that are deeply tied to the protocol used with the card and not 
necessarily for PM purposes.  So why would you make the 0 Hz a special 
case here and handle it in a different framework from the other cases?  
The fact that we do try to set the clock to 0 Hz as often as possible 
for PM purposes is only consequential and I don't see the need for a 
side structure just to handle that case.

> > Second case: you want the _host_CONTROLLER_ to be shut down so it
> > doesn't consume power by itself when idle.  This would be performed when
> > case 1 has gated the clock, but not necessarily always. 
> Agree with this, this is the idea of the my implementation.
> 
> > Here the
> > runtime PM infrastructure could make some sense.
> > 
> > All host controllers can gate the card's clock, but not all of them can
> > power themselves down.  And maybe there would be a case for keeping the
> > clock to a SDIO card active while the host controller is powered down.
> 
> > Knowledge for gating the card's clock is in the core code and
> > independent from the host controller.
> But knowledge on *how* to gate the clock is in the host controller driver, and/or platform code.

So what?  The clock is already handled today for reasons other than PM.  
And the aggressive clock gating had to modify only the core stack code 
and zero driver/platform code.  Hence I don't see the advantage to move 
away from what we have now.  Could you please elaborate more on the 
advantages you see there?


Nicolas
