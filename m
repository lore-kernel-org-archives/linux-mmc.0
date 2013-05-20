From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCHv2 6/6] mmc: dw_mmc: Add support DW SD/MMC driver on SOCFPGA
Date: Mon, 20 May 2013 09:47:43 -0500
Message-ID: <519A378F.7070409@gmail.com>
References: <1368731117-4749-1-git-send-email-dinguyen@altera.com> <1368731117-4749-6-git-send-email-dinguyen@altera.com> <000a01ce551c$7b174190$7145c4b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:64642 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755331Ab3ETOrr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 20 May 2013 10:47:47 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so13772350ief.40
        for <linux-mmc@vger.kernel.org>; Mon, 20 May 2013 07:47:47 -0700 (PDT)
In-Reply-To: <000a01ce551c$7b174190$7145c4b0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: dinguyen@altera.com, linux-arm-kernel@lists.infradead.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Arnd Bergmann' <arnd@arndb.de>, 'Olof Johansson' <olof@lixom.net>, 'Pavel Machek' <pavel@denx.de>, linux-mmc@vger.kernel.org

Hi Seungwon,

On 05/20/2013 12:40 AM, Seungwon Jeon wrote:
> On 05/17/13 4:05, Dinh Nguyen wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> Add platform specific functionality for the DW SD/MMC driver for
>> SoCFPGA. Move SDMMC_CMD_USE_HOLD_REG to dw_mmc.h so other platforms
>> can use this define.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> CC: Seungwon Jeon <tgih.jun@samsung.com>
>> CC: Jaehoon Chung <jh80.chung@samsung.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Olof Johansson <olof@lixom.net>
>> CC: Pavel Machek <pavel@denx.de>
>> CC: linux-mmc@vger.kernel.org
>>
>> v2:
>> - Use syscon and regmap
>> - Avoid divide by zero
>> - Remove the need to set PWR_EN
>> ---
>>  drivers/mmc/host/Kconfig          |    8 +++
>>  drivers/mmc/host/Makefile         |    1 +
>>  drivers/mmc/host/dw_mmc-exynos.c  |    2 -
>>  drivers/mmc/host/dw_mmc-socfpga.c |  139 +++++++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc.h         |    1 +
>>  5 files changed, 149 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/mmc/host/dw_mmc-socfpga.c
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 9ab8f8d..1be2289 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -556,6 +556,14 @@ config MMC_DW_EXYNOS
>>  	  Synopsys DesignWare Memory Card Interface driver. Select this option
>>  	  for platforms based on Exynos4 and Exynos5 SoC's.
>>
>> +config MMC_DW_SOCFPGA
>> +	tristate "SOCFPGA specific extensions for Synopsys DW Memory Card Interface"
>> +	depends on MMC_DW
>> +	select MMC_DW_PLTFM
>> +	help
>> +	  This selects support for Altera SoCFPGA specific extensions to the
>> +	  Synopsys DesignWare Memory Card Interface driver.
>> +
>>  config MMC_DW_PCI
>>  	tristate "Synopsys Designware MCI support on PCI bus"
>>  	depends on MMC_DW && PCI
>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>> index cd32280..67718c1 100644
>> --- a/drivers/mmc/host/Makefile
>> +++ b/drivers/mmc/host/Makefile
>> @@ -42,6 +42,7 @@ obj-$(CONFIG_SDH_BFIN)		+= bfin_sdh.o
>>  obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
>>  obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
>>  obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
>> +obj-$(CONFIG_MMC_DW_SOCFPGA)	+= dw_mmc-socfpga.o
>>  obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
>>  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
>>  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index f013e7e..866edef 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -31,8 +31,6 @@
>>  					SDMMC_CLKSEL_CCLK_DRIVE(y) |	\
>>  					SDMMC_CLKSEL_CCLK_DIVIDER(z))
>>
>> -#define SDMMC_CMD_USE_HOLD_REG		BIT(29)
>> -
>>  #define EXYNOS4210_FIXED_CIU_CLK_DIV	2
>>  #define EXYNOS4412_FIXED_CIU_CLK_DIV	4
>>
>> diff --git a/drivers/mmc/host/dw_mmc-socfpga.c b/drivers/mmc/host/dw_mmc-socfpga.c
>> new file mode 100644
>> index 0000000..af89685
>> --- /dev/null
>> +++ b/drivers/mmc/host/dw_mmc-socfpga.c
>> @@ -0,0 +1,139 @@
>> +/*
>> + * Altera SoCFPGA Specific Extensions for Synopsys DW Multimedia Card Interface driver
>> + *
>> + *  Copyright (C) 2012, Samsung Electronics Co., Ltd.
>> + *  Copyright (C) 2013 Altera Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * Taken from dw_mmc_exynos.c
>> + */
>> +#include <linux/clk.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/mmc/host.h>
>> +#include <linux/mmc/dw_mmc.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "dw_mmc.h"
>> +#include "dw_mmc-pltfm.h"
>> +
>> +#define SYSMGR_SDMMCGRP_CTRL_OFFSET		0x108
>> +#define DRV_CLK_PHASE_SHIFT_SEL_MASK	0x7
>> +#define SYSMGR_SDMMC_CTRL_SET(smplsel, drvsel)		\
>> +	((((drvsel) << 0) & 0x7) | (((smplsel) << 3) & 0x38))
> Did you check Jaehoon Chung's comment?
> It's trivial, but more common.
> ((((smplsel) & 0x38) << 3) | (((drvsel) & 0x7) << 0))
>

Yes, I missed the comment. Will change in rev3.

