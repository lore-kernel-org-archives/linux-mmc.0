From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH v2 3/5] mmc: dw-mmc: add the header file for exynos
 specific code.
Date: Tue, 28 Aug 2012 19:07:47 +0530
Message-ID: <CAJuYYwS0Z=YuXBNEhp-f22nFJoKwSG+oDWAPgHTbpTNBWGJbPQ@mail.gmail.com>
References: <503C797F.4040506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59680 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752694Ab2H1Nhs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 09:37:48 -0400
Received: by lagy9 with SMTP id y9so3278512lag.19
        for <linux-mmc@vger.kernel.org>; Tue, 28 Aug 2012 06:37:47 -0700 (PDT)
In-Reply-To: <503C797F.4040506@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <James.Hogan@imgtec.com>, Seungwon Jeon <tgih.jun@samsung.com>

On 28 August 2012 13:25, Jaehoon Chung <jh80.chung@samsung.com> wrote:
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
> + *             http://www.samsung.com
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
> +#define SDMMC_EXYNOS_CLKSEL    0x09C
> +
> +#define SDMMC_GET_CLK_DRV(x)           ((x) >> 16 & 0x7)
> +#define SDMMC_GET_CLK_SAMPLE(x)                ((x) & 0x7)
> +#define SDMCM_GET_DIVRATIO(x)          ((x) >> 24 & 0x7)
> +#define SDMMC_CLK_RESET_DRV_SAMPLE     (0x07070007);
> +
> +#define mci_readl(dev, reg)                    \
> +       __raw_readl((dev)->regs + SDMMC_##reg)
> +#define mci_writel(dev, reg, value)                    \
> +       __raw_writel((value), (dev)->regs + SDMMC_##reg)
> +
> +static inline int exynos_get_clk_drv(struct dw_mci *host)
> +{
> +       return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> +}
> +
> +static inline int exynos_get_clk_sample(struct dw_mci *host)
> +{
> +       return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> +}
> +
> +static inline void exynos_set_clk_drv_sample(struct dw_mci *host,
> +               struct mmc_ios *ios)
> +{
> +       u32 regs, ratio;
> +
> +       regs = mci_readl(host, EXYNOS_CLKSEL);
> +       ratio = SDMMC_GET_DIV_RATIO(reg);
> +       if (!ratio) {
> +               regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
> +               regs |= ratio;
> +               if (ios->timing == MMC_TIMING_UHS_DDR50)
> +                       regs |= host->pdata->ddr_timing;
> +               else
> +                       regs |= host->pdata->sdr_timing;
> +       } else
> +               regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
> +
> +       mci_writel(host, EXYNOS_CLKSEL, regs);
> +}
> +
> +#endif /* _EXYNOS_DW_MMC_H */
> --
> 1.7.4.1

The device tree support patches for dw-mmc gets this done in the
exynos specific extension callbacks. Personally, I prefer that over
this patch. And, I did not see this code getting used in the other
patches of this series.

Thanks,
Thomas.
