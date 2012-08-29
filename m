From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v2 3/5] mmc: dw-mmc: add the header file for exynos
 specific code.
Date: Wed, 29 Aug 2012 10:22:39 +0900
Message-ID: <003701cd8584$c7dc6720$57953560$%jun@samsung.com>
References: <503C797F.4040506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:42102 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751593Ab2H2BWl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 21:22:41 -0400
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9H00KC8T3OBT80@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Aug 2012 10:22:40 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M9H00I4DT5RJR40@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 29 Aug 2012 10:22:39 +0900 (KST)
In-reply-to: <503C797F.4040506@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>, 'linux-mmc' <linux-mmc@vger.kernel.org>
Cc: 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <James.Hogan@imgtec.com>, 'Thomas Abraham' <thomas.abraham@linaro.org>

On Tuesday, August 28, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
Commit message is no need?

> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  include/linux/mmc/exynos-dw_mmc.h |   61 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 61 insertions(+), 0 deletions(-)
>  create mode 100644 include/linux/mmc/exynos-dw_mmc.h
> 
> diff --git a/include/linux/mmc/exynos-dw_mmc.h b/include/linux/mmc/exynos-dw_mmc.h
> new file mode 100644
> index 0000000..3a6b08b
> --- /dev/null
> +++ b/include/linux/mmc/exynos-dw_mmc.h
> @@ -0,0 +1,61 @@
> +/*
> + * Synopsys DesignWare Multimedia Card Interface driver
> + *
> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> + *		http://www.samsung.com
> + *
> + * Header file for Exynos specific register
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#ifndef _EXYNOS_DW_MMC_H
> +#define _EXYNOS_DW_MMC_H
> +#include <linux/mmc/dw_mmc.h>
> +#include <linux/mmc/host.h>
> +
> +#define SDMMC_EXYNOS_CLKSEL	0x09C
> +
> +#define SDMMC_GET_CLK_DRV(x)		((x) >> 16 & 0x7)
> +#define SDMMC_GET_CLK_SAMPLE(x)		((x) & 0x7)
> +#define SDMCM_GET_DIVRATIO(x)		((x) >> 24 & 0x7)
> +#define SDMMC_CLK_RESET_DRV_SAMPLE	(0x07070007);
> +
> +#define mci_readl(dev, reg)			\
> +	__raw_readl((dev)->regs + SDMMC_##reg)
> +#define mci_writel(dev, reg, value)			\
> +	__raw_writel((value), (dev)->regs + SDMMC_##reg)
> +
> +static inline int exynos_get_clk_drv(struct dw_mci *host)
> +{
> +	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> +}
> +
> +static inline int exynos_get_clk_sample(struct dw_mci *host)
> +{
> +	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> +}
> +
> +static inline void exynos_set_clk_drv_sample(struct dw_mci *host,
> +		struct mmc_ios *ios)
> +{
> +	u32 regs, ratio;
> +
> +	regs = mci_readl(host, EXYNOS_CLKSEL);
> +	ratio = SDMMC_GET_DIV_RATIO(reg);
> +	if (!ratio) {
Perhaps, "if (ratio)" is right?
Anyway, I feel this patch with "mmc: dw-mmc: add the platdata related with clock"
is overlapped. It needs to be adjusted.


> +		regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
> +		regs |= ratio;
> +		if (ios->timing == MMC_TIMING_UHS_DDR50)
> +			regs |= host->pdata->ddr_timing;
> +		else
> +			regs |= host->pdata->sdr_timing;
> +	} else
> +		regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
> +
> +	mci_writel(host, EXYNOS_CLKSEL, regs);
> +}
> +
> +#endif /* _EXYNOS_DW_MMC_H */
> --
> 1.7.4.1

