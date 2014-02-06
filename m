From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [RESEND PATCHv4] mmc: dw_mmc: Enable the hold reg for certain
 speed modes
Date: Thu, 06 Feb 2014 21:14:14 +0900
Message-ID: <002b01cf2334$f3abd530$db037f90$%jun@samsung.com>
References: <1391556020-8628-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64563 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbaBFMOR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Feb 2014 07:14:17 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0K009GNPZRNYC0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 06 Feb 2014 21:14:15 +0900 (KST)
In-reply-to: <1391556020-8628-1-git-send-email-dinguyen@altera.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com, dinh.linux@gmail.com, chris@printf.net, jh80.chung@samsung.com, linux-mmc@vger.kernel.org
Cc: arnd@arndb.de, zhangfei.gao@linaro.org, heiko@sntech.de

Hi Dinh,

Do you have any idea from last Jaehoon's comment?

On Wed, February 05, 2014, Dinh Nguyen wrote:
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
> This patch also checks the IHR(Implement Hold Register) in the HCON register.
> 
> This information is taking from the v2.50a of the Synopsys Designware Cores
> Mobile Storage Host Databook.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v4: use_hold_reg should be set for all modes when cclk_in_drv is non-zero.
> v3: Read the IHR(Implement Hold Register) in the HCON
> v2: Add check for cclk_in_drv phase shift in conjunction with use_hold_reg.
> ---
>  drivers/mmc/host/dw_mmc.c  |   52 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/dw_mmc.h  |    4 ++++
>  include/linux/mmc/dw_mmc.h |    3 +++
>  3 files changed, 59 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 55cd110..3614667 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -280,6 +280,9 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>  			cmdr |= SDMMC_CMD_DAT_WR;
>  	}
> 
> +	if (slot->host->use_hold_reg)
> +		cmdr |= SDMMC_CMD_USE_HOLD_REG;
> +
>  	if (drv_data && drv_data->prepare_command)
>  		drv_data->prepare_command(slot->host, &cmdr);
> 
> @@ -970,6 +973,25 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  	mci_writel(slot->host, UHS_REG, regs);
>  	slot->host->timing = ios->timing;
> 
> +	/* Per Synopsys spec, use_hold_reg should be set for all modes except for
> +	 * high-speed SDR50, DDR50, SDR104, and MMC_HS200. However, use_hold_reg
> +	 * should be cleared if the cclk_in_drv is 0. use_hold_reg should be set
> +	 * for all modes if cclk_in_drv is set.
> +	 */
> +	slot->host->use_hold_reg = 1;
> +	switch (slot->host->timing) {
> +	case MMC_TIMING_UHS_SDR50:
> +	case MMC_TIMING_UHS_SDR104:
> +	case MMC_TIMING_UHS_DDR50:
> +	case MMC_TIMING_MMC_HS200:
> +		if (slot->host->pdata->cclk_in_drv == 0)
'clk_in_drv value' is being shared in all mode after setting is done at probe().
Certainly cclk_in_drv will be depended on each mode.

> +			slot->host->use_hold_reg = 0;
> +		break;
> +	}
> +
> +	if (slot->host->can_use_hold_reg == 0)
> +		slot->host->use_hold_reg = 0;
'can_use_hold_reg' is already decided from sdr or ddr timing at probe().
Assuming that current requested mode is HS200, it's incorrect.
Although 'use_hold_reg' is set to '1' above, use_hold_reg can be reset to '0' if can_use_hold_reg is '0'.

> +
>  	/*
>  	 * Use mirror of ios->clock to prevent race with mmc
>  	 * core ios update when finding the minimum.
> @@ -2364,6 +2386,8 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	const struct dw_mci_drv_data *drv_data = host->drv_data;
>  	int idx, ret;
>  	u32 clock_frequency;
> +	int sdr_timing[2];
> +	int ddr_timing[2];
> 
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata) {
> @@ -2417,6 +2441,25 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>  	if (of_get_property(np, "cd-inverted", NULL))
>  		pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
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

As I mentioned before, samsung,dw-mshc-sdr-timing & samsung,dw-mshc-ddr-timing will be extended with new cell element.
For example, samsung,dw-mshc-sdr-timing = <0 4 3>;
Can it be acceptable to socfpga and other SoC?
I'm still thinking of specific implementation for variant SoC.
If you have a good idea, please let me know.

Thanks,
Seungwon Jeon

> +
> +	pdata->cclk_in_drv = 1;
> +	if ((sdr_timing[1] == 0) || (ddr_timing[1] == 0))
> +		pdata->cclk_in_drv = 0;
> +
>  	return pdata;
>  }
> 
> @@ -2523,6 +2566,15 @@ int dw_mci_probe(struct dw_mci *host)
>  		goto err_regulator;
>  	}
> 
> +	/* Check to see if the HOLD REG is implemented. */
> +	host->can_use_hold_reg = (mci_readl(host, HCON) & SDMMC_HCON_IHR) >> 22;
> +
> +	/* Can only use the HOLD REG is both conditions are true:
> +	 * Hardware has implemented HOLD_REG and
> +	 * cclk_in_drv is non-zero.
> +	 */
> +	host->can_use_hold_reg &= host->pdata->cclk_in_drv;
> +
>  	host->quirks = host->pdata->quirks;
> 
>  	spin_lock_init(&host->lock);
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 6bf24ab..dfd05c9 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -145,6 +145,10 @@
>  #define SDMMC_IDMAC_ENABLE		BIT(7)
>  #define SDMMC_IDMAC_FB			BIT(1)
>  #define SDMMC_IDMAC_SWRESET		BIT(0)
> +
> +/* Hardware Configuration(HCON) register */
> +#define SDMMC_HCON_IHR			BIT(22)
> +
>  /* Version ID register define */
>  #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
>  /* Card read threshold */
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 6ce7d2c..2b5b8bf 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -191,6 +191,8 @@ struct dw_mci {
>  	struct regulator	*vmmc;	/* Power regulator */
>  	unsigned long		irq_flags; /* IRQ flags */
>  	int			irq;
> +	u32			can_use_hold_reg;
> +	bool			use_hold_reg;
>  };
> 
>  /* DMA ops for Internal/External DMAC interface */
> @@ -238,6 +240,7 @@ struct dw_mci_board {
>  	u32 caps;	/* Capabilities */
>  	u32 caps2;	/* More capabilities */
>  	u32 pm_caps;	/* PM capabilities */
> +	u32 cclk_in_drv;	/*cclk_in_drv phase shift */
>  	/*
>  	 * Override fifo depth. If 0, autodetect it from the FIFOTH register,
>  	 * but note that this may not be reliable after a bootloader has used
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

