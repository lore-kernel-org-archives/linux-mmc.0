From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v1 1/3]mmc: implemented runtime pm for mmc host
Date: Sun, 23 Jan 2011 00:20:52 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101222358370.8580@xanadu.home>
References: <20110114082310.GB27523@intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AA2FE@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F54975198351D4FA654@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AAB20@irsmsx501.ger.corp.intel.com>
 <5D8008F58939784290FAB48F5497519835247E72AD@shsmsx502.ccr.corp.intel.com>
 <8250E4885F9967469CAC3FB5CBA2CE69934E7AACCC@irsmsx501.ger.corp.intel.com>
 <20110120050803.GA5732@void.printf.net>
 <AANLkTi=oOzU0fb+yGkKDkjviGWO8fq=k68+Syp+dWn5B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_ixOaarCWGCmvCG906pTtIQ)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:41396 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699Ab1AWFUx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 23 Jan 2011 00:20:53 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LFG00D51MTBRA40@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Sun, 23 Jan 2011 00:19:59 -0500 (EST)
In-reply-to: <AANLkTi=oOzU0fb+yGkKDkjviGWO8fq=k68+Syp+dWn5B@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Chris Ball <cjb@laptop.org>, "Dong, Chuanxiao" <chuanxiao.dong@intel.com>, "Tardy, Pierre" <pierre.tardy@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.ml.walleij@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_ixOaarCWGCmvCG906pTtIQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Sat, 22 Jan 2011, Ohad Ben-Cohen wrote:

> On Thu, Jan 20, 2011 at 7:08 AM, Chris Ball <cjb@laptop.org> wrote:
> > On Wed, Jan 19, 2011 at 09:45:57AM +0000, Tardy, Pierre wrote:
> >> Chris,
> >> (Sorry for top posting)
> >> Seems we have a intel intern disagreement.
> >>
> >> Could we have maintainer opinion on this ?
> >
> > Linus W and Ohad, any input here?  Thanks,
> 
> Personally I prefer the runtime PM approach.
> 
> The MMC aggressive clock gating framework is great, but it ended up
> duplicating plumbing that already existed in the runtime PM framework
> (workqueue, locking, usage refcount, "get/put" API).
> 
> Moving to runtime PM should reduce a fair amount of code from the MMC
> core, make the code more readable and easier to maintain, and let us
> take advantage of standard tools and knobs that are based on runtime
> PM's sysfs entries.

No! Please don't conflate those two cases together again.

First case:  you want to stop the clock _to_ the _card_ when not talking 
to it.  That has nothing to do with power saving performed within the 
host controller.  This is for reducing power consumption by the _card_ 
(and possibly by the clock generator).  The runtime PM stuff has no 
business here as the decision to gate the clock on the card require 
MMC/SD protocol knowledge.

Second case: you want the _host_CONTROLLER_ to be shut down so it 
doesn't consume power by itself when idle.  This would be performed when 
case 1 has gated the clock, but not necessarily always.  Here the 
runtime PM infrastructure could make some sense.

All host controllers can gate the card's clock, but not all of them can 
power themselves down.  And maybe there would be a case for keeping the 
clock to a SDIO card active while the host controller is powered down.  
Knowledge for gating the card's clock is in the core code and 
independent from the host controller.  Knowledge for powering down the 
host controller is in the host controller driver. So those two cases 
really need to remain separate.


Nicolas

--Boundary_(ID_ixOaarCWGCmvCG906pTtIQ)--
