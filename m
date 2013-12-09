From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCHv2 1/3] mmc: dw_mmc: Enable the hold reg for certain speed
 modes
Date: Mon, 09 Dec 2013 10:24:51 +0900
Message-ID: <52A51BE3.9070407@samsung.com>
References: <1386386424-859-1-git-send-email-dinguyen@altera.com>
 <1386386424-859-2-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13040 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759563Ab3LIBYt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Dec 2013 20:24:49 -0500
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXI00AASMLC10B0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 09 Dec 2013 10:24:48 +0900 (KST)
In-reply-to: <1386386424-859-2-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com, dinh.linux@gmail.com, arnd@arndb.de, cjb@laptop.org, tgih.jun@samsung.com, heiko@sntech.de, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com
Cc: linux-mmc@vger.kernel.org

Hi Dinh,

I known there is IMPLEMENT_HOLD_REG[22] at HCON register.
It didn't affect with this register?

Best Regards,
Jaehoon Chung

On 12/07/2013 12:20 PM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> This patch will enable the SDMMC_CMD_USE_HOLD_REG bit when the slot is
> operating all timing modes, except for SDR50, DDR50, SDR104, and MMC_HS200.
> 
> According to the Synopsys databook :"To meet the relatively high Input Hold
> Time requirement for SDR12, SDR25, and other MMC speed modes, you should
> program bit[29]use_hold_Reg of the CMD register to 1'b1;"..."However, for
> the higher speed modes of SDR104, SDR50 and DDR50, you can meet the much
> smaller Input Hold Time requirement of 0.8ns by bypassing the Hold Register
> (Path A in Figure 10-8, programming CMD.use_hold_reg = 1'b0) and then adding
> delay elements on the output path as indicated.
> 
> Also, "Never set CMD.use_hold_reg = 1 and cclk_in_drv phase shift to 0 at the
> same time. This would add an extra one-cycle delay on the output path, resulting
> in incorrect behavior."
> 
> This information is taking from the v2.50a of the Synopsys Designware Cores
> Mobile Storage Host Databook.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
> v2: Add check for cclk_in_drv phase shift in conjunction with use_hold_reg.
> ---
>  drivers/mmc/host/dw_mmc.c  |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/dw_mmc.h |    3 +++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 4bce0de..9f5492b 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -279,6 +279,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  			cmdr |= SDMMC_CMD_DAT_WR;
>  	}
>  
> +	if (slot->host->use_hold_reg)
> +		cmdr |= SDMMC_CMD_USE_HOLD_REG;
> +
>  	if (drv_data && drv_data->prepare_command)
>  		drv_data->prepare_command(slot->host, &cmdr);
>  
> @@ -969,6 +972,24 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	mci_writel(slot->host, UHS_REG, regs);
>  	slot->host->timing = ios->timing;
>  
> +	/* Per Synopsys spec, use_hold_reg should be set for all modes except for
> +	 * high-speed SDR50, DDR50, SDR104, and MMC_HS200. However, use_hold_reg
> +	 * should be cleared if the cclk_in_drv is 0.
> +	 */
> +	switch (slot->host->timing) {
> +	case MMC_TIMING_UHS_SDR50:
> +	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_UHS_DDR50:
> +	case MMC_TIMING_MMC_HS200:
> +		slot->host->use_hold_reg = 0;
> +		break;
> +	default:
> +		slot->host->use_hold_reg = 1;
> +	}
> +
> +	if (slot->host->cclk_in_drv == 0)
> +		slot->host->use_hold_reg = 0;
> +
>  	/*
>  	 * Use mirror of ios->clock to prevent race with mmc
>  	 * core ios update when finding the minimum.
> @@ -2339,6 +2360,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	const struct dw_mci_drv_data *drv_data = host->drv_data;
>  	int idx, ret;
>  	u32 clock_frequency;
> +	int sdr_timing[2];
> +	int ddr_timing[2];
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata) {
> @@ -2389,6 +2412,25 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
>  		pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;
>  
> +	/* Check for the "samsung,dw-mshc-sdr-timing" and the
> +	 * "samsung,dw-mshc-ddr-timing" bindings as this will tell us if we
> +	 * can safely set the SDMMC_CMD_USE_HOLD_REG bit. The second paramater
> +	 * in these 2 bindings is the value of the cclk_in_drv. If cclk_in_drv
> +	 * is 0, we cannot set the SDMMC_CMD_USE_HOLD_REG bit. The default
> +	 * behavior will be to set cclk_in_drv, as some platforms do not have
> +	 * to set the sdr or ddr timing parameters.
> +	 */
> +	sdr_timing[1] = ddr_timing[1] = 1;
> +	of_property_read_u32_array(np,
> +			"samsung,dw-mshc-sdr-timing", sdr_timing, 2);
> +
> +	of_property_read_u32_array(np,
> +			"samsung,dw-mshc-ddr-timing", ddr_timing, 2);
> +
> +	pdata->cclk_in_drv = 1;
> +	if ((sdr_timing[1] == 0) || (ddr_timing[1] == 0))
> +		pdata->cclk_in_drv = 0;
> +
>  	return pdata;
>  }
>  
> @@ -2495,6 +2537,8 @@ int dw_mci_probe(struct dw_mci *host)
>  		goto err_regulator;
>  	}
>  
> +	host->cclk_in_drv = host->pdata->cclk_in_drv;
> +
>  	host->quirks = host->pdata->quirks;
>  
>  	spin_lock_init(&host->lock);
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 6ce7d2c..1da20ce 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -191,6 +191,8 @@ struct dw_mci {
>  	struct regulator	*vmmc;	/* Power regulator */
>  	unsigned long		irq_flags; /* IRQ flags */
>  	int			irq;
> +	bool			cclk_in_drv;
> +	bool			use_hold_reg;
>  };
>  
>  /* DMA ops for Internal/External DMAC interface */
> @@ -238,6 +240,7 @@ struct dw_mci_board {
>  	u32 caps;	/* Capabilities */
>  	u32 caps2;	/* More capabilities */
>  	u32 pm_caps;	/* PM capabilities */
> +	bool cclk_in_drv;	/*cclk_in_drv phase shift */
>  	/*
>  	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
>  	 * but note that this may not be reliable after a bootloader has used
> 

