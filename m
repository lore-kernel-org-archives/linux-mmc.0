From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 20:53:14 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010122037040.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
 <alpine.LFD.2.00.1010112005300.2764@xanadu.home>
 <AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
 <alpine.LFD.2.00.1010112036540.2764@xanadu.home>
 <AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
 <alpine.LFD.2.00.1010121341490.2764@xanadu.home>
 <AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
 <alpine.LFD.2.00.1010121410150.2764@xanadu.home>
 <AANLkTi=K76xLSjMfYBn9VdhtaDjgP0DruPNhcAqZiq6D@mail.gmail.com>
 <alpine.LFD.2.00.1010121535460.2764@xanadu.home>
 <AANLkTi=ehRGN1QMD5pNFfChHUhp=oAbOueH9v+19GXcb@mail.gmail.com>
 <alpine.LFD.2.00.1010121630260.2764@xanadu.home>
 <AANLkTik1PPHgbvSEab6VQXUbCJrO91vgec6yb7+fWbBh@mail.gmail.com>
 <alpine.LFD.2.00.1010121732370.2764@xanadu.home>
 <AANLkTi=-7ynxokzQjKJ+pOQuBoC5whGW2sg1FX3yrCLB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_l+MmAE6l/f0TsbNI4zcBLQ)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:16707 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0JMAxP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 20:53:15 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA700M5CEGQQT20@VL-MO-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 12 Oct 2010 20:53:15 -0400 (EDT)
In-reply-to: <AANLkTi=-7ynxokzQjKJ+pOQuBoC5whGW2sg1FX3yrCLB@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_l+MmAE6l/f0TsbNI4zcBLQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 12 Oct 2010, Dmitry Shmidt wrote:

> On Tue, Oct 12, 2010 at 2:37 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 12 Oct 2010, Dmitry Shmidt wrote:
> >
> >> So you want to go to suspend very aggressively.
> >> And you want to keep connectivity. And you want to resume quickly -
> >> else it is very easy to be in the situation where
> >> you just suspending and resuming all the time.
> >> So it doesn't make sense on every suspend/resume rescan for alive sdio
> >> card. Makes sense ?
> >
> > Yes, but in this case the suspend methods are inappropriate when the
> > phone is in live usage.  They are meant to be used, say, when the phone
> > becomes unused and its flap is folded.  Otherwise, what is supposed to
> > happen when you actually want the SDIO card to be suspended if the
> > suspend method is cut out?
>
> "Flap is folded"... It is not the case for usual smartphones anymore. :)
> Simple scenario - you are siting in chat, wait like 15 sec and your
> screen goes Off, after another 5 sec kernel gets suspend command and
> tries to suspend. And you are getting new message - you want to resume
> quickly and process this packet with no delay.

OK... and how do you want to achieve that?

Why isn't MMC_PM_KEEP_POWER suitable for this?

> Maybe what I am describing seems weird, but phone developers are
> fighting for every mA.

How can you save power when the WIFI interface is not in use if you 
disabled the suspend method with your patch?

> And mmc card resume if usually deferred - to reduce tiem and save
> power, but this is a different issue.

How much time are we talking about?


Nicolas

--Boundary_(ID_l+MmAE6l/f0TsbNI4zcBLQ)--
