From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/4] mmc: dw_mmc: add setup_clk for init hook
Date: Thu, 04 Feb 2016 15:04:58 +0900
Message-ID: <56B2EA0A.5020208@samsung.com>
References: <1453944616-16224-1-git-send-email-shawn.lin@rock-chips.com>
 <1453944664-16874-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:36099 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbcBDGFA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Feb 2016 01:05:00 -0500
In-reply-to: <1453944664-16874-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Shawn.

On 01/28/2016 10:31 AM, Shawn Lin wrote:
> We add this new argument into init hook for
> variant drivers to decide whether to do clock
> related stuff inside the hook.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
>  drivers/mmc/host/dw_mmc-exynos.c   | 4 ++--
>  drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
>  drivers/mmc/host/dw_mmc.c          | 2 +-
>  drivers/mmc/host/dw_mmc.h          | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 3a7e835..edaa117 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -91,7 +91,7 @@ static inline u8 dw_mci_exynos_get_ciu_div(struct dw_mci *host)
>  		return SDMMC_CLKSEL_GET_DIV(mci_readl(host, CLKSEL)) + 1;
>  }
>  
> -static int dw_mci_exynos_priv_init(struct dw_mci *host)
> +static int dw_mci_exynos_priv_init(struct dw_mci *host, bool setup_clk)
>  {

"bool setup_clk" is made because of exynos SoC, right?
Hmm. I'm checking how we can control without "setup_clk". Waiting for this.

Thanks for removing the hooks. :)

Best Regards,
Jaehoon Chung

>  	struct dw_mci_exynos_priv_data *priv = host->priv;
>  
> @@ -159,7 +159,7 @@ static int dw_mci_exynos_resume(struct device *dev)
>  {
>  	struct dw_mci *host = dev_get_drvdata(dev);
>  
> -	dw_mci_exynos_priv_init(host);
> +	dw_mci_exynos_priv_init(host, false);
>  	return dw_mci_resume(host);
>  }
>  
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index 9934503..885c801 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -221,7 +221,7 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
>  	return 0;
>  }
>  
> -static int dw_mci_rockchip_init(struct dw_mci *host)
> +static int dw_mci_rockchip_init(struct dw_mci *host, bool setup_clk)
>  {
>  	/* It is slot 8 on Rockchip SoCs */
>  	host->sdio_id0 = 8;
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 7128351..1d27a2b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2995,7 +2995,7 @@ int dw_mci_probe(struct dw_mci *host)
>  	}
>  
>  	if (drv_data && drv_data->init) {
> -		ret = drv_data->init(host);
> +		ret = drv_data->init(host, true);
>  		if (ret) {
>  			dev_err(host->dev,
>  				"implementation specific init failed\n");
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index f695b58..1a9492e 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -285,7 +285,7 @@ struct dw_mci_slot {
>   */
>  struct dw_mci_drv_data {
>  	unsigned long	*caps;
> -	int		(*init)(struct dw_mci *host);
> +	int		(*init)(struct dw_mci *host, bool setup_clk);
>  	int		(*setup_clock)(struct dw_mci *host);
>  	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
>  	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
> 

