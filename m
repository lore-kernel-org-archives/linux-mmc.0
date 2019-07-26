From: "Andrew Jeffery" <andrew@aj.id.au>
Subject: Re: [PATCH v2 2/2] mmc: Add support for the ASPEED SD controller
Date: Fri, 26 Jul 2019 10:22:33 +0930
Message-ID: <7cd30f3d-43fd-42da-9301-091eb2625c65@www.fastmail.com>
References: <20190712033214.24713-1-andrew@aj.id.au>
 <20190712033214.24713-3-andrew@aj.id.au>
 <d6f7fdf2-07ed-354a-ca29-f3175623679c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d6f7fdf2-07ed-354a-ca29-f3175623679c@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-aspeed@lists.ozlabs.org, Ryan Chen <ryanchen.aspeed@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Thu, 25 Jul 2019, at 22:49, Adrian Hunter wrote:
> On 12/07/19 6:32 AM, Andrew Jeffery wrote:
> > Add a minimal driver for ASPEED's SD controller, which exposes two
> > SDHCIs.
> > 
> > The ASPEED design implements a common register set for the SDHCIs, and
> > moves some of the standard configuration elements out to this common
> > area (e.g. 8-bit mode, and card detect configuration which is not
> > currently supported).
> > 
> > The SD controller has a dedicated hardware interrupt that is shared
> > between the slots. The common register set exposes information on which
> > slot triggered the interrupt; early revisions of the patch introduced an
> > irqchip for the register, but reality is it doesn't behave as an
> > irqchip, and the result fits awkwardly into the irqchip APIs. Instead
> > I've taken the simple approach of using the IRQ as a shared IRQ with
> > some minor performance impact for the second slot.
> > 
> > Ryan was the original author of the patch - I've taken his work and
> > massaged it to drop the irqchip support and rework the devicetree
> > integration. The driver has been smoke tested under qemu against a
> > minimal SD controller model and lightly tested on an ast2500-evb.
> > 
> > Signed-off-by: Ryan Chen <ryanchen.aspeed@gmail.com>
> > Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Looks fine.  Few minor comments below.
> 
> > ---
> > In v2:
> > 
> > * Drop unnecesasry MODULE_DEVICE_TABLE()
> > * Rename sd-controller compatible
> > * Add IBM copyright
> > * Drop unnecesary data assignment in of match table entries
> > * Derive the slot from the SDHCI offset
> > 
> >  drivers/mmc/host/Kconfig           |  12 ++
> >  drivers/mmc/host/Makefile          |   1 +
> >  drivers/mmc/host/sdhci-of-aspeed.c | 326 +++++++++++++++++++++++++++++
> >  3 files changed, 339 insertions(+)
> >  create mode 100644 drivers/mmc/host/sdhci-of-aspeed.c
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 931770f17087..2bb5e1264b3d 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -154,6 +154,18 @@ config MMC_SDHCI_OF_ARASAN
> >  
> >  	  If unsure, say N.
> >  
> > +config MMC_SDHCI_OF_ASPEED
> > +	tristate "SDHCI OF support for the ASPEED SDHCI controller"
> > +	depends on MMC_SDHCI_PLTFM
> > +	depends on OF
> > +	help
> > +	  This selects the ASPEED Secure Digital Host Controller Interface.
> > +
> > +	  If you have a controller with this interface, say Y or M here. You
> > +	  also need to enable an appropriate bus interface.
> > +
> > +	  If unsure, say N.
> > +
> >  config MMC_SDHCI_OF_AT91
> >  	tristate "SDHCI OF support for the Atmel SDMMC controller"
> >  	depends on MMC_SDHCI_PLTFM
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 73578718f119..390ee162fe71 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -84,6 +84,7 @@ obj-$(CONFIG_MMC_SDHCI_ESDHC_IMX)	+= sdhci-esdhc-imx.o
> >  obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
> >  obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ARASAN)	+= sdhci-of-arasan.o
> > +obj-$(CONFIG_MMC_SDHCI_OF_ASPEED)	+= sdhci-of-aspeed.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_AT91)		+= sdhci-of-at91.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
> >  obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
> > diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
> > new file mode 100644
> > index 000000000000..9528e43c257d
> > --- /dev/null
> > +++ b/drivers/mmc/host/sdhci-of-aspeed.c
> > @@ -0,0 +1,326 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/* Copyright (C) 2019 ASPEED Technology Inc. */
> > +/* Copyright (C) 2019 IBM Corp. */
> > +
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/io.h>
> > +#include <linux/mmc/host.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/spinlock.h>
> > +
> > +#include "sdhci-pltfm.h"
> > +
> > +#define ASPEED_SDC_INFO		0x00
> > +#define   ASPEED_SDC_S1MMC8	BIT(25)
> > +#define   ASPEED_SDC_S0MMC8	BIT(24)
> > +
> > +struct aspeed_sdc {
> > +	struct clk *clk;
> > +	struct resource *res;
> > +
> > +	spinlock_t lock;
> > +	void __iomem *regs;
> > +};
> > +
> > +struct aspeed_sdhci {
> > +	struct aspeed_sdc *parent;
> > +	u32 width_mask;
> > +};
> > +
> > +static void aspeed_sdc_bus_width(struct aspeed_sdc *sdc,
> > +				 struct aspeed_sdhci *sdhci, bool bus8)
> 
> The function name threw me at first.  I suggest:
> 
> static void aspeed_sdhci_set_clr_8_bit_mode(struct aspeed_sdhci *aspeed_sdhci,
> 					    bool bus8)

