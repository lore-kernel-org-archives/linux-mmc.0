From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 3/5] mmc: dw-mmc: add the platdata related with clock
Date: Thu, 23 Aug 2012 13:10:54 +0100
Message-ID: <CAFbHwiST0fgaEuX8sT6+aHGK2YxST1YFMSzDd7CE0KPYjwVN1w@mail.gmail.com>
References: <503614A6.1010706@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:63641 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789Ab2HWMKz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 08:10:55 -0400
Received: by qaas11 with SMTP id s11so425420qaa.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Aug 2012 05:10:54 -0700 (PDT)
In-Reply-To: <503614A6.1010706@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:

Hi Jaehoon,

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
> index 8bef3c2..feafa2d 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -824,6 +824,9 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>
>         mci_writel(slot->host, UHS_REG, regs);
>
> +       if (slot->host->pdata->set_clk_drv_sample)
> +               slot->host->pdata->set_clk_drv_sample(slot->host, ios);
> +
>         if (ios->clock) {
>                 /*
>                  * Use mirror of ios->clock to prevent race with mmc
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 7a7ebd3..f20979c 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -229,6 +229,9 @@ struct dw_mci_board {
>          */
>         unsigned int fifo_depth;
>
> +       u32 ddr_timing;         /* DDR clock phase timing value */
> +       u32 sdr_timing;         /* SDR clock phase timing value */
> +

These members...

>         /* delay in mS before detecting cards after interrupt */
>         u32 detect_delay_ms;
>
> @@ -249,6 +252,11 @@ struct dw_mci_board {
>         struct dw_mci_dma_ops *dma_ops;
>         struct dma_pdata *data;
>         struct block_settings *blk_settings;
> +
> +       int (*get_clk_drv)(struct dw_mci *);
> +       int (*get_clk_sample)(struct dw_mci *);

...and these members do not seem to be used in the rest of this patch.
Should they be included?

> +       void (*set_clk_drv_sample)(struct dw_mci *host, struct mmc_ios *ios);
> +
>  };
>
>  #endif /* LINUX_MMC_DW_MMC_H */
> --
> 1.7.4.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
