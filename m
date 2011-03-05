From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v2 05/12] mmc: sdhci: reset sdclk before setting high
 speed enable
Date: Fri, 4 Mar 2011 20:57:05 -0800
Message-ID: <4CC9533A-376B-4E2F-B108-E789C9D3B10A@marvell.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-6-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:59797 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751965Ab1CEE5O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 4 Mar 2011 23:57:14 -0500
In-Reply-To: <1299238369-1768-6-git-send-email-arindam.nath@amd.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "henry.su@amd.com" <henry.su@amd.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>


On Mar 4, 2011, at 3:32 AM, Arindam Nath wrote:

> As per Host Controller spec v3.00, we reset SDCLK before setting
> High Speed Enable, and then set it back to avoid generating clock
> gliches.
> 
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> ---
> drivers/mmc/host/sdhci.c |   25 ++++++++++++++++++++++---
> 1 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1645687..5d3bb11 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1277,13 +1277,12 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 	else
> 		ctrl &= ~SDHCI_CTRL_HISPD;
> 
> -	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> -
> 	if (host->version >= SDHCI_SPEC_300) {
> 		u16 ctrl_2;
> 
> 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> 		if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
> +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> 			/*
> 			 * We only need to set Driver Strength if the
> 			 * preset value enable is not set.
> @@ -1294,8 +1293,28 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
> 
> 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> +		} else {
> +			/*
> +			 * According to SDHC Spec v3.00, if the Preset Value
> +			 * Enable in the Host Control 2 register is set, we
> +			 * need to reset SD Clock Enable before changing High
> +			 * Speed Enable to avoid generating clock gliches.
> +			 */
> +			u16 clk;
> +
> +			/* Reset SD Clock Enable */
> +			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> +			clk &= ~SDHCI_CLOCK_CARD_EN;
> +			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> +
> +			/* Re-enable SD Clock */
> +			clk |= SDHCI_CLOCK_CARD_EN;
> +			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);

Need to ensure clock is stable before using it ---- use sdhci_set_clock

> 		}



> -	}
> +	} else
> +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> 
> 	/*
> 	 * Some (ENE) controllers go apeshit on some ios operation,
> -- 
> 1.7.1
> 