>> +
>> +extern void __iomem *sys_manager_base_addr;
>> +
>> +/* SOCFPGA implementation specific driver private data */
>> +struct dw_mci_socfpga_priv_data {
>> +	u8	ciu_div;
>> +	u32	hs_timing;
>> +	struct regmap   *sysreg;
>> +};
>> +
>> +static int dw_mci_socfpga_priv_init(struct dw_mci *host)
>> +{
>> +	struct dw_mci_socfpga_priv_data *priv;
>> +	struct device *dev = host->dev;
>> +
>> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv) {
>> +		dev_err(host->dev, "mem alloc failed for private data\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	host->priv = priv;
>> +	return 0;
>> +}
>> +
>> +static int dw_mci_socfpga_setup_clock(struct dw_mci *host)
>> +{
>> +	struct dw_mci_socfpga_priv_data *priv = host->priv;
>> +
>> +	clk_disable(host->ciu_clk);
>> +	regmap_write(priv->sysreg, SYSMGR_SDMMCGRP_CTRL_OFFSET, priv->hs_timing);
>> +	clk_enable(host->ciu_clk);
> You can use clk_prepare_enable/clk_disable_unprepare instead of clk_enable/clk_disable.
> 

OK.

>> +
>> +	host->bus_hz /= (priv->ciu_div + 1);
>> +	return 0;
>> +}
>> +
>> +static void dw_mci_socfpga_prepare_command(struct dw_mci *host, u32 *cmdr)
>> +{
>> +	struct dw_mci_socfpga_priv_data *priv = host->priv;
>> +
>> +	if (priv->hs_timing & DRV_CLK_PHASE_SHIFT_SEL_MASK)
>> +		*cmdr |= SDMMC_CMD_USE_HOLD_REG;
>> +}
>> +
>> +static int dw_mci_socfpga_parse_dt(struct dw_mci *host)
>> +{
>> +	struct dw_mci_socfpga_priv_data *priv = host->priv;
>> +	struct device_node *np = host->dev->of_node;
>> +	u32 timing[2];
>> +	u32 div = 0;
>> +	int ret;
>> +
>> +	priv->sysreg = syscon_regmap_lookup_by_compatible("altr,sys-mgr");
> How about placing syscon_regmap_lookup_by_compatible in dw_mci_socfpga_priv_init.
> It seems more proper place.
>

Ok, will move.

>> +	if (IS_ERR(priv->sysreg)) {
>> +		dev_err(host->dev, "regmap for altr,sys-mgr lookup failed.\n");
>> +		return PTR_ERR(priv->sysreg);
>> +	}
>> +
>> +	of_property_read_u32(np, "altr,dw-mshc-ciu-div", &div);
> Error check would be helpful.
> ret = of_property_read_u32();
> 
> Thanks,
> Seungwon Jeon
>

Thanks for the review.

Dinh

>> +	priv->ciu_div = div;
>> +
>> +	ret = of_property_read_u32_array(np,
>> +			"altr,dw-mshc-sdr-timing", timing, 2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	priv->hs_timing = SYSMGR_SDMMC_CTRL_SET(timing[0], timing[1]);
>> +	return 0;
>> +}
>> +
>> +static const struct dw_mci_drv_data socfpga_drv_data = {
>> +	.init			= dw_mci_socfpga_priv_init,
>> +	.setup_clock		= dw_mci_socfpga_setup_clock,
>> +	.prepare_command	= dw_mci_socfpga_prepare_command,
>> +	.parse_dt		= dw_mci_socfpga_parse_dt,
>> +};
>> +
>> +static const struct of_device_id dw_mci_socfpga_match[] = {
>> +	{ .compatible = "altr,socfpga-dw-mshc",
>> +			.data = &socfpga_drv_data, },
>> +	{},
>> +};
>> +MODULE_DEVICE_TABLE(of, dw_mci_socfpga_match);
>> +
>> +int dw_mci_socfpga_probe(struct platform_device *pdev)
>> +{
>> +	const struct dw_mci_drv_data *drv_data;
>> +	const struct of_device_id *match;
>> +
>> +	match = of_match_node(dw_mci_socfpga_match, pdev->dev.of_node);
>> +	drv_data = match->data;
>> +	return dw_mci_pltfm_register(pdev, drv_data);
>> +}
>> +
>> +static struct platform_driver dw_mci_socfpga_pltfm_driver = {
>> +	.probe		= dw_mci_socfpga_probe,
>> +	.remove		= __exit_p(dw_mci_pltfm_remove),
>> +	.driver		= {
>> +		.name		= "dwmmc_socfpga",
>> +		.of_match_table	= of_match_ptr(dw_mci_socfpga_match),
>> +		.pm		= &dw_mci_pltfm_pmops,
>> +	},
>> +};
>> +
>> +module_platform_driver(dw_mci_socfpga_pltfm_driver);
>> +
>> +MODULE_DESCRIPTION("Altera SOCFPGA Specific DW-MSHC Driver Extension");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("platform:dwmmc-socfpga");
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index 0b74189..3700cb2 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -111,6 +111,7 @@
>>  #define SDMMC_INT_ERROR			0xbfc2
>>  /* Command register defines */
>>  #define SDMMC_CMD_START			BIT(31)
>> +#define SDMMC_CMD_USE_HOLD_REG	BIT(29)
>>  #define SDMMC_CMD_CCS_EXP		BIT(23)
>>  #define SDMMC_CMD_CEATA_RD		BIT(22)
>>  #define SDMMC_CMD_UPD_CLK		BIT(21)
>> --
>> 1.7.9.5
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