I wasn't real happy with the name I picked, so was hoping to some degree to be
bike-shedded on it. I'll fix it up.

> {
> 	struct aspeed_sdc *aspeed_sdc = aspeed_sdhci->parent;
> 
> > +{
> > +	u32 info;
> > +
> > +	/* Set/clear 8 bit mode */
> > +	spin_lock(&sdc->lock);
> > +	info = readl(sdc->regs + ASPEED_SDC_INFO);
> > +	if (bus8)
> > +		info |= sdhci->width_mask;
> > +	else
> > +		info &= ~sdhci->width_mask;
> > +	writel(info, sdc->regs + ASPEED_SDC_INFO);
> > +	spin_unlock(&sdc->lock);
> > +}
> > +
> > +static void aspeed_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> > +{
> > +	unsigned long timeout;
> > +	int div;
> > +	u16 clk;
> > +
> > +	if (clock == host->clock)
> > +		return;
> > +
> > +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +
> > +	if (clock == 0)
> > +		goto out;
> > +
> > +	for (div = 1; div < 256; div *= 2) {
> > +		if ((host->max_clk / div) <= clock)
> > +			break;
> > +	}
> > +	div >>= 1;
> > +
> > +	clk = div << SDHCI_DIVIDER_SHIFT;
> 
> Could call sdhci_enable_clk() here.

I'll look into it.

> 
> > +	clk |= SDHCI_CLOCK_INT_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +	/* Wait max 20 ms */
> > +	timeout = 20;
> > +	while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> > +		 & SDHCI_CLOCK_INT_STABLE)) {
> > +		if (timeout == 0) {
> > +			pr_err("%s: Internal clock never stabilised.\n",
> > +			       mmc_hostname(host->mmc));
> > +			return;
> > +		}
> > +		timeout--;
> > +		mdelay(1);
> > +	}
> > +
> > +	clk |= SDHCI_CLOCK_CARD_EN;
> > +	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +out:
> > +	host->clock = clock;
> > +}
> > +
> > +static void aspeed_sdhci_set_bus_width(struct sdhci_host *host, int width)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_priv;
> > +	struct aspeed_sdhci *aspeed_sdhci;
> > +	struct aspeed_sdc *aspeed_sdc;
> > +	u8 ctrl;
> > +
> > +	pltfm_priv = sdhci_priv(host);
> > +	aspeed_sdhci = sdhci_pltfm_priv(pltfm_priv);
> > +	aspeed_sdc = aspeed_sdhci->parent;
> > +
> > +	/* Set/clear 8-bit mode */
> > +	aspeed_sdc_bus_width(aspeed_sdc, aspeed_sdhci,
> > +			     width == MMC_BUS_WIDTH_8);
> > +
> > +	/* Set/clear 1 or 4 bit mode */
> > +	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
> > +	if (width == MMC_BUS_WIDTH_4)
> > +		ctrl |= SDHCI_CTRL_4BITBUS;
> > +	else
> > +		ctrl &= ~SDHCI_CTRL_4BITBUS;
> > +	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
> > +}
> > +
> > +static const struct sdhci_ops aspeed_sdhci_ops = {
> > +	.set_clock = aspeed_sdhci_set_clock,
> > +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
> > +	.set_bus_width = aspeed_sdhci_set_bus_width,
> > +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
> > +	.reset = sdhci_reset,
> > +	.set_uhs_signaling = sdhci_set_uhs_signaling,
> > +};
> > +
> > +static const struct sdhci_pltfm_data aspeed_sdc_pdata = {
> 
> Up to you, but this is for the aspeed_sdhci driver, so I would
> have expected it to be called aspeed_sdhci_pdata

Uh, yeah. Good catch.

> 
> > +	.ops = &aspeed_sdhci_ops,
> > +	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> > +	.quirks2 = SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> 
> You don't use sdhci_set_clock() or sdhci_calc_clk(), so it doesn't
> look like SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN is needed.

I did look at that and was a bit suspicious about it, good to have my suspicion
confirmed.

> 
> > +};
> > +
> > +static inline int aspeed_sdhci_calculate_slot(struct aspeed_sdhci *dev,
> > +					      struct resource *res)
> > +{
> > +	resource_size_t delta;
> > +
> > +	if (!res || resource_type(res) != IORESOURCE_MEM)
> > +		return -EINVAL;
> > +
> > +	if (res->start < dev->parent->res->start)
> > +		return -EINVAL;
> > +
> > +	delta = res->start - dev->parent->res->start;
> > +	if (delta & (0x100 - 1))
> > +		return -EINVAL;
> > +
> > +	return (delta / 0x100) - 1;
> > +}
> > +
> > +static int aspeed_sdhci_probe(struct platform_device *pdev)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct aspeed_sdhci *dev;
> > +	struct sdhci_host *host;
> > +	struct resource *res;
> > +	int slot;
> > +	int ret;
> > +
> > +	host = sdhci_pltfm_init(pdev, &aspeed_sdc_pdata, sizeof(*dev));
> > +	if (IS_ERR(host))
> > +		return PTR_ERR(host);
> > +
> > +	pltfm_host = sdhci_priv(host);
> > +	dev = sdhci_pltfm_priv(pltfm_host);
> > +	dev->parent = dev_get_drvdata(pdev->dev.parent);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	slot = aspeed_sdhci_calculate_slot(dev, res);
> > +	if (slot < 0)
> > +		return slot;
> > +	dev_info(&pdev->dev, "Configuring for slot %d\n", slot);
> > +	dev->width_mask = !slot ? ASPEED_SDC_S0MMC8 : ASPEED_SDC_S1MMC8;
> 
> That implies that you only support 2 slots which begs the question why
> you don't validate slot.

