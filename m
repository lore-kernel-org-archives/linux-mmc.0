From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH v2 1/4] mmc: dw_mmc: add runtime PM callback
Date: Fri, 07 Oct 2016 13:12:54 +0900
Message-ID: <2dd84d82-a14b-7d5e-80f0-89e6c0b1aaae@samsung.com>
References: <1475225317-2815-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160930084627epcas1p182ccca03bf63d4cd072e061ca5800510@epcas1p1.samsung.com>
 <1475225317-2815-2-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47117 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbcJGEM5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2016 00:12:57 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OEN00CE0T1C4B70@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 07 Oct 2016 13:12:55 +0900 (KST)
In-reply-to: <1475225317-2815-2-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-rockchip@lists.infradead.org

Hi Shawn,

On 09/30/2016 05:48 PM, Shawn Lin wrote:
> This patch add dw_mci_runtime_suspend/resume interfaces
> and expose it to dw_mci variant driver to support runtime
> PM.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
>  drivers/mmc/host/dw_mmc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/mmc/host/dw_mmc.h |  4 +++-
>  2 files changed, 61 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 4fcbc40..54b860e 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3266,7 +3266,7 @@ EXPORT_SYMBOL(dw_mci_remove);
>  
>  
>  
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM
>  /*
>   * TODO: we should probably disable the clock to the card in the suspend path.
>   */
> @@ -3324,7 +3324,63 @@ int dw_mci_resume(struct dw_mci *host)
>  	return 0;
>  }
>  EXPORT_SYMBOL(dw_mci_resume);
> -#endif /* CONFIG_PM_SLEEP */
> +
> +int dw_mci_runtime_suspend(struct dw_mci *host)
> +{
> +	printk("dw_mci_runtime_suspend\n");

Maybe I think you will remove this..if you send the patch, not RFC.

> +
> +	if (host->use_dma && host->dma_ops->exit)
> +		host->dma_ops->exit(host);

Can just call dw_mci_suspend()

> +
> +	clk_disable_unprepare(host->ciu_clk);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(dw_mci_runtime_suspend);
> +
> +int dw_mci_runtime_resume(struct dw_mci *host)
> +{
> +	int ret = 0;
> +	int i;

Can make one line.

> +
> +	printk("dw_mci_runtime_resume\n");
> +
> +	ret = clk_prepare_enable(host->ciu_clk);
> +	if (ret)
> +		return ret;
> +
> +	if (host->use_dma && host->dma_ops->init)
> +		host->dma_ops->init(host);
> +
> +	mci_writel(host, FIFOTH, host->fifoth_val);
> +	host->prev_blksz = 0;
> +
> +	mci_writel(host, TMOUT, 0xFFFFFFFF);
> +	mci_writel(host, RINTSTS, 0xFFFFFFFF);
> +	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE |
> +				  SDMMC_INT_DATA_OVER |
> +				  SDMMC_INT_TXDR | SDMMC_INT_RXDR |
> +				  DW_MCI_ERROR_FLAGS);
> +	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
> +
> +	for (i = 0; i < host->num_slots; i++) {
> +		struct dw_mci_slot *slot = host->slot[i];
> +
> +		if (!slot)
> +			continue;
> +
> +		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
> +			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
> +			dw_mci_setup_bus(slot, true);
> +		}
> +	}
> +
> +	dw_mci_enable_cd(host);

Some part of this function can be reused with codes in dw_mci_resume().

Best Regards,
Jaehoon Chung

> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(dw_mci_runtime_resume);
> +#endif /* CONFIG_PM */
>  
>  static int __init dw_mci_init(void)
>  {
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index e8cd2de..baa7261 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -234,9 +234,11 @@
>  
>  extern int dw_mci_probe(struct dw_mci *host);
>  extern void dw_mci_remove(struct dw_mci *host);
> -#ifdef CONFIG_PM_SLEEP
> +#ifdef CONFIG_PM
>  extern int dw_mci_suspend(struct dw_mci *host);
>  extern int dw_mci_resume(struct dw_mci *host);
> +extern int dw_mci_runtime_suspend(struct dw_mci *host);
> +extern int dw_mci_runtime_resume(struct dw_mci *host);
>  #endif
>  
>  /**
> 

