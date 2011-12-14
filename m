From: Huang Changming-R66093 <r66093@freescale.com>
Subject: RE: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the card
Date: Wed, 14 Dec 2011 02:31:11 +0000
Message-ID: <8A2FC72B45BB5A4C9F801431E06AE48F11645DB1@039-SN1MPN1-006.039d.mgd.msft.net>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
	<F2681397-0395-43F7-902F-9A575EDD843B@marvell.com>
 <m2aa6wl52e.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:34887 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731Ab1LNCbN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Dec 2011 21:31:13 -0500
In-Reply-To: <m2aa6wl52e.fsf@bob.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Wednesday, December 14, 2011 2:06 AM
> To: Philip Rakity
> Cc: Huang Changming-R66093; linux-mmc@vger.kernel.org; Huang Changming-
> R66093
> Subject: Re: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the
> card
> 
> Hi,
> 
> On Mon, Dec 05 2011, Philip Rakity wrote:
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 6d8eea3..66afd82 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2,6 +2,7 @@
> >>  * linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller
> >> Interface driver
> >>  *
> >>  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
> >> + *  Copyright (C) 2011 Freescale Semiconductor Inc.
> >
> >
> > Lots of folks have made mods to this code and they have not added a
> > copyright name.
> > What is the rule Chris ?
> 
> You're right that many people have added far more significant changes
> than this without adding a copyright string, so we shouldn't add this one
> now.
> 
> In general, though, I'd say that the rule is that you may (but are not
> required to) add a copyright string if your change is reasonably large
> and non-obvious/non-boilerplate.  I don't think the copyright string
> means anything -- copyright is implicit in the authorship history which
> Git preserves -- but I'm not a lawyer.  Having your name in the copyright
> string may make enforcing the GPL for that driver slightly easier for you,
> so for that reason I'm glad Pierre added himself.
> 
According to my company policy, for the open source changes, I can't add myself to the copyright.
If you think it is not reasonable to add the copyright, I will remove it in next version.

