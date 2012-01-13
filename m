From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 2/5 v2] ESDHC: set the timeout to the max value
Date: Fri, 13 Jan 2012 15:54:45 +0400
Message-ID: <20120113115445.GC8837@oksana.dev.rtsoft.ru>
References: <1325827997-27490-1-git-send-email-r66093@freescale.com>
 <1325827997-27490-2-git-send-email-r66093@freescale.com>
 <1325827997-27490-3-git-send-email-r66093@freescale.com>
 <8A2FC72B45BB5A4C9F801431E06AE48F1166934E@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60879 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751683Ab2AMLyu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2012 06:54:50 -0500
Received: by bkvi17 with SMTP id i17so1968950bkv.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2012 03:54:48 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F1166934E@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Jan 13, 2012 at 02:36:21AM +0000, Huang Changming-R66093 wrote:
> Hi, Anton,
> Could you have any comment about this serial patch?
> 
> Thanks
> Jerry Huang
> 
> > -----Original Message-----
> > From: Huang Changming-R66093
> > Sent: Friday, January 06, 2012 1:33 PM
> > To: linux-mmc@vger.kernel.org
> > Cc: Huang Changming-R66093; Gao Guanhua-B22826; Xie Xiaobo-R63061; Chris
> > Ball
> > Subject: [PATCH 2/5 v2] ESDHC: set the timeout to the max value
> > 
> > From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > 
> > When access the card on some FSL platform board (e.g p2020, p1010,
> > mpc8536), the following error is reported with the timeout value
> > calculated:
> > 
> > mmc0: Got data interrupt 0x00000020 even though no data operation was in
> > progress.
> > mmc0: Got data interrupt 0x00000020 even though no data operation was in
> > progress.
> > 
> > So we skip the calculation of timeout and use the max value to fix it.
> > 
> > Signed-off-by: Gao Guanhua <B22826@freescale.com>
> > Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
> > Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> > CC: Chris Ball <cjb@laptop.org>
> > ---
> > changes for v2:
> > 	- change the property to compatible for quirks
> > 
> >  drivers/mmc/host/sdhci-pltfm.c |    5 +++++
> >  1 files changed, 5 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-
> > pltfm.c index ba36c36..1c254b1 100644
> > --- a/drivers/mmc/host/sdhci-pltfm.c
> > +++ b/drivers/mmc/host/sdhci-pltfm.c
> > @@ -74,6 +74,11 @@ void sdhci_get_of_property(struct platform_device
> > *pdev)
> >  		if (of_device_is_compatible(np, "fsl,p2020-rev1-esdhc"))
> >  			host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> > 
> > +		if (of_device_is_compatible(np, "fsl,p2020-esdhc")
> > +			|| of_device_is_compatible(np, "fsl,p1010-esdhc")
> > +			|| of_device_is_compatible(np, "fsl,mpc8536-esdhc"))

A would add one more tab on these two lines.

Otherwise, looks OK.

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks,

> > +			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
> > +

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
