From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: poll ESDHC_CLOCK_STABLE bit with
 udelay
Date: Wed, 26 Apr 2017 09:02:06 +0300
Message-ID: <9848f938-5474-c644-2183-5b2443bb0b8a@intel.com>
References: <1493174749-31003-1-git-send-email-yangbo.lu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1836 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1950748AbdDZGHu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 26 Apr 2017 02:07:50 -0400
In-Reply-To: <1493174749-31003-1-git-send-email-yangbo.lu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>

On 26/04/17 05:45, Yangbo Lu wrote:
> The loop to poll ESDHC_CLOCK_STABLE bit with mdelay would waste time
> because the time to stabilize is much less than 1 ms. This patch is
> to use udelay instead to avoid time wasting.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 7518360..77dfc59 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -445,7 +445,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  	struct sdhci_esdhc *esdhc = sdhci_pltfm_priv(pltfm_host);
>  	int pre_div = 1;
>  	int div = 1;
> -	u32 timeout;
> +	ktime_t timeout;
>  	u32 temp;
>  
>  	host->mmc->actual_clock = 0;
> @@ -489,15 +489,14 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
>  
>  	/* Wait max 20 ms */
> -	timeout = 20;
> +	timeout = ktime_add_ms(ktime_get(), 20);
>  	while (!(sdhci_readl(host, ESDHC_PRSSTAT) & ESDHC_CLOCK_STABLE)) {
> -		if (timeout == 0) {
> +		if (ktime_after(ktime_get(), timeout)) {
>  			pr_err("%s: Internal clock never stabilised.\n",
>  				mmc_hostname(host->mmc));
>  			return;
>  		}
> -		timeout--;
> -		mdelay(1);
> +		udelay(10);
>  	}
>  
>  	temp |= ESDHC_CLOCK_SDCLKEN;
> 

