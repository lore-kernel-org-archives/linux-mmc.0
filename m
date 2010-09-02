From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] sdhci: disable MMC_CAP_NEEDS_POLL in nonremovable case
Date: Thu, 02 Sep 2010 17:51:45 +0900
Message-ID: <4C7F65A1.60105@samsung.com>
References: <4d1a88f196fa7e7eaf4c4a4af13d91ec81fb084e.1283003070.git.matt@console-pimps.org>
 <7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:53938 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799Ab0IBIxR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Sep 2010 04:53:17 -0400
Received: from epmmp2 (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0L840035T3BZ8W10@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 17:52:47 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0L84009G03BZKW@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 02 Sep 2010 17:52:47 +0900 (KST)
In-reply-to: <7e892c443f11d51a30029ddfeef27af09a9a970d.1283003070.git.matt@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: linux-mmc@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Andrew Morton <akpm@linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, Ben Hutchings <ben@decadent.org.uk>, Yunpeng Gao <yunpeng.gao@intel.com>

Matt Fleming wrote:
> From: Jaehoon Chung <jh80.chung@samsung.com>
>
> If controller use SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk,
> controller need always polling detect
>
> In this case, always generated interrupt.Because controller checked card status.
> I think that is not efficiently.
>
> But if card is nonremovable, we need not always polling.
> So i added the check-point which is nonremovable or not
>
>  Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/sdhci.c |    5 +++--
>  1 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f6be963..3111859 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1827,8 +1827,9 @@ int sdhci_add_host(struct sdhci_host *host)
>  	if (caps & SDHCI_CAN_DO_HISPD)
>  		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
> -	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
> -		mmc->caps |= MMC_CAP_NEEDS_POLL;
> +	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> +		!mmc_card_is_removable(mmc))
> +			mmc->caps |= MMC_CAP_NEEDS_POLL;
>  
>  	mmc->ocr_avail = 0;
>  	if (caps & SDHCI_CAN_VDD_330)
>   
!mmc_card_is_removable(mmc)  is right?
i think that is mmc_card_is_removable..
because when card is removable, host controller needs polling.

+	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
+		*mmc_card_is_removable(mmc))*
+			mmc->caps |= MMC_CAP_NEEDS_POLL;

