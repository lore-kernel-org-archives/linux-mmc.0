From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/9] mmc: meson-gx: improve meson_mmc_clk_set
Date: Wed, 01 Feb 2017 21:24:39 +0900
Message-ID: <92a17f7a-c197-d6ce-a255-0adf9030bb7e@samsung.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
 <CGME20170131210730epcas2p231e0ff8a05a2eb6223f1717d5929635d@epcas2p2.samsung.com>
 <daf8b18a-adf5-7dc1-7b3b-45db83af0af3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:58792 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbdBAMem (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2017 07:34:42 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OKP012XT3T4ID90@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 01 Feb 2017 21:24:40 +0900 (KST)
In-reply-to: <daf8b18a-adf5-7dc1-7b3b-45db83af0af3@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, linux-mmc@vger.kernel.org

On 02/01/2017 05:58 AM, Heiner Kallweit wrote:
> The following changes are quite small, therefore I combined them in
> one patch.
> 
> - ret doesn't need to be initialized with 0
> - use standard !clk_rate notation to check for a zero value
> - If clk_rate is zero we return here. Therefore all further checks
>   in this function for clk_rate != 0 are not needed.
> - switch from dev_warn to dev_err if the clock can't be set
> - If due to clock source and available divider values the requested
>   frequency isn't matched exactly (always the case if requested
>   frequency is 52 MHz), then just print the differing values as
>   debug message and not as warning.
> - Also remove ret from the message as it is always 0.
> - In the case of actual frequency not exactly matching the requested
>   one set mmc->actual_clock to the requested frequency.
>   So far mmc->actual_clock wasn't set at all in this case.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 36 +++++++++++++++++++-----------------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 38edc60d..529a4f22 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -179,7 +179,7 @@ struct sd_emmc_desc {
>  static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
>  {
>  	struct mmc_host *mmc = host->mmc;
> -	int ret = 0;
> +	int ret;
>  	u32 cfg;
>  
>  	if (clk_rate) {
> @@ -202,29 +202,31 @@ static int meson_mmc_clk_set(struct meson_host *host, unsigned long clk_rate)
>  	dev_dbg(host->dev, "change clock rate %u -> %lu\n",
>  		mmc->actual_clock, clk_rate);
>  
> -	if (clk_rate == 0) {
> +	if (!clk_rate) {
>  		mmc->actual_clock = 0;
>  		return 0;
>  	}
>  
>  	ret = clk_set_rate(host->cfg_div_clk, clk_rate);
> -	if (ret)
> -		dev_warn(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
> -			 clk_rate, ret);
> -	else if (clk_rate && clk_rate != clk_get_rate(host->cfg_div_clk))
> -		dev_warn(host->dev, "divider requested rate %lu != actual rate %lu: ret=%d\n",
> -			 clk_rate, clk_get_rate(host->cfg_div_clk), ret);
> -	else
> -		mmc->actual_clock = clk_rate;
> -
> -	/* (re)start clock, if non-zero */
> -	if (!ret && clk_rate) {
> -		cfg = readl(host->regs + SD_EMMC_CFG);
> -		cfg &= ~CFG_STOP_CLOCK;
> -		writel(cfg, host->regs + SD_EMMC_CFG);
> +	if (ret) {
> +		dev_err(host->dev, "Unable to set cfg_div_clk to %lu. ret=%d\n",
> +			clk_rate, ret);
> +		return ret;
>  	}
>  
> -	return ret;
> +	if (clk_rate != clk_get_rate(host->cfg_div_clk))
> +		dev_dbg(host->dev,
> +			"divider requested rate %lu != actual rate %lu\n",
> +			clk_rate, clk_get_rate(host->cfg_div_clk));
> +
> +	mmc->actual_clock = clk_rate;

debug message is described actual_rate as clk_get_rate()..
What is correct "actual_clock"?

Best Regards,
Jaehoon Chung

> +
> +	/* (re)start clock */
> +	cfg = readl(host->regs + SD_EMMC_CFG);
> +	cfg &= ~CFG_STOP_CLOCK;
> +	writel(cfg, host->regs + SD_EMMC_CFG);
> +
> +	return 0;
>  }
>  
>  /*
> 

