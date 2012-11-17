From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 11/14] mmc: sdhci: fix the bug that DDR50 can't work for emmc
Date: Sat, 17 Nov 2012 17:35:42 -0500
Message-ID: <87zk2f7t8h.fsf@octavius.laptop.org>
References: <1350471893-29633-1-git-send-email-keyuan.liu@gmail.com>
	<1350471893-29633-12-git-send-email-keyuan.liu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48553 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752255Ab2KQWfu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 17 Nov 2012 17:35:50 -0500
In-Reply-To: <1350471893-29633-12-git-send-email-keyuan.liu@gmail.com> (Kevin
	Liu's message of "Wed, 17 Oct 2012 19:04:50 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Liu <keyuan.liu@gmail.com>
Cc: linux-mmc@vger.kernel.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com

Hi,

On Wed, Oct 17 2012, Kevin Liu wrote:
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c3e786d..522e501 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1529,8 +1529,15 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
>  				ctrl_2 |= SDHCI_CTRL_UHS_SDR50;
>  			else if (ios->timing == MMC_TIMING_UHS_SDR104)
>  				ctrl_2 |= SDHCI_CTRL_UHS_SDR104;
> -			else if (ios->timing == MMC_TIMING_UHS_DDR50)
> +			else if (ios->timing == MMC_TIMING_UHS_DDR50) {
> +				struct mmc_card	*card;
> +
>  				ctrl_2 |= SDHCI_CTRL_UHS_DDR50;
> +				card = container_of(&(host->mmc),
> +					struct mmc_card, host);
> +				if (mmc_card_mmc(card))
> +					ctrl_2 |= SDHCI_CTRL_VDD_180;
> +			}
>  			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>  		}
>  		if (!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN) &&

I'm using DDR50 on an eMMC that's only powered by 3.3V (no 1.8V
available) with sdhci-pxav3, so it sounds like I don't want to merge
this patch?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
