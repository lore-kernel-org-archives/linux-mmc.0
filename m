From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 3/7] mmc: dw_mmc: exynos: move definitions to header file
Date: Mon, 14 Apr 2014 16:31:07 +0900
Message-ID: <534B8EBB.4020007@samsung.com>
References: <000301cf48e6$ea205860$be610920$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:47869 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750881AbaDNHbJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Apr 2014 03:31:09 -0400
In-reply-to: <000301cf48e6$ea205860$be610920$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Kukjin Kim' <kgene.kim@samsung.com>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

On 03/26/2014 08:31 PM, Seungwon Jeon wrote:
> Move some parts related to definition to header file.
> 
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |   46 ++++---------------------------
>  drivers/mmc/host/dw_mmc-exynos.h |   55 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+), 40 deletions(-)
>  create mode 100644 drivers/mmc/host/dw_mmc-exynos.h
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index a2d06c5..bab97e9 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -21,42 +21,8 @@
>  
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> +#include "dw_mmc-exynos.h"
>  
> -#define NUM_PINS(x)			(x + 2)
> -
> -#define SDMMC_CLKSEL			0x09C
> -#define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
> -#define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
> -#define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
> -#define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
> -#define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
> -					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
> -					SDMMC_CLKSEL_CCLK_DIVIDER(z))
> -#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
> -
> -#define EXYNOS4210_FIXED_CIU_CLK_DIV	2
> -#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
> -
> -/* Block number in eMMC */
> -#define DWMCI_BLOCK_NUM		0xFFFFFFFF
> -
> -#define SDMMC_EMMCP_BASE	0x1000
> -#define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
> -#define SDMMC_MPSBEGIN0		(SDMMC_EMMCP_BASE + 0x0200)
> -#define SDMMC_MPSEND0		(SDMMC_EMMCP_BASE + 0x0204)
> -#define SDMMC_MPSCTRL0		(SDMMC_EMMCP_BASE + 0x020C)
> -
> -/* SMU control bits */
> -#define DWMCI_MPSCTRL_SECURE_READ_BIT		BIT(7)
> -#define DWMCI_MPSCTRL_SECURE_WRITE_BIT		BIT(6)
> -#define DWMCI_MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
> -#define DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
> -#define DWMCI_MPSCTRL_USE_FUSE_KEY		BIT(3)
> -#define DWMCI_MPSCTRL_ECB_MODE			BIT(2)
> -#define DWMCI_MPSCTRL_ENCRYPTION		BIT(1)
> -#define DWMCI_MPSCTRL_VALID			BIT(0)
> -
> -#define EXYNOS_CCLKIN_MIN	50000000	/* unit: HZ */
>  
>  /* Variations in Exynos specific dw-mshc controller */
>  enum dw_mci_exynos_type {
> @@ -104,11 +70,11 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>  
>  	if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420_SMU) {
>  		mci_writel(host, MPSBEGIN0, 0);
> -		mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
> -		mci_writel(host, MPSCTRL0, DWMCI_MPSCTRL_SECURE_WRITE_BIT |
> -			   DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
> -			   DWMCI_MPSCTRL_VALID |
> -			   DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
> +		mci_writel(host, MPSEND0, SDMMC_ENDING_SEC_NR_MAX);
> +		mci_writel(host, MPSCTRL0, SDMMC_MPSCTRL_SECURE_WRITE_BIT |
> +			   SDMMC_MPSCTRL_NON_SECURE_READ_BIT |
> +			   SDMMC_MPSCTRL_VALID |
> +			   SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT);
>  	}
>  
>  	return 0;
> diff --git a/drivers/mmc/host/dw_mmc-exynos.h b/drivers/mmc/host/dw_mmc-exynos.h
> new file mode 100644
> index 0000000..2554e2f
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-exynos.h
> @@ -0,0 +1,55 @@
> +/*
> + * Exynos Specific Extensions for Synopsys DW Multimedia Card Interface driver
> + *
> + * Copyright (C) 2012-2014 Samsung Electronics Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef _DW_MMC_EXYNOS_H_
> +#define _DW_MMC_EXYNOS_H_
> +
> +/* Extended Register's Offset */
> +#define SDMMC_CLKSEL			0x09C
> +
> +/* CLKSEL register defines */
> +#define SDMMC_CLKSEL_CCLK_SAMPLE(x)	(((x) & 7) << 0)
> +#define SDMMC_CLKSEL_CCLK_DRIVE(x)	(((x) & 7) << 16)
> +#define SDMMC_CLKSEL_CCLK_DIVIDER(x)	(((x) & 7) << 24)
> +#define SDMMC_CLKSEL_GET_DRV_WD3(x)	(((x) >> 16) & 0x7)
> +#define SDMMC_CLKSEL_TIMING(x, y, z)	(SDMMC_CLKSEL_CCLK_SAMPLE(x) |	\
> +					 SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
> +					 SDMMC_CLKSEL_CCLK_DIVIDER(z))
> +#define SDMMC_CLKSEL_WAKEUP_INT		BIT(11)
> +
> +/* Protector Register */
> +#define SDMMC_EMMCP_BASE	0x1000
> +#define SDMMC_MPSECURITY	(SDMMC_EMMCP_BASE + 0x0010)
> +#define SDMMC_MPSBEGIN0		(SDMMC_EMMCP_BASE + 0x0200)
> +#define SDMMC_MPSEND0		(SDMMC_EMMCP_BASE + 0x0204)
> +#define SDMMC_MPSCTRL0		(SDMMC_EMMCP_BASE + 0x020C)
> +
> +/* SMU control defines */
> +#define SDMMC_MPSCTRL_SECURE_READ_BIT		BIT(7)
> +#define SDMMC_MPSCTRL_SECURE_WRITE_BIT		BIT(6)
> +#define SDMMC_MPSCTRL_NON_SECURE_READ_BIT	BIT(5)
> +#define SDMMC_MPSCTRL_NON_SECURE_WRITE_BIT	BIT(4)
> +#define SDMMC_MPSCTRL_USE_FUSE_KEY		BIT(3)
> +#define SDMMC_MPSCTRL_ECB_MODE			BIT(2)
> +#define SDMMC_MPSCTRL_ENCRYPTION		BIT(1)
> +#define SDMMC_MPSCTRL_VALID			BIT(0)
> +
> +/* Maximum number of Ending sector */
> +#define SDMMC_ENDING_SEC_NR_MAX	0xFFFFFFFF
> +
> +/* Fixed clock divider */
> +#define EXYNOS4210_FIXED_CIU_CLK_DIV	2
> +#define EXYNOS4412_FIXED_CIU_CLK_DIV	4
> +
> +/* Minimal required clock frequency for cclkin, unit: HZ */
> +#define EXYNOS_CCLKIN_MIN	50000000
> +
> +#endif /* _DW_MMC_EXYNOS_H_ */
> 

