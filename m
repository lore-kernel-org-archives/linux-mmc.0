From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Thu, 14 Oct 2010 14:57:03 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010141431500.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
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
 <alpine.LFD.2.00.1010122037040.2764@xanadu.home>
 <AANLkTik-9M3vW6CyscDQTAfxhyex4PEH_fkJEYXkv__B@mail.gmail.com>
 <alpine.LFD.2.00.1010131853260.2764@xanadu.home>
 <AANLkTi=S22AF9jhbAK=Z06dnCFi0+oRcQ4M1=04q_8AX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_Ta/dzrv0VVF5/igvKRI8rw)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:36639 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753584Ab0JNS5F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2010 14:57:05 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAA0064TNAVN8E0@vl-mh-mrz21.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 14 Oct 2010 14:56:55 -0400 (EDT)
In-reply-to: <AANLkTi=S22AF9jhbAK=Z06dnCFi0+oRcQ4M1=04q_8AX@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_Ta/dzrv0VVF5/igvKRI8rw)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Thu, 14 Oct 2010, Dmitry Shmidt wrote:

> On Wed, Oct 13, 2010 at 4:10 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Wed, 13 Oct 2010, Dmitry Shmidt wrote:
> >
> >> On Tue, Oct 12, 2010 at 5:53 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> >> > Yes, but in this case the suspend methods are inappropriate when the
> >> >> > phone is in live usage.  They are meant to be used, say, when the phone
> >> >> > becomes unused and its flap is folded.  Otherwise, what is supposed to
> >> >> > happen when you actually want the SDIO card to be suspended if the
> >> >> > suspend method is cut out?
> >> >>
> >> >> "Flap is folded"... It is not the case for usual smartphones anymore. :)
> >> >> Simple scenario - you are siting in chat, wait like 15 sec and your
> >> >> screen goes Off, after another 5 sec kernel gets suspend command and
> >> >> tries to suspend. And you are getting new message - you want to resume
> >> >> quickly and process this packet with no delay.
> >> >
> >> > OK... and how do you want to achieve that?
> >> >
> >> > Why isn't MMC_PM_KEEP_POWER suitable for this?
> >> It just allows to keep power for SDC controller. It doesn't change
> >> suspend/resume behavior from SDIO device
> >> perspective.
> >
> > I think you misunderstood the purpose of MMC_PM_KEEP_POWER.
> >
> > Let's assume the context of a WIFI card.  There are cases when you want
> > the WIFI card to be suspended, and some other cases you want it to
> > remain alive when the host CPU does suspend itself.  So the decision has
> > to come from the WIFI driver not from the host controller as this is
> > where the information about the device usage is.  And that's exactly
> > what MMC_PM_KEEP_POWER is about.  When the WIFI driver receives a
> > suspend request, it can set that flag to tell the rest of the stack that
> > it wants to remain alive regardless of what the rest of the system does
> > to go to sleep.  Then the firmware on the WIFI card can be notified of
> > that state and go on with its business until it decides it has data for
> > which the host CPU should pay attention.  Then the host resumes itself
> > as usual, except for the WIFI driver which simply has to continue
> > operating the card without having to go through reconfiguration,
> > firmware loading, and so on.
> 
> Everything is correct but I also want to skip sdio device
> reinitialization from SDIO stack perspective.

It is already skipped.  See mmc_sdio_init_card() and notice the 
powered_resume argument which avoids all the costly initializations.

> > But disabling suspend methods like your patch does is fundamentally
> > the wrong approach.
> 
> Again, I am open for reasonable suggestions.

It is unreasonable to suspend and resume the system so frequently that 
the cost of the SDIO powered suspend/resume code becomes measurable.  
So if you are seeing significant costs associated to suspend/resume, 
then this is a sign that you probably are misusing it and should not 
have invoked a suspend at all in the first place.  Maybe you should 
investigate the CPU idle infrastructure instead.

But inhibiting the suspend method like this with a flag looks much more 
like a dirty hack.


Nicolas

--Boundary_(ID_Ta/dzrv0VVF5/igvKRI8rw)--
