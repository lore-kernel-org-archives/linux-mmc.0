From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 14:13:30 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010121410150.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
 <alpine.LFD.2.00.1010112005300.2764@xanadu.home>
 <AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
 <alpine.LFD.2.00.1010112036540.2764@xanadu.home>
 <AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
 <alpine.LFD.2.00.1010121341490.2764@xanadu.home>
 <AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_GialHxJ6EpexkrwdCSyCsQ)"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:58838 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753499Ab0JLSNb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 14:13:31 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0LA60038GVYIRX30@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 12 Oct 2010 14:13:31 -0400 (EDT)
In-reply-to: <AANLkTik016rDT1pu0U3RFRqj1XnhPK=U_t7WvzM=b+iP@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_GialHxJ6EpexkrwdCSyCsQ)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Tue, 12 Oct 2010, Dmitry Shmidt wrote:

> On Tue, Oct 12, 2010 at 10:50 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> >> Imagine your device is keeping connection during suspend. You got packet -
> >> wlan will wake application processor
> >> through external irq line and linux starts resume. You can not find wlan
> >> card again - it is too slow.
> >
> > What?  I'm not following you anymore.
> >
> > The Libertas firmware can be configured to filter incoming packets and
> > only assert the IRQ signal only when a specific packet comes in, just
> > like wake-on-LAN for Ethernet devices.
> 
> This is not an issue of the ability to handle packets, but to handle
> them quickly.
> This is important for VoIP for example. If you need to recognize
> device each time you are coming from suspend -
> it is not a good idea sometimes.

I simply don't see why you'd want to suspend while a VoIP session is 
active then.  Those methods you want to inhibit are meant for long term 
deep suspending, not for inter-packet power saving during a call.


Nicolas

--Boundary_(ID_GialHxJ6EpexkrwdCSyCsQ)--
