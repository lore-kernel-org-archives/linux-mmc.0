From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] sdhci: poll for card even when card is logically
 unremovable
Date: Fri, 06 Jul 2012 17:23:01 +0900
Message-ID: <4FF6A065.9050700@samsung.com>
References: <20120705210613.8B3F89D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:55090 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148Ab2GFIXn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Jul 2012 04:23:43 -0400
Received: from epcpsbgm2.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M6Q00DOMCLYD7R0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 06 Jul 2012 17:23:08 +0900 (KST)
Received: from [10.90.51.55] by mmp2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M6Q00FI3CMK8100@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 06 Jul 2012 17:23:08 +0900 (KST)
In-reply-to: <20120705210613.8B3F89D401E@zog.reactivated.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org

Hi Daniel,

When enabled MMC_UNSAFE_RESUME, it assumed that card didn't remove
during suspend/resume.
If you need to remove the card during suspend/resume,
why enable MMC_UNSAFE_RESUME?

Best Regards,
Jaehoon Chung

On 07/06/2012 06:06 AM, Daniel Drake wrote:

> The Marvell CaFe is now marked as having bad card detection to fix
> a problem during system resume.
> 
> Now on the OLPC XO-1 we are facing the issue that the card is marked
> as logically unremovable (via MMC_UNSAFE_RESUME), which means that
> mmc_card_is_removable considers the card non-removable. The existing
> code logic decides not to poll for card presence in this case, and
> card detection is also disabled because of the quirk being set.
> This means that no SD cards are detected when inserted after boot.
> 
> Refine the logic to enable card presence polling in the case when
> a card is logically unremovable, only avoiding the poll in the case
> when the card is physically non-removable (denoted with
> MMC_CAP_NONREMOVABLE).
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4b8b4d..dd71a05 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2779,7 +2779,7 @@ int sdhci_add_host(struct sdhci_host *host)
>  		mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
>  
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
> -	    mmc_card_is_removable(mmc))
> +	    !(host->mmc->caps & MMC_CAP_NONREMOVABLE))
>  		mmc->caps |= MMC_CAP_NEEDS_POLL;
>  
>  	/* Any UHS-I mode in caps implies SDR12 and SDR25 support. */


