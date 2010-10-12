From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 15:36:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010121535460.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
 <alpine.LFD.2.00.1010112005300.2764@xanadu.home>
 <AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
 <alpine.LFD.2.00.1010112036540.2764@xanadu.home>
 <AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
 <alpine.LFD.2.00.1010121341490.2764@xanadu.home>
 <AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
 <alpine.LFD.2.00.1010121410150.2764@xanadu.home>
 <AANLkTi=K76xLSjMfYBn9VdhtaDjgP0DruPNhcAqZiq6D@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_LY4y+9c02eUG7nH+qzITBA)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:20244 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754420Ab0JLTgi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 15:36:38 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA60012TZT12U50@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 12 Oct 2010 15:36:37 -0400 (EDT)
In-reply-to: <AANLkTi=K76xLSjMfYBn9VdhtaDjgP0DruPNhcAqZiq6D@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_LY4y+9c02eUG7nH+qzITBA)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 12 Oct 2010, Dmitry Shmidt wrote:

> On Tue, Oct 12, 2010 at 11:13 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Tue, 12 Oct 2010, Dmitry Shmidt wrote:
> >
> >> On Tue, Oct 12, 2010 at 10:50 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> >> Imagine your device is keeping connection during suspend. You got packet -
> >> >> wlan will wake application processor
> >> >> through external irq line and linux starts resume. You can not find wlan
> >> >> card again - it is too slow.
> >> >
> >> > What?  I'm not following you anymore.
> >> >
> >> > The Libertas firmware can be configured to filter incoming packets and
> >> > only assert the IRQ signal only when a specific packet comes in, just
> >> > like wake-on-LAN for Ethernet devices.
> >>
> >> This is not an issue of the ability to handle packets, but to handle
> >> them quickly.
> >> This is important for VoIP for example. If you need to recognize
> >> device each time you are coming from suspend -
> >> it is not a good idea sometimes.
> >
> > I simply don't see why you'd want to suspend while a VoIP session is
> > active then.  Those methods you want to inhibit are meant for long term
> > deep suspending, not for inter-packet power saving during a call.
> 
> You are right - there are other ways to resolve some issues. I just
> wanted to add another option
> that will be kernel-related and not application-related.

Even for a kernel related solution, I don't think what you propose is 
the right thing to do.


Nicolas

--Boundary_(ID_LY4y+9c02eUG7nH+qzITBA)--
