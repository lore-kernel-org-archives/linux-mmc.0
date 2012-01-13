From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH 3/4 v5] SDHCI: add sdhci_get_cd callback to detect the
 card
Date: Fri, 13 Jan 2012 14:20:35 +0800
Message-ID: <20120113062034.GA2701@ladygaga>
References: <1323829093-29655-1-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F116692DB@039-SN1MPN1-005.039d.mgd.msft.net>
 <20120113032647.GC7564@ladygaga>
 <8A2FC72B45BB5A4C9F801431E06AE48F11669487@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from db3ehsobe002.messaging.microsoft.com ([213.199.154.140]:31871
	"EHLO DB3EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752151Ab2AMGU5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 01:20:57 -0500
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F11669487@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On Fri, Jan 13, 2012 at 04:50:11AM +0000, Huang Changming-R66093 wrote:
> 
> 
> > I think this function has to take care of standard sd host behaviour: if
> > a specific host has implemented the get_cd callback, then use it; if
> > not, then see the BROKEN_DETECT quirk; finally, use the present register
> > to get the value like the sdhci_request function does.
> > 
> Yes, I have thought about it.
> In this patch, only FSL eSDHC use it.

Only FSL eSDHC defines it, but all sd hosts will use it since the call
is made in core.c with host->ops->get_cd.

If you only cares about FSL eSDHC, then probably you should do this in
sdhci.c instead of core.c, by adding a callback to the sdhci_ops and in
the sdhci_request call, instead of checking present register, call the
get_cd callback if available.

> For the other platform, the get_cd is NULL.
>




