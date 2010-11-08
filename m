From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] mmc: agressive clocking framework v9
Date: Mon, 08 Nov 2010 13:49:31 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1011081348000.18581@xanadu.home>
References: <43E4817426ED174AA81263BCECB4351D131D9D41BC@sc-vexch3.marvell.com>
 <AANLkTi=6FeuxhEL1ht4thc6PQ05wLFo7d2NA-XUYwHxy@mail.gmail.com>
 <041757E8-9FCD-4FA8-8079-7A3FC07E4038@marvell.com>
 <AANLkTimWg_EE+hg__b0NW792szvY+4Rc_4XsjbHN_tJv@mail.gmail.com>
 <4CD7C4DB.7070105@stericsson.com>
 <C771C677-E21B-41FC-ABEE-DBEFEFA8569D@marvell.com>
 <4CD7D395.8040804@stericsson.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:29951 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab0KHStb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Nov 2010 13:49:31 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz25.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LBK00M3QXM4Y260@vl-mh-mrz25.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 08 Nov 2010 13:49:16 -0500 (EST)
In-reply-to: <4CD7D395.8040804@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Philip Rakity <prakity@marvell.com>, Ohad Ben-Cohen <ohad@wizery.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, David Vrabel <david.vrabel@csr.com>

On Mon, 8 Nov 2010, Linus Walleij wrote:

> Philip Rakity wrote:
> > On Nov 8, 2010, at 1:37 AM, Linus Walleij wrote:
> >> - Card (including SDIO device) whitelisting.
> > 
> > do not understand the term whitelisting ..  please explain.
> 
> The idea would be to have a database with ID:s for cards
> that may be gated. Any SDIO card not it this list would
> not be gated.

Instead, let each SDIO card function driver indicate to the core if it 
is OK to gate the clock or not.


Nicolas
