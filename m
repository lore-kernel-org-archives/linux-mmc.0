From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: Add "ignore mmc pm notify" functionality
Date: Tue, 12 Oct 2010 13:50:48 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010121341490.2764@xanadu.home>
References: <loom.20101011T202734-842@post.gmane.org>
 <alpine.LFD.2.00.1010112005300.2764@xanadu.home>
 <AANLkTi=QpZGrLutFBPRC29XuZ3oZATRPvD8+KaCFu0c7@mail.gmail.com>
 <alpine.LFD.2.00.1010112036540.2764@xanadu.home>
 <AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:53903 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059Ab0JLRut (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Oct 2010 13:50:49 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ20.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LA6003I5UWIAAV0@VL-MR-MRZ20.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 12 Oct 2010 13:50:42 -0400 (EDT)
In-reply-to: <AANLkTimjgqMQdwWbJ0mZpsPO12k39Tbu4siCtT4JrECT@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@android.com>
Cc: linux-mmc@vger.kernel.org

On Tue, 12 Oct 2010, Dmitry Shmidt wrote:

> MMC_PM_KEEP_POWER is mostly related to mmc host controller - keeping 
> or not keeping power on suspend/resume.

It is not "mostly related", it is _totally_ related and actually its 
purpose for existing.

> MMC_PM_WAKE_SDIO_IRQ is not related to anything right now. Also in 
> most of the cases sdio irq can not be a wake source of the application 
> processor.

Why not?  I know about at least 2 host controllers which can be 
configured so a transition on DAT3 would wake up the host.

> Imagine your device is keeping connection during suspend. You got packet -
> wlan will wake application processor
> through external irq line and linux starts resume. You can not find wlan
> card again - it is too slow.

What?  I'm not following you anymore.

The Libertas firmware can be configured to filter incoming packets and 
only assert the IRQ signal only when a specific packet comes in, just 
like wake-on-LAN for Ethernet devices.

> Again, for mmc card it totally makes sense - mmc card is NOT an active
> device.

But MMC cards still have operating states.  You cannot simply write to 
them after a power disconnect, and leaving them powered on suspend is 
not very efficient either.

PS: common netiquette is not to top-post.


Nicolas
