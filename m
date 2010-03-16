From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: + sdio-recognize-io-card-without-powercycle.patch added to -mm tree
Date: Tue, 16 Mar 2010 16:54:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1003161653270.31128@xanadu.home>
References: <200909132245.n8DMj4P5007763@imap1.linux-foundation.org>
 <4B9184F2.7040004@yahoo.es>
 <20100305143949.29101892.akpm@linux-foundation.org>
 <20100316212511.0e1932c9@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:14353 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754423Ab0CPUyc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 16 Mar 2010 16:54:32 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KZE009YF7EVTGB1@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Tue, 16 Mar 2010 16:54:31 -0400 (EDT)
In-reply-to: <20100316212511.0e1932c9@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>, Albert Herranz <albert_herranz@yahoo.es>, linux-mmc@vger.kernel.org

On Tue, 16 Mar 2010, Pierre Ossman wrote:

> On Fri, 5 Mar 2010 14:39:49 -0800
> Andrew Morton <akpm@linux-foundation.org> wrote:
> 
> > 
> > I have a note here to check with Pierre, who said
> > 
> > : I had problems with cards already in the idle state crashing when I
> > : sent them a reset. I suggest a big round of testing before merging this.
> > 
> > I guess there's no more testing we can do so I'll merge it?
> 
> Sounds reasonable. Although the question is if anyone has -mm on a
> system which lacks slot power control. :)

I can positively tell you those do exist.


Nicolas
