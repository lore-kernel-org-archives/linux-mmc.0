From: Zhang Haijun-B42677 <B42677@freescale.com>
Subject: RE: [PATCH] Powerpc/eSDHC: Calculate the applicable mmc erase
 timeout value
Date: Thu, 29 Nov 2012 05:09:29 +0000
Message-ID: <99E897753B6F7048BD8CCDB4661D02E1179EC0@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1354164502-17697-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:12235
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750711Ab2K2FJg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 29 Nov 2012 00:09:36 -0500
In-Reply-To: <1354164502-17697-1-git-send-email-Haijun.Zhang@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Huang Changming-R66093 <r66093@freescale.com>, Zhang Haijun-B42677 <B42677@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Thanks Anton

Please review.


Regards
Haijun.


> -----Original Message-----
> From: Zhang Haijun-B42677
> Sent: Thursday, November 29, 2012 12:48 PM
> To: linux-mmc@vger.kernel.org
> Cc: Zhang Haijun-B42677; Huang Changming-R66093; Anton Vorontsov
> Subject: [PATCH] Powerpc/eSDHC: Calculate the applicable mmc erase
> timeout value
> 
> As large area erase needs long time usually a few minutes, So we use
> max_discard_to to limit the size one request can issue to avoid timeout.
> As our controller had the quirk SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK so we
> need to assign the timeout_clk and max_discard_to according to the
> max_dtr which can be read after the card had setup and decoded, As esdhc-
> imx also use this func and this quirk so this patch will also work on
> esdhci-imx, but this patch only test on powerpc platform, if there are
> any negative impact on esdhc-imx please let me know.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
> changes for v5:
> 	- Split two variable in their own line
> changes for v4:
> 	- Apply the timeout clk after the card setup and reuse quirk
> changes for v3:
> 	- Add an empty line
> 
>  drivers/mmc/host/sdhci-esdhc.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-
> esdhc.h index d25f9ab..a9968e3 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -47,6 +47,7 @@ static inline void esdhc_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  	int pre_div = 2;
>  	int div = 1;
>  	u32 temp;
> +	u32 actual_clk;
> 
>  	if (clock == 0)
>  		goto out;
> @@ -65,6 +66,8 @@ static inline void esdhc_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
>  		clock, host->max_clk / pre_div / div);
> 
> +	actual_clk = host->max_clk / pre_div / div;
> +
>  	pre_div >>= 1;
>  	div--;
> 
> @@ -74,6 +77,12 @@ static inline void esdhc_set_clock(struct sdhci_host
> *host, unsigned int clock)
>  		| (pre_div << ESDHC_PREDIV_SHIFT));
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  	mdelay(1);
> +
> +	if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK) {
> +		host->timeout_clk = actual_clk / 1000;
> +		host->mmc->max_discard_to = (1 << 27) / host->timeout_clk;
> +	}
> +
>  out:
>  	host->clock = clock;
>  }
> --
> 1.7.0.4


