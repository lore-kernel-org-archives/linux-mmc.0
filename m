From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/5] SDIO: introduce API for special power management
 features
Date: Thu, 11 Feb 2010 15:57:46 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002111551400.1946@xanadu.home>
References: <1265747366-6676-1-git-send-email-nico@fluxnic.net>
 <1265747366-6676-2-git-send-email-nico@fluxnic.net>
 <20100211123251.f77dbddd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:8518 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033Ab0BKU5s (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 11 Feb 2010 15:57:48 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KXP00E3P3KAQJA0@VL-MO-MR001.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Thu, 11 Feb 2010 15:57:46 -0500 (EST)
In-reply-to: <20100211123251.f77dbddd.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

On Thu, 11 Feb 2010, Andrew Morton wrote:

> On Tue, 09 Feb 2010 15:29:22 -0500
> Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > +	BUG_ON(!func);
> > +	BUG_ON(!func->card);
> > +
> > +	host = func->card->host;
> 
> It's a bit redundant to check for null and then deref the pointer - the
> kernel will reliably oops on the NULL deref, which gives us the same
> info.
> 
> I guess the BUG_ON is more useful in the case where a double-deref is
> being performed, as it can otherwise be a bit hard to work out which
> pointer was NULL.

The actual reason for those is to follow the same pattern as found in 
surrounding functions.  I personally think there are a bit too many of 
those but Pierre Ossman liked them.


Nicolas
