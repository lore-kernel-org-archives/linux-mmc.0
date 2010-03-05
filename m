From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: + sdio-recognize-io-card-without-powercycle.patch added to -mm
 tree
Date: Fri, 5 Mar 2010 14:39:49 -0800
Message-ID: <20100305143949.29101892.akpm@linux-foundation.org>
References: <200909132245.n8DMj4P5007763@imap1.linux-foundation.org>
	<4B9184F2.7040004@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44881 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755836Ab0CEWjz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 17:39:55 -0500
In-Reply-To: <4B9184F2.7040004@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>

On Fri, 05 Mar 2010 23:25:54 +0100
Albert Herranz <albert_herranz@yahoo.es> wrote:

> akpm@linux-foundation.org wrote:
> > The patch titled
> >      sdio: recognize io card without powercycle
> > has been added to the -mm tree.  Its filename is
> >      sdio-recognize-io-card-without-powercycle.patch
> > 
> 
> Sorry, disregard my previous message. I replied to the wrong mail.
> I meant _this_ patch: sdio-recognize-io-card-without-powercycle.patch
> 
> So... Now yes :)
> 
> Hi,
> 
> Are there any objections to this patch?
> 
> It's been in -mm now for nearly 6 months. AFAIK there's no report against it, and it fixes problems for at least 2 drivers:
> - the Nintendo Wii SDHCI controller (for which the patch was cooked)
> - the Silex's SX-SDWAG SDIO Wi-Fi card (http://marc.info/?l=linux-mmc&m=126624571025203)
> 

I have a note here to check with Pierre, who said

: I had problems with cards already in the idle state crashing when I
: sent them a reset. I suggest a big round of testing before merging this.

I guess there's no more testing we can do so I'll merge it?
