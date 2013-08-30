From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: Check if clk_set_rate() succeeds
Date: Fri, 30 Aug 2013 17:21:44 +0900
Message-ID: <52205618.70107@samsung.com>
References: <1377792936-775-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:53751 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754543Ab3H3IVc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Aug 2013 04:21:32 -0400
In-reply-to: <1377792936-775-1-git-send-email-broonie@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 08/30/2013 01:15 AM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> It is possible that we may fail to set the clock rate, if we do so then
> log the failure and don't bother reprogramming the IP.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/mmc/host/sdhci-s3c.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 926aaf6..d10de3f 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -295,6 +295,7 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  	struct device *dev = &ourhost->pdev->dev;
>  	unsigned long timeout;
>  	u16 clk = 0;
> +	int ret;
>  
>  	/* don't bother if the clock is going off */
>  	if (clock == 0)
> @@ -302,7 +303,12 @@ static void sdhci_cmu_set_clock(struct sdhci_host *host, unsigned int clock)
>  
>  	sdhci_s3c_set_clock(host, clock);
>  
> -	clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
> +	ret = clk_set_rate(ourhost->clk_bus[ourhost->cur_clk], clock);
> +	if (ret != 0) {
> +		dev_err(dev, "%s: failed to set clock rate %uHz\n",
> +			mmc_hostname(host->mmc), clock);
> +		return;
> +	}
>  
>  	host->clock = clock;
>  
> 

