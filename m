From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/2] drivers: mmc: add quirk
 SDHCI_QUIRK_CLOCK_DIV_ZERO_BROKEN
Date: Tue, 09 Jun 2015 17:44:10 +0900
Message-ID: <5576A75A.5050104@samsung.com>
References: <1433835111-32522-1-git-send-email-suneel.garapati@xilinx.com>
 <1433835111-32522-2-git-send-email-suneel.garapati@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51324 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956AbbFIIoM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Jun 2015 04:44:12 -0400
In-reply-to: <1433835111-32522-2-git-send-email-suneel.garapati@xilinx.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Suneel Garapati <suneel.garapati@xilinx.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, michals@xilinx.com, sorenb@xilinx.com, Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <b29396@freescale.com>, Haibo Chen <haibo.chen@freescale.com>, Tim Kryger <tim.kryger@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Yi Sun <yi.y.sun@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, stripathi@apm.com

Hi,

On 06/09/2015 04:31 PM, Suneel Garapati wrote:
> adds quirk for controllers whose clock divider zero is broken,
> sdhci_set_clock function will incorporate this modification.
> 
> Signed-off-by: Suneel Garapati <suneel.garapati@xilinx.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  drivers/mmc/host/sdhci.h | 2 ++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1b4861d..087327e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1210,6 +1210,10 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> 			}
> 			real_div = div;
> 			div >>= 1;
> +			if ((host->quirks2 & SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN)
> +				&& !div && host->max_clk <= 25000000) {
> +				div = 1;
> +			}

I can't understand fully. how can it be broken for divider zero?
When formatting error is occurred, do you check really clock value?
I think your patch looks like just hard-coding for control clock.

Best Regards,
Jaehoon Chung

> 		}
> 	} else {
> 		/* Version 2.00 divisors must be a power of 2. */
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 5521d29..67046ca 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -409,6 +409,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_SUPPORT_SINGLE			(1<<13)
>  /* Controller broken with using ACMD23 */
>  #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
> +/* Broken Clock divider zero in controller */
> +#define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
> 
> 	int irq;		/* Device IRQ */
> 	void __iomem *ioaddr;	/* Mapped address */
> --
> 2.1.2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

