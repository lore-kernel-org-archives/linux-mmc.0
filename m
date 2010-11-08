From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 08 Nov 2010 13:47:17 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011081345070.18581@xanadu.home>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
 <AANLkTimWg_EE+hg__b0NW792szvY+4Rc_4XsjbHN_tJv@mail.gmail.com>
 <4CD7C4DB.7070105@stericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:35115 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791Ab0KHSrS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 13:47:18 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBK00MK4XIEY250@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 08 Nov 2010 13:47:02 -0500 (EST)
In-reply-to: <4CD7C4DB.7070105@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Ohad Ben-Cohen <ohad@wizery.com>, Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>

On Mon, 8 Nov 2010, Linus Walleij wrote:

> Ohad Ben-Cohen wrote:
> 
> > So the decision whether to enable clock gating for SDIO should not be
> > static (eventually. I'm not saying this is something Linus should take
> > care of in his patch, it's up to us to make this work). By default,
> > SDIO clock gating should be disabled, but we need to allow drivers to
> > explicitly enable it if supported.
> 
> I currently (patch v8) disable gating for all SDIO cards,
> but I guess there are two approaches to cases where you'd
> like to enable it:
> 
> - Card (including SDIO device) whitelisting.
> 
> - Host whitelisting - for the case where as gateable SDIO
>   device is soldered to the bus.
> 
> The first looks like big-ish so would be a separate patch, but a
> host flag for the latter like MMC_CAP_GATE_SDIO can easily be
> folded into a v10 of this patch.

No.  Please don't put such capability flag with the host.  This is still 
a card specific issue, whether or not it is soldered on the board.  So 
the first option would be the way to go.


Nicolas
