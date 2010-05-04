From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 3/5] OMAP4-HSMMC: Adding MMC-TWL regulator changes
Date: Tue, 4 May 2010 17:11:23 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1005041704390.20898@utopia.booyaka.com>
References: <35156.10.24.255.17.1272988897.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <35156.10.24.255.17.1272988897.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com, jarkko.lavinen@nokia.com, rmk@arm.linux.org.uk
List-Id: linux-mmc@vger.kernel.org

Hello,

On Tue, 4 May 2010, kishore kadiyala wrote:

> This patch adds PBIAS Configuration during POWER ON and OFF.
> Also it adds MMC1 Card detect configuration on Phoenix
> 
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/hsmmc.c               |  121 ++++++++++++++++++++++++++---
>  arch/arm/plat-omap/include/plat/control.h |   17 ++++
>  include/linux/i2c/twl.h                   |   42 +++++++++-
>  3 files changed, 166 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/hsmmc.c b/arch/arm/mach-omap2/hsmmc.c
> index f5ca16c..a73f011 100644
> --- a/arch/arm/mach-omap2/hsmmc.c
> +++ b/arch/arm/mach-omap2/hsmmc.c
> @@ -14,6 +14,7 @@
>  #include <linux/string.h>
>  #include <linux/delay.h>
>  #include <linux/i2c/twl.h>
> +#include <linux/platform_device.h>
>  #include <mach/hardware.h>
>  #include <plat/control.h>
>  #include <plat/mmc.h>
> @@ -25,6 +26,7 @@
> 
>  static u16 control_pbias_offset;
>  static u16 control_devconf1_offset;
> +static u16 control_mmc1;
> 
>  #define HSMMC_NAME_LEN	9
> 
> @@ -43,7 +45,7 @@ static int hsmmc_get_context_loss(struct device *dev)
>  #define hsmmc_get_context_loss NULL
>  #endif
> 
> -static void hsmmc1_before_set_reg(struct device *dev, int slot,
> +static void omap_hsmmc1_before_set_reg(struct device *dev, int slot,
>  				  int power_on, int vdd)
>  {
>  	u32 reg, prog_io;
> @@ -96,7 +98,7 @@ static void hsmmc1_before_set_reg(struct device *dev, int slot,
>  	}
>  }
> 
> -static void hsmmc1_after_set_reg(struct device *dev, int slot,
> +static void omap_hsmmc1_after_set_reg(struct device *dev, int slot,
>  				 int power_on, int vdd)
>  {
>  	u32 reg;
> @@ -120,6 +122,61 @@ static void hsmmc1_after_set_reg(struct device *dev, int slot,
>  	}
>  }
> 
> +static void omap4_hsmmc1_before_set_reg(struct device *dev, int slot,
> +				  int power_on, int vdd)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Assume we power both OMAP VMMC1 (for CMD, CLK, DAT0..3) and the
> +	 * card with Vcc regulator (from twl4030 or whatever).  OMAP has both
> +	 * 1.8V and 3.0V modes, controlled by the PBIAS register.
> +	 *
> +	 * In 8-bit modes, OMAP VMMC1A (for DAT4..7) needs a supply, which
> +	 * is most naturally TWL VSIM; those pins also use PBIAS.
> +	 *
> +	 * FIXME handle VMMC1A as needed ...
> +	 */
> +	if (power_on) {
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ | OMAP4_MMC1_PWRDNZ);
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	} else {
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		reg &= ~(OMAP4_MMC1_PBIASLITE_PWRDNZ | OMAP4_MMC1_PWRDNZ);
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	}

If the code in both branches of the conditional is identical, what's the 
point of keeping the conditional?

> +}
> +
> +static void omap4_hsmmc1_after_set_reg(struct device *dev, int slot,
> +				 int power_on, int vdd)
> +{
> +	u32 reg;
> +
> +	/* 100ms delay required for PBIAS configuration */
> +	msleep(100);
> +
> +	if (power_on) {
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		reg |= OMAP4_MMC1_PBIASLITE_PWRDNZ;
> +		if ((1 << vdd) <= MMC_VDD_165_195) {
> +			reg &= ~OMAP4_MMC1_PBIASLITE_VMODE;
> +			reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +						OMAP4_MMC1_PWRDNZ);
> +		} else {
> +			reg |= (OMAP4_MMC1_PBIASLITE_VMODE |
> +				OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +					OMAP4_MMC1_PWRDNZ);
> +		}
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	} else {
> +		reg = omap_ctrl_readl(control_pbias_offset);
> +		 reg |= (OMAP4_MMC1_PBIASLITE_PWRDNZ |
> +			OMAP4_MMC1_PBIASLITE_VMODE | OMAP4_MMC1_PWRDNZ);
> +		omap_ctrl_writel(reg, control_pbias_offset);
> +	}
> +}
> +
>  static void hsmmc23_before_set_reg(struct device *dev, int slot,
>  				   int power_on, int vdd)
>  {
> @@ -140,6 +197,24 @@ static void hsmmc23_before_set_reg(struct device *dev, int slot,
>  	}
>  }
> 
> +static int mmc_twl_late_init(struct device *dev)
> +{
> +	int ret = 0;
> +	struct platform_device *pdev = container_of(dev,
> +					struct platform_device, dev);
> +
> +	if (cpu_is_omap44xx()) {
> +		/* MMC1 Card detect Configuration */
> +		if (pdev->id == 0) {
> +			ret = omap4_hsmmc1_card_detect_config();
> +			if (ret < 0)
> +				pr_err("Unable to configure"
> +					"Card detect for MMC1\n");
> +		}
> +	}
> +	return ret;
> +}
> +
>  static struct omap_mmc_platform_data *hsmmc_data[OMAP34XX_NR_MMC] __initdata;
> 
>  void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
> @@ -147,13 +222,28 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info
>  	struct omap2_hsmmc_info *c;
>  	int nr_hsmmc = ARRAY_SIZE(hsmmc_data);
>  	int i;
> +	u32 reg;
> 
> -	if (cpu_is_omap2430()) {
> -		control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> -		control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
> +	if (!cpu_is_omap44xx()) {
> +		if (cpu_is_omap2430()) {
> +			control_pbias_offset = OMAP243X_CONTROL_PBIAS_LITE;
> +			control_devconf1_offset = OMAP243X_CONTROL_DEVCONF1;
> +		} else {
> +			control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
> +			control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
> +		}
>  	} else {
> -		control_pbias_offset = OMAP343X_CONTROL_PBIAS_LITE;
> -		control_devconf1_offset = OMAP343X_CONTROL_DEVCONF1;
> +		control_pbias_offset = OMAP44XX_CONTROL_PBIAS_LITE;
> +		control_mmc1 = OMAP44XX_CONTROL_MMC1;
> +		reg = omap_ctrl_readl(control_mmc1);
> +		reg |= (OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0 |
> +			OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1);
> +		reg &= ~(OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2 |
> +			OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3);
> +		reg |= (OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL |
> +			OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL |
> +			OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL);
> +		omap_ctrl_writel(reg, control_mmc1);
>  	}
> 
>  	for (c = controllers; c->mmc; c++) {
> @@ -186,6 +276,7 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info *controllers)
>  		mmc->slots[0].wires = c->wires;
>  		mmc->slots[0].internal_clock = !c->ext_clock;
>  		mmc->dma_mask = 0xffffffff;
> +		mmc->init = mmc_twl_late_init;
> 
>  		mmc->get_context_loss_count = hsmmc_get_context_loss;
> 
> @@ -220,10 +311,18 @@ void __init omap2_hsmmc_init(struct omap2_hsmmc_info
> 
>  		switch (c->mmc) {
>  		case 1:
> -			/* on-chip level shifting via PBIAS0/PBIAS1 */
> -			mmc->slots[0].before_set_reg = hsmmc1_before_set_reg;
> -			mmc->slots[0].after_set_reg = hsmmc1_after_set_reg;
> -
> +			if (cpu_is_omap44xx()) {
> +				/* on-chip level shifting via PBIAS0/PBIAS1 */
> +				mmc->slots[0].before_set_reg =
> +						omap4_hsmmc1_before_set_reg;
> +				mmc->slots[0].after_set_reg =
> +						omap4_hsmmc1_after_set_reg;
> +			} else {
> +				mmc->slots[0].before_set_reg =
> +						omap_hsmmc1_before_set_reg;
> +				mmc->slots[0].after_set_reg =
> +						omap_hsmmc1_after_set_reg;
> +			}
>  			/* Omap3630 HSMMC1 supports only 4-bit */
>  			if (cpu_is_omap3630() && c->wires > 4) {
>  				c->wires = 4;
> diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
> index a56deee..6d17a61 100644
> --- a/arch/arm/plat-omap/include/plat/control.h
> +++ b/arch/arm/plat-omap/include/plat/control.h
> @@ -207,6 +207,9 @@
>  /* 44xx control status register offset */
>  #define OMAP44XX_CONTROL_STATUS		0x2c4
> 
> +/* 44xx-only CONTROL_GENERAL register offsets */
> +#define OMAP44XX_CONTROL_MMC1           0x628
> +#define OMAP44XX_CONTROL_PBIAS_LITE     0x600
>  /*
>   * REVISIT: This list of registers is not comprehensive - there are more
>   * that should be added.
> @@ -252,6 +255,20 @@
>  #define OMAP2_PBIASLITEPWRDNZ0		(1 << 1)
>  #define OMAP2_PBIASLITEVMODE0		(1 << 0)
> 
> +/* CONTROL_PBIAS_LITE bits for OMAP4 */
> +#define OMAP4_MMC1_PWRDNZ			(1 << 26)
> +#define OMAP4_MMC1_PBIASLITE_HIZ_MODE		(1 << 25)
> +#define OMAP4_MMC1_PBIASLITE_PWRDNZ		(1 << 22)
> +#define OMAP4_MMC1_PBIASLITE_VMODE		(1 << 21)
> +
> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP0	(1 << 31)
> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP1	(1 << 30)
> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP2	(1 << 29)
> +#define OMAP4_CONTROL_SDMMC1_PUSTRENGTHGRP3	(1 << 28)
> +#define OMAP4_CONTROL_SDMMC1_DR0_SPEEDCTRL	(1 << 27)
> +#define OMAP4_CONTROL_SDMMC1_DR1_SPEEDCTRL	(1 << 26)
> +#define OMAP4_CONTROL_SDMMC1_DR2_SPEEDCTRL	(1 << 25)
> +
>  /* CONTROL_PROG_IO1 bits */
>  #define OMAP3630_PRG_SDMMC1_SPEEDCTRL	(1 << 20)
> 
> diff --git a/include/linux/i2c/twl.h b/include/linux/i2c/twl.h
> index eb198db..423a355 100644
> --- a/include/linux/i2c/twl.h
> +++ b/include/linux/i2c/twl.h
> @@ -142,6 +142,13 @@
>  #define TWL6030_CHARGER_FAULT_INT_MASK 	0x60
> 
>  #define TWL6030_MMCCTRL			0xEE
> +#define VMMC_AUTO_OFF			(0x1 << 3)
> +#define SW_FC				(0x1 << 2)
> +
> +#define TWL6030_CFG_INPUT_PUPD3		0xF2
> +#define MMC_PU				(0x1 << 3)
> +#define MMC_PD				(0x1 << 2)
> +
> 
>  #define TWL4030_CLASS_ID 		0x4030
>  #define TWL6030_CLASS_ID 		0x6030
> @@ -174,11 +181,40 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned
>  int twl6030_interrupt_unmask(u8 bit_mask, u8 offset);
>  int twl6030_interrupt_mask(u8 bit_mask, u8 offset);
> 
> -/*
> - * MMC1 Controller on OMAP4 uses Phoenix Irq for Card detect.
> - */
> +/* MMC1 Controller on OMAP4 uses Phoenix Irq for Card detect */
>  int twl6030_mmc_card_detect(struct device *dev, int slot);
> 
> +/* Configuring Card Detect for MMC1 */
> +static inline int omap4_hsmmc1_card_detect_config(void)
> +{
> +	int res = -1;
> +	u8 reg_val = 0;
> +
> +	/* Unmasking the Card detect Interrupt line for MMC1 from Phoenix */
> +	if (twl_class_is_6030()) {
> +		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
> +							REG_INT_MSK_LINE_B);
> +		twl6030_interrupt_unmask(TWL6030_MMCDETECT_INT_MASK,
> +							REG_INT_MSK_STS_B);
> +	}
> +
> +	/*
> +	 * Intially Configuring MMC_CTRL for receving interrupts &
> +	 * Card status on TWL6030 for MMC1
> +	 */
> +	reg_val |= (SW_FC & ~VMMC_AUTO_OFF);
> +	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val, TWL6030_MMCCTRL);
> +	res = twl_i2c_read_u8(TWL6030_MODULE_ID0, &reg_val,
> +						TWL6030_CFG_INPUT_PUPD3);
> +	if (res < 0)
> +		return -EINVAL;
> +	reg_val = 0;
> +	reg_val &= ~(MMC_PU | MMC_PD);
> +	twl_i2c_write_u8(TWL6030_MODULE_ID0, reg_val,
> +						TWL6030_CFG_INPUT_PUPD3);
> +	return 0;
> +}
> +
>  /*----------------------------------------------------------------------*/
> 
>  /*
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
