From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [PATCH] mmc: sdhci: refine non-removable card checking for card
 detection
Date: Fri, 13 Apr 2012 04:53:17 +0000
Message-ID: <17296D9F8FF2234F831FC3DF505A87A90FDB63F6@SHSMSX102.ccr.corp.intel.com>
References: <20120409231420.B54649D401E@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:53166 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751790Ab2DMExV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Apr 2012 00:53:21 -0400
In-Reply-To: <20120409231420.B54649D401E@zog.reactivated.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>, "cjb@laptop.org" <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>


> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org
> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Daniel Drake
> Sent: Tuesday, April 10, 2012 7:14 AM
> To: cjb@laptop.org
> Cc: linux-mmc@vger.kernel.org; Hunter, Adrian
> Subject: [PATCH] mmc: sdhci: refine non-removable card checking for card detection
> 
> Commit c79396c191bc19703df6eb6bbd0f673ed0df6c9d disables card detection
> where the cards are marked as non-removable.
> 
> This makes sense, but the implementation detail of calling
> mmc_card_is_removable() causes some problems, because
> mmc_card_is_removable() is overloaded with CONFIG_MMC_UNSAFE_RESUME
> semantics.
> 
> In the OLPC XO case, we need CONFIG_MMC_UNSAFE_RESUME because our root
> filesystem is stored on SD, but we also have external SD card slots where we want
> automatic card detection.
> 
> Refine the check to only apply to hosts marked as MMC_CAP_NONREMOVABLE,
> which is defined to mean that the card is *really* nonremovable. This could be
> revisited in future if we find a way to improve CONFIG_MMC_UNSAFE_RESUME
> semantics.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>
> ---
>  drivers/mmc/host/sdhci.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index
> 9aa77f3..ccefdeb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -147,7 +147,7 @@ static void sdhci_set_card_detection(struct sdhci_host
> *host, bool enable)
>  	u32 present, irqs;
> 
>  	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
> -	    !mmc_card_is_removable(host->mmc))
> +	    (host->mmc->caps & MMC_CAP_NONREMOVABLE))
>  		return;

If the SD card doesn't have a rootfs but only used to store media files, like the usage in Android, this patch is useful.

Since the Android user doesn't like the SD card (used to store media files only) to be removed by kernel when system entering S3, mmc_assume_removable will set to be 0 to prevent kernel remove SD card in suspending.

But if system is not in S3 state but in S0 state, a removable SD card slot still allow the end user to remove it. In this scenario, when mmc_assume_removable is 0, mmc_card_is_remoable will also return 0, to make SDHCI host disable card detection irqs. And finally, SDHCI host cannot detect SD card insert/removal interrupt. So I think Daniel's patch can help the Android user to fix this issue.

>From the usage of mmc_assume_removable, it is used for the SD cards who cannot be removed during suspending, but they can still be removed when out of suspending, they still have .remove/.detect callbacks.
>From the usage of the cap MMC_CAP_NONREMOVABLE, it is used for the SD cards who cannot be removed from the sd slots.
And for sdhci_set_card_detection(), it only needs to disable the card detection irqs for the SD cards who cannot be removed from the sd slots. So only checking mmc caps is enough here.

It looks good to me. Acked-by: Chuanxiao Dong <chuanxiao.dong@intel.com>

Thanks
Chuanxiao

> 
>  	present = sdhci_readl(host, SDHCI_PRESENT_STATE) &
> --
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in the body of a
> message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
