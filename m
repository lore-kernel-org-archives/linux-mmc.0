From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 4/5] mmc: dw-mmc: add the header file for exynos specific
 code.
Date: Mon, 27 Aug 2012 10:28:01 +0900
Message-ID: <000901cd83f3$333d2830$99b77890$%jun@samsung.com>
References: <503614A7.3050004@samsung.com>
 <00ad01cd81ac$87e285e0$97a791a0$%jun@samsung.com>
 <503709FA.4090302@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13113 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab2H0B2F (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 26 Aug 2012 21:28:05 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9E008F042QXIG0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 Aug 2012 10:28:02 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0M9E0015542QUCB0@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 27 Aug 2012 10:28:02 +0900 (KST)
In-reply-to: <503709FA.4090302@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>, 'Chris Ball' <cjb@laptop.org>, 'Kyungmin Park' <kyungmin.park@samsung.com>, 'Will Newton' <will.newton@imgtec.com>, 'James Hogan' <james.hogan@imgtec.com>

On Friday, August 24, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 08/24/2012 12:57 PM, Seungwon Jeon wrote:
> > On Thursday, August 23, 2012, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> ---
> >>  include/linux/mmc/exynos-dw_mmc.h |   55 +++++++++++++++++++++++++++++++++++++
> >>  1 files changed, 55 insertions(+), 0 deletions(-)
> >>  create mode 100644 include/linux/mmc/exynos-dw_mmc.h
> >>
> >> diff --git a/include/linux/mmc/exynos-dw_mmc.h b/include/linux/mmc/exynos-dw_mmc.h
> >> new file mode 100644
> >> index 0000000..03444c2
> >> --- /dev/null
> >> +++ b/include/linux/mmc/exynos-dw_mmc.h
> >> @@ -0,0 +1,55 @@
> >> +/*
> >> + * Synopsys DesignWare Multimedia Card Interface driver
> >> + *
> >> + * Copyright (c) 2012 Samsung Electronics Co., Ltd.
> >> + *		http://www.samsung.com
> >> + *
> >> + * Header file for Exynos specific register
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + */
> >> +
> >> +#ifndef _EXYNOS_DW_MMC_H
> >> +#define _EXYNOS_DW_MMC_H
> >> +#include <linux/mmc/dw_mmc.h>
> >> +#include <linux/mmc/host.h>
> >> +
> >> +#define SDMMC_EXYNOS_CLKSEL	0x09C
> >> +
> >> +#define SDMMC_GET_CLK_DRV(x)		((x) >> 16 & 0x7)
> >> +#define SDMMC_GET_CLK_SAMPLE(x)		((x) & 0x7)
> >> +#define SDMMC_CLK_RESET_DRV_SAMPLE	(0x00070007);
> > Could you check the width of register field?
> > There is some difference between ExynosX.
> > It should cover all.
> I checked the Exynos4 and Exynos5.
> So i used the 0x7.
> If i miss something, let me know.
In case of Eyxnos4210, only 2 bits are used.
And new field(DIVRATIO) is added in Exynos5.
It needs to check DIVRATIO for SDMMC_CLK_RESET_DRV_SAMPLE.

Thanks,
Seungwon Jeon.
> 
> Best Regards,
> Jaehoon Chung
> >
> >> +
> >> +#define mci_readl(dev, reg)			\
> >> +	__raw_readl((dev)->regs + SDMMC_##reg)
> >> +#define mci_writel(dev, reg, value)			\
> >> +	__raw_writel((value), (dev)->regs + SDMMC_##reg)
> >> +
> >> +static inline int exynos_get_clk_drv(struct dw_mci *host)
> >> +{
> >> +	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> >> +}
> >> +
> >> +static inline int exynos_get_clk_sample(struct dw_mci *host)
> >> +{
> >> +	return SDMMC_GET_CLK_DRV(mci_readl(host, EXYNOS_CLKSEL));
> >> +}
> >> +
> >> +static inline void exynos_set_clk_drv_sample(struct dw_mci *host,
> >> +		struct mmc_ios *ios)
> >> +{
> >> +	u32 regs;
> >> +
> >> +	regs = mci_readl(host, EXYNOS_CLKSEL);
> >> +	regs &= ~SDMMC_CLK_RESET_DRV_SAMPLE;
> >> +	if (ios->timing == MMC_TIMING_UHS_DDR50)
> >> +		regs |= host->pdata->ddr_timing;
> >> +	else
> >> +		regs |= host->pdata->sdr_timing;
> >> +
> >> +	mci_writel(host, EXYNOS_CLKSEL, regs);
> >> +}
> >> +
> >> +#endif /* _EXYNOS_DW_MMC_H */
> >> --
> >> 1.7.4.1
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

