From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Wed, 13 Oct 2010 19:10:46 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010131853260.2764@xanadu.home>
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
 <alpine.LFD.2.00.1010122037040.2764@xanadu.home>
 <AANLkTik-9M3vW6CyscDQTAfxhyex4PEH_fkJEYXkv__B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_7VsrUDfcBtoNpM6g6BMWkg)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:11589 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487Ab0JMXKr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Oct 2010 19:10:47 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA9002H34DY4M80@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 13 Oct 2010 19:10:47 -0400 (EDT)
In-reply-to: <AANLkTik-9M3vW6CyscDQTAfxhyex4PEH_fkJEYXkv__B@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_7VsrUDfcBtoNpM6g6BMWkg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Wed, 13 Oct 2010, Dmitry Shmidt wrote:

> On Tue, Oct 12, 2010 at 5:53 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> > Yes, but in this case the suspend methods are inappropriate when the
> >> > phone is in live usage.  They are meant to be used, say, when the phone
> >> > becomes unused and its flap is folded.  Otherwise, what is supposed to
> >> > happen when you actually want the SDIO card to be suspended if the
> >> > suspend method is cut out?
> >>
> >> "Flap is folded"... It is not the case for usual smartphones anymore. :)
> >> Simple scenario - you are siting in chat, wait like 15 sec and your
> >> screen goes Off, after another 5 sec kernel gets suspend command and
> >> tries to suspend. And you are getting new message - you want to resume
> >> quickly and process this packet with no delay.
> >
> > OK... and how do you want to achieve that?
> >
> > Why isn't MMC_PM_KEEP_POWER suitable for this?
> It just allows to keep power for SDC controller. It doesn't change
> suspend/resume behavior from SDIO device
> perspective.

I think you misunderstood the purpose of MMC_PM_KEEP_POWER.

Let's assume the context of a WIFI card.  There are cases when you want 
the WIFI card to be suspended, and some other cases you want it to 
remain alive when the host CPU does suspend itself.  So the decision has 
to come from the WIFI driver not from the host controller as this is 
where the information about the device usage is.  And that's exactly 
what MMC_PM_KEEP_POWER is about.  When the WIFI driver receives a 
suspend request, it can set that flag to tell the rest of the stack that 
it wants to remain alive regardless of what the rest of the system does 
to go to sleep.  Then the firmware on the WIFI card can be notified of 
that state and go on with its business until it decides it has data for 
which the host CPU should pay attention.  Then the host resumes itself 
as usual, except for the WIFI driver which simply has to continue 
operating the card without having to go through reconfiguration, 
firmware loading, and so on.

> >> Maybe what I am describing seems weird, but phone developers are
> >> fighting for every mA.
> >
> > How can you save power when the WIFI interface is not in use if you
> > disabled the suspend method with your patch?
> You see, we are not talking about wlan chip power. CPU is consuming in
> average more energy, so
> we are talking about overall savings or consumption and not
> specifically wlan. I mean, definitely
> turn off SDC controller and remove device will save power, BUT we will
> spend much more time on resume
> meaning - more power for CPU...

I still disagree with your patch.  If you want to turn the CPU off and 
not the peripherals then this is more about some idle state than suspend 
state.  Or at least that's how you should conceptualize it.

If some peripherals are not in use, they should always be powered off 
anyway, whether or not the CPU is suspended.

But disabling suspend methods like your patch does is fundamentally 
the wrong approach.


Nicolas

--Boundary_(ID_7VsrUDfcBtoNpM6g6BMWkg)--
