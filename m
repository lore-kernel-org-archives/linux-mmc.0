From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/4] [MMC] core SDIO suspend/resume support
Date: Mon, 07 Sep 2009 21:53:20 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909072145220.6044@xanadu.home>
References: <1251916646-3537-1-git-send-email-nico@cam.org>
 <1251916646-3537-2-git-send-email-nico@cam.org>
 <20090906161741.33a56583@mjolnir.ossman.eu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:17913 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458AbZIHBxX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Sep 2009 21:53:23 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KPM00DNDQKWBV80@VL-MH-MR002.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 07 Sep 2009 21:53:20 -0400 (EDT)
In-reply-to: <20090906161741.33a56583@mjolnir.ossman.eu>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pierre Ossman <pierre@ossman.eu>
Cc: linux-mmc@vger.kernel.org

On Sun, 6 Sep 2009, Pierre Ossman wrote:

> On Wed, 02 Sep 2009 14:37:23 -0400
> Nicolas Pitre <nico@cam.org> wrote:
> 
> > 
> > When resuming, we make sure the same card is still inserted by comparing
> > the vendor and product IDs.  If there is a mismatch, or if there is simply
> > no card anymore in the slot, then the previous card is "removed" and the
> > new card is detected.
> > 
> 
> I know this is an area with a lot of differing views, but I see this as
> totally insufficient. Like storage cards, this card might have a
> non-volatile state that drivers and upper layers rely on being the same
> before and after suspend.
> 
> (Then there's also the issue of e.g. having two "identical" wifi cards
> but with different MAC addresses).
> 
> I think the right way to go is to retain enough power to the card for
> it to stay initialised and then poke it at resume to see if it is still
> running in the same state we left it.

IMHO the right way to go is instead to consider patch2/4 that goes along 
with this series and defer such additional intelligence to each function 
driver's resume method.  After all that's where knowledge of MAC 
addresses and so on should be, not in the core code.

And in the context of power management, always having to keep power to 
the card is somehow against the point, isn't it?  Especially considering 
that this simply is not always possible.


Nicolas
