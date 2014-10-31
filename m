From: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
Date: Fri, 31 Oct 2014 17:45:11 +0900
Message-ID: <54534C17.7050703@samsung.com>
References: <1414666240-16782-1-git-send-email-addy.ke@rock-chips.com>
 <1414727409-6765-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <1414727409-6765-1-git-send-email-addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, zhenfu.fang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, cf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, lintao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, chenfen-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyf-TNX95d0MmH7DzftRWevZcw@public.gmane.org, xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, huangtao-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zyw-TNX95d0MmH7DzftRWevZcw@public.gmane.org, yzq-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hj-TNX95d0MmH7DzftRWevZcw@public.gmane.org, kever.yang-TNX95d0MmH7DzftRWevZcw@public.gmane.org, zhangqing-TNX95d0MmH7DzftRWevZcw@public.gmane.org, hl-TNX95d0MmH7DzftRWevZcw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi, Addy.

On 10/31/2014 12:50 PM, Addy Ke wrote:
> The bit of sdio interrupt is 16 in designware implementation,
> but it is 24 in RK3288. This patch add sdio_id0 for the number
> of slot0 in the SDIO interrupt registers, which can be set in
> platform DT table, such as:
> - rockchip,sdio-interrupt-slot0 = <8>;

I have a question. (It's not important question)
You mentioned the sdio-irq bit used from 24 to 31, right?
Then what interrupts are used from 16 to 23 at RK3288? Just reserved?

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> Changes in v2:
> - rebase on http://git.linaro.org/git/people/ulf.hansson/mmc.git, next branch
> 
>  drivers/mmc/host/dw_mmc-rockchip.c | 13 +++++++++++++
>  drivers/mmc/host/dw_mmc.c          | 12 +++++++-----
>  drivers/mmc/host/dw_mmc.h          |  2 ++
>  include/linux/mmc/dw_mmc.h         |  3 +++
>  4 files changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index bbb4ec3..1cb3bc6 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -68,6 +68,18 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  	}
>  }
>  
> +static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
> +{
> +	struct device_node *np = host->dev->of_node;
> +	int sdio_id0;
> +
> +	if (!of_property_read_u32(np, "rockchip,sdio-interrupt-slot0",
> +				  &sdio_id0))
> +		host->sdio_id0 = sdio_id0;
> +
> +	return 0;
> +}
> +
>  static const struct dw_mci_drv_data rk2928_drv_data = {
>  	.prepare_command        = dw_mci_rockchip_prepare_command,
>  };
> @@ -76,6 +88,7 @@ static const struct dw_mci_drv_data rk3288_drv_data = {
>  	.prepare_command        = dw_mci_rockchip_prepare_command,
>  	.set_ios		= dw_mci_rk3288_set_ios,
>  	.setup_clock    = dw_mci_rk3288_setup_clock,
> +	.parse_dt	= dw_mci_rk3288_parse_dt,
>  };
>  
>  static const struct of_device_id dw_mci_rockchip_match[] = {
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index bb46b1b..a633b58 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -823,7 +823,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>  
>  		/* enable clock; only low power if no SDIO */
>  		clk_en_a = SDMMC_CLKEN_ENABLE << slot->id;
> -		if (!(mci_readl(host, INTMASK) & SDMMC_INT_SDIO(slot->id)))
> +		if (!(mci_readl(host, INTMASK) & SDMMC_INT_SDIO(slot->sdio_id)))
>  			clk_en_a |= SDMMC_CLKEN_LOW_PWR << slot->id;
>  		mci_writel(host, CLKENA, clk_en_a);
>  
> @@ -1184,10 +1184,10 @@ static void dw_mci_enable_sdio_irq(struct mmc_host *mmc, int enb)
>  		dw_mci_disable_low_power(slot);
>  
>  		mci_writel(host, INTMASK,
> -			   (int_mask | SDMMC_INT_SDIO(slot->id)));
> +			   (int_mask | SDMMC_INT_SDIO(slot->sdio_id)));
>  	} else {
>  		mci_writel(host, INTMASK,
> -			   (int_mask & ~SDMMC_INT_SDIO(slot->id)));
> +			   (int_mask & ~SDMMC_INT_SDIO(slot->sdio_id)));
>  	}
>  }
>  
> @@ -2056,8 +2056,9 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  		/* Handle SDIO Interrupts */
>  		for (i = 0; i < host->num_slots; i++) {
>  			struct dw_mci_slot *slot = host->slot[i];
> -			if (pending & SDMMC_INT_SDIO(i)) {
> -				mci_writel(host, RINTSTS, SDMMC_INT_SDIO(i));
> +			if (pending & SDMMC_INT_SDIO(slot->sdio_id)) {
> +				mci_writel(host, RINTSTS,
> +					   SDMMC_INT_SDIO(slot->sdio_id));
>  				mmc_signal_sdio_irq(slot->mmc);
>  			}
>  		}
> @@ -2145,6 +2146,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  
>  	slot = mmc_priv(mmc);
>  	slot->id = id;
> +	slot->sdio_id = host->sdio_id0 + id;
>  	slot->mmc = mmc;
>  	slot->host = host;
>  	host->slot[id] = slot;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 71d4995..0562f10 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -214,6 +214,7 @@ extern int dw_mci_resume(struct dw_mci *host);
>   *	with CONFIG_MMC_CLKGATE.
>   * @flags: Random state bits associated with the slot.
>   * @id: Number of this slot.
> + * @sdio_id: Number of this slot in the SDIO interrupt registers.
>   */
>  struct dw_mci_slot {
>  	struct mmc_host		*mmc;
> @@ -233,6 +234,7 @@ struct dw_mci_slot {
>  #define DW_MMC_CARD_PRESENT	0
>  #define DW_MMC_CARD_NEED_INIT	1
>  	int			id;
> +	int			sdio_id;
>  };
>  
>  struct dw_mci_tuning_data {
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 69d0814..72c319f 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -96,6 +96,7 @@ struct mmc_data;
>   * @quirks: Set of quirks that apply to specific versions of the IP.
>   * @irq_flags: The flags to be passed to request_irq.
>   * @irq: The irq value to be passed to request_irq.
> + * @sdio_id0: Number of slot0 in the SDIO interrupt registers.
>   *
>   * Locking
>   * =======
> @@ -191,6 +192,8 @@ struct dw_mci {
>  	bool			vqmmc_enabled;
>  	unsigned long		irq_flags; /* IRQ flags */
>  	int			irq;
> +
> +	int			sdio_id0;
>  };
>  
>  /* DMA ops for Internal/External DMAC interface */
> 

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
