From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH v3 2/4] mmc: support sdhci-pxav2.c
Date: Fri, 3 Jun 2011 17:04:42 -0700
Message-ID: <5FF51201-93F0-4A45-A93A-A60BD4AD444F@marvell.com>
References: <1307094606-8692-1-git-send-email-zhangfei.gao@marvell.com>
 <8B77F7FC-7D30-44E2-A262-EA0EFA2D45A2@marvell.com>
 <F07D64EA-88E7-4BF2-B677-3A01215923DD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog110.obsmtp.com ([74.125.149.203]:55192 "EHLO
	na3sys009aog110.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754162Ab1FDAG3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 3 Jun 2011 20:06:29 -0400
In-Reply-To: <F07D64EA-88E7-4BF2-B677-3A01215923DD@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>, Wolfram Sang <w.sang@pengutronix.de>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jun Nie <njun@marvell.com>, Raymond Wu <xywu@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Qiming Wu <wuqm@marvell.com>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Zhangfei Gao <zgao6@marvell.com>


> 
> 
> On Jun 3, 2011, at 11:42 AM, Philip Rakity wrote:
> 
>> 
>> On Jun 3, 2011, at 2:50 AM, Zhangfei Gao wrote:
>> 
>>> 	SDHCI driver for pxav2 SoCs, such as pxa910, the driver based on sdhci-pltfm to handle resource etc.
>>> 
>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@marvell.com>
>>> Signed-off-by: Jun Nie <njun@marvell.com>
>>> Signed-off-by: Qiming Wu <wuqm@marvell.com>
>>> ---
>>> drivers/mmc/host/Kconfig       |   11 ++
>>> drivers/mmc/host/Makefile      |    1 +
>>> drivers/mmc/host/sdhci-pxav2.c |  261 ++++++++++++++++++++++++++++++++++++++++
>>> 3 files changed, 273 insertions(+), 0 deletions(-)
>>> create mode 100644 drivers/mmc/host/sdhci-pxav2.c
>>> 
>>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>>> index 4ee869a..1a53d59 100644
>>> --- a/drivers/mmc/host/Kconfig
>>> +++ b/drivers/mmc/host/Kconfig
>>> @@ -192,6 +192,17 @@ config MMC_SDHCI_PXAV3
>>> 
>>> 	  If unsure, say N.
>>> 
>>> +config MMC_SDHCI_PXAV2
>>> +	tristate "Marvell PXAV2 SD Host Controller support"
>>> +	select MMC_SDHCI
>>> +	select MMC_SDHCI_PLTFM
>>> +	help
>>> +	  This selects the Marvell(R) PXAV2 SD Host Controller.
>>> +	  If you have a PXAV2 platform (such as pxa910) with SD Host Controller
>>> +	  and a card slot, say Y or M here.
>>> +
>>> +	  If unsure, say N.
>>> +
>>> config MMC_SDHCI_SPEAR
>>> 	tristate "SDHCI support on ST SPEAr platform"
>>> 	depends on MMC_SDHCI && PLAT_SPEAR
>>> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
>>> index 9131a27..cf95330 100644
>>> --- a/drivers/mmc/host/Makefile
>>> +++ b/drivers/mmc/host/Makefile
>>> @@ -10,6 +10,7 @@ obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>>> obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>>> obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
>>> obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
>>> +obj-$(CONFIG_MMC_SDHCI_PXAV2)	+= sdhci-pxav2.o
>>> obj-$(CONFIG_MMC_SDHCI_S3C)	+= sdhci-s3c.o
>>> obj-$(CONFIG_MMC_SDHCI_SPEAR)	+= sdhci-spear.o
>>> obj-$(CONFIG_MMC_WBSD)		+= wbsd.o
>>> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
>>> new file mode 100644
>>> index 0000000..759f526
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/sdhci-pxav2.c
>>> @@ -0,0 +1,261 @@
>>> +/*
>>> + * Copyright (C) 2010 Marvell International Ltd.
>>> + *		Zhangfei Gao <zhangfei.gao@marvell.com>
>>> + *		Kevin Wang <dwang4@marvell.com>
>>> + *		Jun Nie <njun@marvell.com>
>>> + *		Qiming Wu <wuqm@marvell.com>
>>> + *		Philip Rakity <prakity@marvell.com>
>>> + *
>>> + * This software is licensed under the terms of the GNU General Public
>>> + * License version 2, as published by the Free Software Foundation, and
>>> + * may be copied, distributed, and modified under those terms.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + */
>>> +
>>> +#include <linux/err.h>
>>> +#include <linux/init.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/clk.h>
>>> +#include <linux/io.h>
>>> +#include <linux/gpio.h>
>>> +#include <linux/mmc/card.h>
>>> +#include <linux/mmc/host.h>
>>> +#include <plat/sdhci.h>
>>> +#include <linux/slab.h>
>>> +#include "sdhci.h"
>>> +#include "sdhci-pltfm.h"
>>> +
>>> +#define SD_FIFO_PARAM		0xe0
>>> +#define DIS_PAD_SD_CLK_GATE	0x0400 /* Turn on/off Dynamic SD Clock Gating */
>>> +#define CLK_GATE_ON		0x0200 /* Disable/enable Clock Gate */
>>> +#define CLK_GATE_CTL		0x0100 /* Clock Gate Control */
>>> +#define CLK_GATE_SETTING_BITS	(DIS_PAD_SD_CLK_GATE | \
>>> +		CLK_GATE_ON | CLK_GATE_CTL)
>>> +
>>> +#define SD_CLOCK_BURST_SIZE_SETUP	0xe6
>>> +#define SDCLK_SEL_SHIFT		8
>>> +#define SDCLK_SEL_MASK		0x3
>>> +#define SDCLK_DELAY_SHIFT	10
>>> +#define SDCLK_DELAY_MASK	0x3c
>>> +
>>> +#define SDHCI_HOST_CONTROL	0x28
> 


