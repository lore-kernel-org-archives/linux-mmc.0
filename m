From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH v2 2/5] mmc: dw-mmc: add the platdata related with clock
Date: Tue, 4 Sep 2012 10:58:04 +0100
Message-ID: <5045D0AC.5020907@imgtec.com>
References: <503C797E.9010004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:43885 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab2IDKOU (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Sep 2012 06:14:20 -0400
In-Reply-To: <503C797E.9010004@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>

Hi,

On 28/08/12 08:55, Jaehoon Chung wrote:
> Some SoC need to set the clock-phase shift.
> So Add the callback function into platdata for using phase-shift
> 
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c  |    3 +++
>  include/linux/mmc/dw_mmc.h |    8 ++++++++
>  2 files changed, 11 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index e30d3ed..437fdf8 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -821,6 +821,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  
>  	mci_writel(slot->host, UHS_REG, regs);
>  
> +	if (slot->host->pdata->set_clk_drv_sample)
> +		slot->host->pdata->set_clk_drv_sample(slot->host, ios);
> +
>  	if (ios->clock) {
>  		/*
>  		 * Use mirror of ios->clock to prevent race with mmc
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 7a7ebd3..f20979c 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -229,6 +229,9 @@ struct dw_mci_board {
>  	 */
>  	unsigned int fifo_depth;
>  
> +	u32 ddr_timing;		/* DDR clock phase timing value */
> +	u32 sdr_timing;		/* SDR clock phase timing value */
> +

These don't appear to be used. Are they meant to be there?

>  	/* delay in mS before detecting cards after interrupt */
>  	u32 detect_delay_ms;
>  
> @@ -249,6 +252,11 @@ struct dw_mci_board {
>  	struct dw_mci_dma_ops *dma_ops;
>  	struct dma_pdata *data;
>  	struct block_settings *blk_settings;
> +
> +	int (*get_clk_drv)(struct dw_mci *);
> +	int (*get_clk_sample)(struct dw_mci *);

same with these two functions?

Thanks
James

> +	void (*set_clk_drv_sample)(struct dw_mci *host, struct mmc_ios *ios);
> +
>  };
>  
>  #endif /* LINUX_MMC_DW_MMC_H */
> 

