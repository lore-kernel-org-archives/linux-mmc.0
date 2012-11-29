From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH 1/2 v4] Powerpc/eSDHC: Calculate the applicable mmc erase
 timeout value
Date: Wed, 28 Nov 2012 20:20:09 -0800
Message-ID: <20121129042009.GB31883@lizard>
References: <1354161616-15486-1-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:43961 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab2K2EXc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Nov 2012 23:23:32 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so7309132pad.19
        for <linux-mmc@vger.kernel.org>; Wed, 28 Nov 2012 20:23:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1354161616-15486-1-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>

On Thu, Nov 29, 2012 at 12:00:16PM +0800, Haijun Zhang wrote:
> As large area erase needs long time usually a few minutes,
> So we use max_discard_to to limit the size one request can
> issue to avoid timeout. As our controller had the quirk
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK so we need to assign the
> timeout_clk and max_discard_to according to the max_dtr which
> can be read after the card had setup and decoded, As esdhc-imx
> also use this func and this quirk so this patch will also work
> on esdhci-imx, but this patch only test on powerpc platform, if
> there are any negative impact on esdhc-imx please let me know.
> 
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> CC: Anton Vorontsov <cbouatmailru@gmail.com>
> ---
> changes for v4:
> 	- Apply the timeout clk after the card setup and reuse quirk
> changes for v3:
> 	- Add an empty line
> 
>  drivers/mmc/host/sdhci-esdhc.h |   10 +++++++++-
>  1 files changed, 9 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
> index d25f9ab..49bc47c 100644
> --- a/drivers/mmc/host/sdhci-esdhc.h
> +++ b/drivers/mmc/host/sdhci-esdhc.h
> @@ -46,7 +46,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
>  {
>  	int pre_div = 2;
>  	int div = 1;
> -	u32 temp;
> +	u32 temp, actual_clk;

These two variables unrelated, please put them on their own lines.

Thanks,

>  
>  	if (clock == 0)
>  		goto out;
> @@ -65,6 +65,8 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
>  	dev_dbg(mmc_dev(host->mmc), "desired SD clock: %d, actual: %d\n",
>  		clock, host->max_clk / pre_div / div);
>  
> +	actual_clk = host->max_clk / pre_div / div;
> +
>  	pre_div >>= 1;
>  	div--;
>  
> @@ -74,6 +76,12 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
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
