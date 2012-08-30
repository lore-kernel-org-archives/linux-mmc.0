From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 4/9] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Thu, 30 Aug 2012 17:48:39 +0900
Message-ID: <503F28E7.1060608@samsung.com>
References: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
 <1346237295-7116-5-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:51630 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752702Ab2H3Iss (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Aug 2012 04:48:48 -0400
In-reply-to: <1346237295-7116-5-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, tgih.jun@samsung.com, patches@linaro.org

Hi Thomas,

On 08/29/2012 07:48 PM, Thomas Abraham wrote:
> Some platforms allow for clock gating and control of bus interface unit clock
> and card interface unit clock. Add support for clock lookup of optional biu
> and ciu clocks for clock gating and clock speed determination.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> Acked-by: Will Newton <will.newton@imgtec.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |   42 +++++++++++++++++++++++++++++++++++++++---
>  include/linux/mmc/dw_mmc.h |    4 ++++
>  2 files changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 227c42e..90c7c7b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1960,18 +1960,38 @@ int dw_mci_probe(struct dw_mci *host)
>  		return -ENODEV;
>  	}
>  
> -	if (!host->pdata->bus_hz) {
> +	host->biu_clk = clk_get(host->dev, "biu");
> +	if (IS_ERR(host->biu_clk))
> +		dev_dbg(host->dev, "biu clock not available\n");
> +	else
> +		clk_prepare_enable(host->biu_clk);
biu is clock for bus interface?
if didn't get "biu_clk" or didn't clk_prepare_enable(), then can we initialize the card?
> +
> +	host->ciu_clk = clk_get(host->dev, "ciu");
> +	if (IS_ERR(host->ciu_clk))
> +		dev_dbg(host->dev, "ciu clock not available\n");
> +	else
> +		clk_prepare_enable(host->ciu_clk);
> +
> +	if (IS_ERR(host->ciu_clk))
> +		host->bus_hz = host->pdata->bus_hz;
> +	else
> +		host->bus_hz = clk_get_rate(host->ciu_clk);
if clk_get_rate() is incorrect value(ex,400MHz),
then mmc->f_min value is too high.
because mmc->f_min is assigned to DIV_ROUND_UP(host->bus_hz, 510) into dw_mc_init_slot.
Do you have any opinion for solving this?
> +
> +	if (!host->bus_hz) {
>  		dev_err(host->dev,
>  			"Platform data must supply bus speed\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto err_clk;
>  	}
>  
> -	host->bus_hz = host->pdata->bus_hz;
>  	host->quirks = host->pdata->quirks;
>  
>  	spin_lock_init(&host->lock);
>  	INIT_LIST_HEAD(&host->queue);
>  
> +	host->dma_ops = host->pdata->dma_ops;
> +	dw_mci_init_dma(host);
> +
>  	/*
>  	 * Get the host data width - this assumes that HCON has been set with
>  	 * the correct values.
> @@ -2116,6 +2136,16 @@ err_dmaunmap:
>  		regulator_disable(host->vmmc);
>  		regulator_put(host->vmmc);
>  	}
> +
> +err_clk:
> +	if (!IS_ERR(host->ciu_clk)) {
> +		clk_disable_unprepare(host->ciu_clk);
> +		clk_put(host->ciu_clk);
> +	}
> +	if (!IS_ERR(host->biu_clk)) {
> +		clk_disable_unprepare(host->biu_clk);
> +		clk_put(host->biu_clk);
> +	}
>  	return ret;
>  }
>  EXPORT_SYMBOL(dw_mci_probe);
> @@ -2149,6 +2179,12 @@ void dw_mci_remove(struct dw_mci *host)
>  		regulator_put(host->vmmc);
>  	}
>  
> +	if (!IS_ERR(host->ciu_clk))
> +		clk_disable_unprepare(host->ciu_clk);
> +	if (!IS_ERR(host->biu_clk))
> +		clk_disable_unprepare(host->biu_clk);
> +	clk_put(host->ciu_clk);
> +	clk_put(host->biu_clk);
>  }
>  EXPORT_SYMBOL(dw_mci_remove);
>  
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index a37a573..787ad56 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -78,6 +78,8 @@ struct mmc_data;
>   * @data_offset: Set the offset of DATA register according to VERID.
>   * @dev: Device associated with the MMC controller.
>   * @pdata: Platform data associated with the MMC controller.
> + * @biu_clk: Pointer to bus interface unit clock instance.
> + * @ciu_clk: Pointer to card interface unit clock instance.
>   * @slot: Slots sharing this MMC controller.
>   * @fifo_depth: depth of FIFO.
>   * @data_shift: log2 of FIFO item size.
> @@ -158,6 +160,8 @@ struct dw_mci {
>  	u16			data_offset;
>  	struct device		*dev;
>  	struct dw_mci_board	*pdata;
> +	struct clk		*biu_clk;
> +	struct clk		*ciu_clk;
>  	struct dw_mci_slot	*slot[MAX_MCI_SLOTS];
>  
>  	/* FIFO push and pull */
> 