This definition should come from the sdhci.h include file since it is part of the sd host controller spec.

> .
> 
>>> +#define  SDHCI_CTRL_4BITBUS	0x02
>>> +
>>> +#define SD_CE_ATA_2		0xea
>>> +#define MMC_CARD		0x1000
>>> +#define MMC_WIDTH		0x0100
>>> +
>>> +static void pxav2_set_private_registers(struct sdhci_host *host, u8 mask)
>>> +{
>>> +	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
>>> +	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>>> +
>>> +	if (mask == SDHCI_RESET_ALL) {
>>> +		u16 tmp = 0;
>>> +
>>> +		/*
>>> +		 * tune timing of read data/command when crc error happen
>>> +		 * no performance impact
>>> +		 */
>>> +		if (pdata->clk_delay_sel == 1) {
>>> +			tmp = readw(host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>>> +
>>> +			tmp &= ~(SDCLK_DELAY_MASK << SDCLK_DELAY_SHIFT);
>>> +			tmp |= (pdata->clk_delay_cycles & SDCLK_DELAY_MASK)
>>> +				<< SDCLK_DELAY_SHIFT;
>>> +			tmp &= ~(SDCLK_SEL_MASK << SDCLK_SEL_SHIFT);
>>> +			tmp |= (1 & SDCLK_SEL_MASK) << SDCLK_SEL_SHIFT;
>>> +
>>> +			writew(tmp, host->ioaddr + SD_CLOCK_BURST_SIZE_SETUP);
>>> +		}
>>> +
>>> +		if (pdata->flags & PXA_FLAG_ENABLE_CLOCK_GATING) {
>>> +			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
>>> +			tmp &= ~CLK_GATE_SETTING_BITS;
>>> +			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
>>> +		} else {
>>> +			tmp = readw(host->ioaddr + SD_FIFO_PARAM);
>>> +			tmp &= ~CLK_GATE_SETTING_BITS;
>>> +			tmp |= CLK_GATE_SETTING_BITS;
>>> +			writew(tmp, host->ioaddr + SD_FIFO_PARAM);
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static int pxav2_mmc_set_width(struct sdhci_host *host, int width)
>>> +{
>>> +	u8 ctrl;
>>> +	u16 tmp;
>>> +
>>> +	ctrl = readb(host->ioaddr + SDHCI_HOST_CONTROL);
>>> +	tmp = readw(host->ioaddr + SD_CE_ATA_2);
>>> +	if (width == MMC_BUS_WIDTH_8) {
>>> +		ctrl &= ~SDHCI_CTRL_4BITBUS;
>>> +		tmp |= MMC_CARD | MMC_WIDTH;
>>> +	} else {
>>> +		tmp &= ~(MMC_CARD | MMC_WIDTH);
>>> +		if (width == MMC_BUS_WIDTH_4)
>>> +			ctrl |= SDHCI_CTRL_4BITBUS;
>>> +		else
>>> +			ctrl &= ~SDHCI_CTRL_4BITBUS;
>>> +	}
>>> +	writew(tmp, host->ioaddr + SD_CE_ATA_2);
>>> +	writeb(ctrl, host->ioaddr + SDHCI_HOST_CONTROL);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static unsigned int pxav2_get_ro(struct sdhci_host *host)
>>> +{
>>> +	/* Micro SD does not support write-protect feature */
>>> +	return 0;
>>> +}
>>> +
>>> +static u32 pxav2_get_max_clock(struct sdhci_host *host)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +
>>> +	return clk_get_rate(pltfm_host->clk);
>>> +}
>>> +
>>> +static struct sdhci_ops pxav2_sdhci_ops = {
>>> +	.get_ro = pxav2_get_ro,
>>> +	.get_max_clock = pxav2_get_max_clock,
>>> +	.platform_reset_exit = pxav2_set_private_registers,
>>> +	.platform_8bit_width = pxav2_mmc_set_width,
>>> +};
>>> +
>>> +static int __devinit sdhci_pxav2_probe(struct platform_device *pdev)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host;
>>> +	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>>> +	struct device *dev = &pdev->dev;
>>> +	struct sdhci_host *host = NULL;
>>> +	struct sdhci_pxa *pxa = NULL;
>>> +	int ret;
>>> +	struct clk *clk;
>>> +
>>> +	pxa = kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
>>> +	if (!pxa)
>>> +		return -ENOMEM;
>>> +
>>> +	host = sdhci_pltfm_init(pdev, NULL);
>>> +	if (IS_ERR(host)) {
>>> +		kfree(pxa);
>>> +		return PTR_ERR(host);
>>> +	}
>>> +	pltfm_host = sdhci_priv(host);
>>> +	pltfm_host->priv = pxa;
>>> +
>>> +	clk = clk_get(dev, "PXA-SDHCLK");
>>> +	if (IS_ERR(clk)) {
>>> +		dev_err(dev, "failed to get io clock\n");
>>> +		ret = PTR_ERR(clk);
>>> +		goto err_clk_get;
>>> +	}
>>> +	pltfm_host->clk = clk;
>>> +	clk_enable(clk);
>>> +
>>> +	host->quirks = SDHCI_QUIRK_BROKEN_ADMA
>>> +		| SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>>> +		| SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN;
>>> +
>>> +	if (pdata) {
>>> +		if (pdata->flags & PXA_FLAG_CARD_PERMANENT) {
>>> +			/* on-chip device */
>>> +			host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>>> +			host->mmc->caps |= MMC_CAP_NONREMOVABLE;
>>> +		}
>>> +
>>> +		/* If slot design supports 8 bit data, indicate this to MMC. */
>>> +		if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>>> +			host->mmc->caps |= MMC_CAP_8_BIT_DATA;
>>> +
>>> +		if (pdata->quirks)
>>> +			host->quirks |= pdata->quirks;
>>> +		if (pdata->host_caps)
>>> +			host->mmc->caps |= pdata->host_caps;
>>> +		if (pdata->pm_caps)
>>> +			host->mmc->pm_caps |= pdata->pm_caps;
>>> +	}
>>> +
>>> +	host->ops = &pxav2_sdhci_ops;
>>> +
>>> +	ret = sdhci_add_host(host);
>>> +	if (ret) {
>>> +		dev_err(&pdev->dev, "failed to add host\n");
>>> +		goto err_add_host;
>>> +	}
>>> +
>>> +	if (pdata && pdata->max_speed) {
>>> +		host->mmc->f_max = pdata->max_speed;
>>> +		if (!(host->mmc->f_max > 25000000))
>>> +			host->mmc->caps &= ~(MMC_CAP_SD_HIGHSPEED |
>>> +					MMC_CAP_MMC_HIGHSPEED);
>>> +	}
>> 
>> This should be done before calling add_host.  Add the callback to set f_max()
>> 
>> https://patchwork.kernel.org/patch/742301/
>> 
>> 
>> 
>> 
>>> +
>>> +	platform_set_drvdata(pdev, host);
>>> + 
>>> 
>>> +	return 0;
>>> +
>>> +err_add_host:
>>> +	clk_disable(clk);
>>> +	clk_put(clk);
>>> +err_clk_get:
>>> +	sdhci_pltfm_free(pdev);+	kfree(pxa);
>>> +	return ret;
>>> +}
>>> +
>>> +static int __devexit sdhci_pxav2_remove(struct platform_device *pdev)
>>> +{
>>> +	struct sdhci_host *host = platform_get_drvdata(pdev);
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_pxa *pxa = pltfm_host->priv;
>>> +
>>> +	sdhci_remove_host(host, 1);
>>> +
>>> +	clk_disable(pltfm_host->clk);
>>> +	clk_put(pltfm_host->clk);
>>> +	sdhci_pltfm_free(pdev);
>>> +	kfree(pxa);
>>> +
>>> +	platform_set_drvdata(pdev, NULL);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static struct platform_driver sdhci_pxav2_driver = {
>>> +	.driver		= {
>>> +		.name	= "sdhci-pxav2",
>>> +		.owner	= THIS_MODULE,
>>> +	},
>>> +	.probe		= sdhci_pxav2_probe,
>>> +	.remove		= __devexit_p(sdhci_pxav2_remove),
>>> +#ifdef CONFIG_PM
>>> +	.suspend	= sdhci_pltfm_suspend,
>>> +	.resume		= sdhci_pltfm_resume,
>>> +#endif
>> 
>> could you please post to mmc mailing list code that sets up sdhci-pxav2.
>> 
>>> +};
>>> +static int __init sdhci_pxav2_init(void)
>>> +{
>>> +	return platform_driver_register(&sdhci_pxav2_driver);
>>> +}
>>> +
>>> +static void __exit sdhci_pxav2_exit(void)
>>> +{
>>> +	platform_driver_unregister(&sdhci_pxav2_driver);
>>> +}
>>> +
>>> +module_init(sdhci_pxav2_init);
>>> +module_exit(sdhci_pxav2_exit);
>>> +
>>> +MODULE_DESCRIPTION("SDHCI driver for pxav2");
>>> +MODULE_AUTHOR("Marvell International Ltd.");
>>> +MODULE_LICENSE("GPL v2");
>>> +
>>> -- 
>>> 1.7.0.4
>>> 
>> 
> 

