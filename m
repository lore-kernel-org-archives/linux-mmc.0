From: Wouter van Heyst <larstiq@larstiq.dyndns.org>
Subject: Re: [PATCH] mmc: add module parameter to set whether cards are
 assumed removable
Date: Tue, 1 Dec 2009 20:57:48 +0100
Message-ID: <20091201195747.GA4861@one.lan>
References: <1257914676.2237.57.camel@localhost>
 <20091116122329.847916b6.akpm@linux-foundation.org>
 <1258410709.2792.9.camel@localhost>
 <20091122114234.GA28590@one.lan>
 <1258893136.3627.10.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cust.7.157.adsl.cistron.nl ([62.216.7.157]:59914 "EHLO
	larstiq.dyndns.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111AbZLAT5y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 14:57:54 -0500
Content-Disposition: inline
In-Reply-To: <1258893136.3627.10.camel@localhost>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 504391@bugs.debian.org, Pierre Ossman <pierre@ossman.eu>

On Sun, Nov 22, 2009 at 12:32:16PM +0000, Ben Hutchings wrote:
> On Sun, 2009-11-22 at 12:42 +0100, Wouter van Heyst wrote:

...

> > I'm running 2.6.32-rc7 with this patch applied and CONFIG_MMC_UNSAFE_RESUME=y
> > That works as desired for my non-removable case. Is it desired that I
> > test if 'removable=1' will thrash my filesystem?
> 
> Please test with CONFIG_MMC_UNSAFE_RESUME=n (which Debian will continue
> to use) and removable=0.

It took a while to get around to it correctly, but yes this works.
Without setting removable=0 my Acer Aspire One hangs while trying to
resume if the mmc card is mounted.

Wouter van Heyst
