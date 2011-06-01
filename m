From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 1/2] mmc: sdhci: Replace SDHCI_QUIRK_FORCE_BLK_SZ_2048 with
 a platform hook.
Date: Wed, 01 Jun 2011 11:01:16 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106011053020.30544@xanadu.home>
References: <m31v3lofm1.fsf@pullcord.laptop.org>
 <m3mxi6p7fm.fsf@pullcord.laptop.org> <20110601040050.GA24330@pengutronix.de>
 <m3sjru40yt.fsf_-_@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:33842 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758009Ab1FAPBR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jun 2011 11:01:17 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LM4005BO9OX7TG0@vl-mo-mrz23.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 01 Jun 2011 11:00:33 -0400 (EDT)
In-reply-to: <m3sjru40yt.fsf_-_@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Wolfram Sang <w.sang@pengutronix.de>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>

On Wed, 1 Jun 2011, Chris Ball wrote:

> Hi Wolfram, Nico,
> 
> On Wed, Jun 01 2011, Wolfram Sang wrote:
> > :( I still like the io-accessor-method a lot better.
> 
> That's okay -- nothing's final yet, I just wanted to get things moving
> again since we're out of quirk space now.  I'm still happy to take a
> patch from you instead if we decide it's the better way to go.

What about letting the platform specific code override the caps bits 
instead?  That would work for many other things as well, like the 
various DMA quirks, etc.  And that requires only one callback instead of 
one per parameter you might want to override.

This should be made explicit with a dedicated callback of course, not 
via some magic in sdhci_readl() please.


Nicolas