I'm not sure what you mean here, but I'll dig into it.

> 
> > +
> > +	sdhci_get_of_property(pdev);
> > +
> > +	pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(pltfm_host->clk))
> > +		return PTR_ERR(pltfm_host->clk);
> > +
> > +	ret = clk_prepare_enable(pltfm_host->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to enable SDIO clock\n");
> > +		goto err_pltfm_free;
> > +	}
> > +
> > +	ret = mmc_of_parse(host->mmc);
> > +	if (ret)
> > +		goto err_sdhci_add;
> > +
> > +	ret = sdhci_add_host(host);
> > +	if (ret)
> > +		goto err_sdhci_add;
> > +
> > +	return 0;
> > +
> > +err_sdhci_add:
> > +	clk_disable_unprepare(pltfm_host->clk);
> > +err_pltfm_free:
> > +	sdhci_pltfm_free(pdev);
> > +	return ret;
> > +}
> > +
> > +static int aspeed_sdhci_remove(struct platform_device *pdev)
> > +{
> > +	struct sdhci_pltfm_host *pltfm_host;
> > +	struct sdhci_host *host;
> > +	int dead;
> > +
> > +	host = platform_get_drvdata(pdev);
> > +	pltfm_host = sdhci_priv(host);
> > +
> > +	dead = readl(host->ioaddr + SDHCI_INT_STATUS) == 0xffffffff;
> 
> 'dead' only makes sense for PCI. Just set it to zero.

Ack.

Thanks for the feedback, I'll send a v3.

Andrew

> 
> > +
> > +	sdhci_remove_host(host, dead);
> > +
> > +	clk_disable_unprepare(pltfm_host->clk);
> > +
> > +	sdhci_pltfm_free(pdev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_sdhci_of_match[] = {
> > +	{ .compatible = "aspeed,ast2400-sdhci", },
> > +	{ .compatible = "aspeed,ast2500-sdhci", },
> > +	{ }
> > +};
> > +
> > +static struct platform_driver aspeed_sdhci_driver = {
> > +	.driver		= {
> > +		.name	= "sdhci-aspeed",
> > +		.of_match_table = aspeed_sdhci_of_match,
> > +	},
> > +	.probe		= aspeed_sdhci_probe,
> > +	.remove		= aspeed_sdhci_remove,
> > +};
> > +
> > +module_platform_driver(aspeed_sdhci_driver);
> > +
> > +static int aspeed_sdc_probe(struct platform_device *pdev)
> > +
> > +{
> > +	struct device_node *parent, *child;
> > +	struct aspeed_sdc *sdc;
> > +	int ret;
> > +
> > +	sdc = devm_kzalloc(&pdev->dev, sizeof(*sdc), GFP_KERNEL);
> > +	if (!sdc)
> > +		return -ENOMEM;
> > +
> > +	spin_lock_init(&sdc->lock);
> > +
> > +	sdc->clk = devm_clk_get(&pdev->dev, NULL);
> > +	if (IS_ERR(sdc->clk))
> > +		return PTR_ERR(sdc->clk);
> > +
> > +	ret = clk_prepare_enable(sdc->clk);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Unable to enable SDCLK\n");
> > +		return ret;
> > +	}
> > +
> > +	sdc->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	sdc->regs = devm_ioremap_resource(&pdev->dev, sdc->res);
> > +	if (IS_ERR(sdc->regs)) {
> > +		ret = PTR_ERR(sdc->regs);
> > +		goto err_clk;
> > +	}
> > +
> > +	dev_set_drvdata(&pdev->dev, sdc);
> > +
> > +	parent = pdev->dev.of_node;
> > +	for_each_available_child_of_node(parent, child) {
> > +		struct platform_device *cpdev;
> > +
> > +		cpdev = of_platform_device_create(child, NULL, &pdev->dev);
> > +		if (IS_ERR(cpdev)) {
> > +			of_node_put(child);
> > +			ret = PTR_ERR(pdev);
> > +			goto err_clk;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +
> > +err_clk:
> > +	clk_disable_unprepare(sdc->clk);
> > +	return ret;
> > +}
> > +
> > +static int aspeed_sdc_remove(struct platform_device *pdev)
> > +{
> > +	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
> > +
> > +	clk_disable_unprepare(sdc->clk);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id aspeed_sdc_of_match[] = {
> > +	{ .compatible = "aspeed,ast2400-sd-controller", },
> > +	{ .compatible = "aspeed,ast2500-sd-controller", },
> > +	{ }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, aspeed_sdc_of_match);
> > +
> > +static struct platform_driver aspeed_sdc_driver = {
> > +	.driver		= {
> > +		.name	= "sd-controller-aspeed",
> > +		.pm	= &sdhci_pltfm_pmops,
> > +		.of_match_table = aspeed_sdc_of_match,
> > +	},
> > +	.probe		= aspeed_sdc_probe,
> > +	.remove		= aspeed_sdc_remove,
> > +};
> > +
> > +module_platform_driver(aspeed_sdc_driver);
> > +
> > +MODULE_DESCRIPTION("Driver for the ASPEED SD/SDIO/SDHCI Controllers");
> > +MODULE_AUTHOR("Ryan Chen <ryan_chen@aspeedtech.com>");
> > +MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
> > +MODULE_LICENSE("GPL v2");
> > 
> 
>
