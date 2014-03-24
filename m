From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 3/7] mmc: dw_mmc: exynos: move definitions to header file
Date: Mon, 24 Mar 2014 15:43:30 +0900
Message-ID: <000b01cf472c$5ecadd00$1c609700$%jun@samsung.com>
References: <001d01cf450e$5c8ae960$15a0bc20$%jun@samsung.com>
 <532FB2B6.3060102@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <532FB2B6.3060102@samsung.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Mon, March 24, 2014, Jaehoon Chung wrote:
> Hi, Seungwon.
> 
> On 03/21/2014 11:03 PM, Seungwon Jeon wrote:
> > Moves some parts related to definition to header file
> >
> > Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> > ---
> >  drivers/mmc/host/dw_mmc-exynos.c |   46 ++++---------------------------
> >  drivers/mmc/host/dw_mmc-exynos.h |   55 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+), 40 deletions(-)
> >  create mode 100644 drivers/mmc/host/dw_mmc-exynos.h
> >
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> > index 89aa019..801861b 100644
> > --- a/drivers/mmc/host/dw_mmc-exynos.c
> > +++ b/drivers/mmc/host/dw_mmc-exynos.c
> > @@ -21,42 +21,8 @@
> >
> >  #include "dw_mmc.h"
> >  #include "dw_mmc-pltfm.h"
> > +#include "dw_mmc-exynos.h"
> >
> > -#define NUM_PINS(x)			(x + 2)
> > -
> > -#define SDMMC_CLKSEL			0x09C
> > -#define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
> > -#define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
> > -#define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
> > -#define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
> > -#define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
> > -					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
> > -					SDMMC_CLKSEL_CCLK_DIVIDER(z))
> > -#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
> > -
> > -#define EXYNOS4210_FIXED_CIU_CLK_DIV	2
> > -#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
> > -
> > -/* Block number in eMMC */
> > -#define DWMCI_BLOCK_NUM		0xFFFFFFFF
> > -
> > -#define SDMMC_EMMCP_BASE	0x1000
> > -#define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
> > -#define SDMMC_MPSBEGIN0		(SDMMC_EMMCP_BASE + 0x0200)
> > -#define SDMMC_MPSEND0		(SDMMC_EMMCP_BASE + 0x0204)
> > -#define SDMMC_MPSCTRL0		(SDMMC_EMMCP_BASE + 0x020C)
> > -
> > -/* SMU control bits */
> > -#define DWMCI_MPSCTRL_SECURE_READ_BIT		BIT(7)
> > -#define DWMCI_MPSCTRL_SECURE_WRITE_BIT		BIT(6)
> > -#define DWMCI_MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
> > -#define DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
> > -#define DWMCI_MPSCTRL_USE_FUSE_KEY		BIT(3)
> > -#define DWMCI_MPSCTRL_ECB_MODE			BIT(2)
> > -#define DWMCI_MPSCTRL_ENCRYPTION		BIT(1)
> > -#define DWMCI_MPSCTRL_VALID			BIT(0)
> > -
> > -#define EXYNOS_CCLKIN_MIN	50000000	/* unit: HZ */
> >
> >  /* Variations in Exynos specific dw-mshc controller */
> >  enum dw_mci_exynos_type {
> > @@ -104,11 +70,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >
> >  	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU) {
> >  		mci_writel(host, MPSBEGIN0, 0);
> > -		mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
> > -		mci_writel(host, MPSCTRL0, DWMCI_MPSCTRL_SECURE_WRITE_BIT |
> > -			   DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
> > -			   DWMCI_MPSCTRL_VALID |
> > -			   DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
> > +		mci_writel(host, MPSEND0, SDMMC_ENDING_SEC_NR_MAX);
> > +		mci_writel(host, MPSCTRL0, SDMMC_MPSCTRL_SECURE_WRITE_BIT |
> > +			   SDMMC_MPSCTRL_NON_SECURE_READ_BIT |
> > +			   SDMMC_MPSCTRL_VALID |
> > +			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
> >  	}
> >
> >  	return 0;
> > diff --git a/drivers/mmc/host/dw_mmc-exynos.h b/drivers/mmc/host/dw_mmc-exynos.h
> > new file mode 100644
> > index 0000000..a4c6e10
> > --- /dev/null
> > +++ b/drivers/mmc/host/dw_mmc-exynos.h
> > @@ -0,0 +1,55 @@
> > +/*
> > + * Exynos Specific Extensions for Synopsys DW Multimedia Card Interface driver
> > + *
> > + * Copyright (C) 201333Samsung Electronics Co., Ltd.
> 2013333 Typo? :)
Oh, thank you for detect.

Thanks,
Seungwon Jeon

> 
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef _DW_MMC_EXYNOS_H_
> > +#define _DW_MMC_EXYNOS_H_
> > +
> > +/* Extended Register's Offset */
> > +#define SDMMC_CLKSEL			0x09C
> > +
> > +/* CLKSEL register defines */
> > +#define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
> > +#define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
> > +#define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
> > +#define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
> > +#define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
> > +					 SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
> > +					 SDMMC_CLKSEL_CCLK_DIVIDER(z))
> > +#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
> > +
> > +/* Protector Register */
> > +#define SDMMC_EMMCP_BASE	0x1000
> > +#define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
> > +#define SDMMC_MPSBEGIN0		(SDMMC_EMMCP_BASE + 0x0200)
> > +#define SDMMC_MPSEND0		(SDMMC_EMMCP_BASE + 0x0204)
> > +#define SDMMC_MPSCTRL0		(SDMMC_EMMCP_BASE + 0x020C)
> > +
> > +/* SMU control defines */
> > +#define SDMMC_MPSCTRL_SECURE_READ_BIT		BIT(7)
> > +#define SDMMC_MPSCTRL_SECURE_WRITE_BIT		BIT(6)
> > +#define SDMMC_MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
> > +#define SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
> > +#define SDMMC_MPSCTRL_USE_FUSE_KEY		BIT(3)
> > +#define SDMMC_MPSCTRL_ECB_MODE			BIT(2)
> > +#define SDMMC_MPSCTRL_ENCRYPTION		BIT(1)
> > +#define SDMMC_MPSCTRL_VALID			BIT(0)
> > +
> > +/* Maximum number of Ending sector */
> > +#define SDMMC_ENDING_SEC_NR_MAX	0xFFFFFFFF
> > +
> > +/* Fixed clock divider */
> > +#define EXYNOS4210_FIXED_CIU_CLK_DIV	2
> > +#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
> > +
> > +/* Minimal required clock frequency for cclkin, unit: HZ */
> > +#define EXYNOS_CCLKIN_MIN	50000000
> > +
> > +#endif /* _DW_MMC_EXYNOS_H_ */
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
