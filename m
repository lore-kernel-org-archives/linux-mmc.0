From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH] mmc: sdhci-pxav3: add support for the Armada 38x SDHCI
 controller
Date: Tue, 25 Feb 2014 19:40:13 +0100
Message-ID: <20140225194013.14693cbd@skate>
References: <1392736109-3981-1-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:33723 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753184AbaBYSkT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 13:40:19 -0500
In-Reply-To: <1392736109-3981-1-git-send-email-thomas.petazzoni@free-electrons.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Marcin Wojtas <mw@semihalf.com>

Hello Chris,

Do you think it would be possible to have the below patch merged for
3.15 ?

It would allow us to enable SDHCI support in the new Marvell Armada 38x
SOCs. The patch is fairly simple I believe, just adding an additional
compatible string to the driver, and adding a little bit of logic to
configure Marvell-specific windows when this compatible string is being
used.

Thanks a lot!

Thomas

On Tue, 18 Feb 2014 16:08:29 +0100, Thomas Petazzoni wrote:
> From: Marcin Wojtas <mw@semihalf.com>
> 
> The SDHCI unit used on the Armada 380 and 385 Marvell SoC is similar
> to the PXAv3 unit. The only difference is that on Armada 38x, the
> PXAv3 unit accesses memory through MBus windows which must be
> configured prior to using the device. Without this, DMA would not
> work.
> 
> In order to achieve this, the sdhci-pxav3 driver is extended with an
> additional compatible string "marvell,armada-380-sdhci". When this
> compatible string is used, the MBus windows are initialized in a way
> that is identical to what all other DMA-capable drivers for Marvell
> EBU platforms do.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../devicetree/bindings/mmc/sdhci-pxa.txt          | 17 +++++-
>  drivers/mmc/host/sdhci-pxav3.c                     | 68 ++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> index dbe98a3..86223c3 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-pxa.txt
> @@ -4,7 +4,14 @@ This file documents differences between the core properties in mmc.txt
>  and the properties used by the sdhci-pxav2 and sdhci-pxav3 drivers.
>  
>  Required properties:
> -- compatible: Should be "mrvl,pxav2-mmc" or "mrvl,pxav3-mmc".
> +- compatible: Should be "mrvl,pxav2-mmc", "mrvl,pxav3-mmc" or
> +  "marvell,armada-380-sdhci".
> +- reg:
> +  * for "mrvl,pxav2-mmc" and "mrvl,pxav3-mmc", one register area for
> +    the SDHCI registers.
> +  * for "marvell,armada-380-sdhci", two register areas. The first one
> +    for the SDHCI registers themselves, and the second one for the
> +    AXI/Mbus bridge registers of the SDHCI unit.
>  
>  Optional properties:
>  - mrvl,clk-delay-cycles: Specify a number of cycles to delay for tuning.
> @@ -19,3 +26,11 @@ sdhci@d4280800 {
>  	non-removable;
>  	mrvl,clk-delay-cycles = <31>;
>  };
> +
> +sdhci@d8000 {
> +	compatible = "marvell,armada-380-sdhci";
> +	reg = <0xd8000 0x1000>, <0xdc000 0x100>;
> +	interrupts = <0 25 0x4>;
> +	clocks = <&gateclk 17>;
> +	mrvl,clk-delay-cycles = <0x1F>;
> +};
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
> index 793dacd..2fd73b3 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -34,6 +34,7 @@
>  #include <linux/of_gpio.h>
>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/mbus.h>
>  
>  #include "sdhci.h"
>  #include "sdhci-pltfm.h"
> @@ -57,6 +58,60 @@
>  #define SDCE_MISC_INT		(1<<2)
>  #define SDCE_MISC_INT_EN	(1<<1)
>  
> +/*
> + * These registers are relative to the second register region, for the
> + * MBus bridge.
> + */
> +#define SDHCI_WINDOW_CTRL(i)	(0x80 + ((i) << 3))
> +#define SDHCI_WINDOW_BASE(i)	(0x84 + ((i) << 3))
> +#define SDHCI_MAX_WIN_NUM	8
> +
> +static int mv_conf_mbus_windows(struct platform_device *pdev,
> +				const struct mbus_dram_target_info *dram)
> +{
> +	int i;
> +	void __iomem *regs;
> +	struct resource *res;
> +
> +	if (!dram) {
> +		dev_err(&pdev->dev, "no mbus dram info\n");
> +		return -EINVAL;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +	if (!res) {
> +		dev_err(&pdev->dev, "cannot get mbus registers\n");
> +		return -EINVAL;
> +	}
> +
> +	regs = ioremap(res->start, resource_size(res));
> +	if (!regs) {
> +		dev_err(&pdev->dev, "cannot map mbus registers\n");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < SDHCI_MAX_WIN_NUM; i++) {
> +		writel(0, regs + SDHCI_WINDOW_CTRL(i));
> +		writel(0, regs + SDHCI_WINDOW_BASE(i));
> +	}
> +
> +	for (i = 0; i < dram->num_cs; i++) {
> +		const struct mbus_dram_window *cs = dram->cs + i;
> +
> +		/* Write size, attributes and target id to control register */
> +		writel(((cs->size - 1) & 0xffff0000) |
> +			(cs->mbus_attr << 8) |
> +			(dram->mbus_dram_target_id << 4) | 1,
> +			regs + SDHCI_WINDOW_CTRL(i));
> +		/* Write base address to base register */
> +		writel(cs->base, regs + SDHCI_WINDOW_BASE(i));
> +	}
> +
> +	iounmap(regs);
> +
> +	return 0;
> +}
> +
>  static void pxav3_set_private_registers(struct sdhci_host *host, u8 mask)
>  {
>  	struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
> @@ -187,6 +242,9 @@ static const struct of_device_id sdhci_pxav3_of_match[] = {
>  	{
>  		.compatible = "mrvl,pxav3-mmc",
>  	},
> +	{
> +		.compatible = "marvell,armada-380-sdhci",
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, sdhci_pxav3_of_match);
> @@ -219,6 +277,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  	struct sdhci_pltfm_host *pltfm_host;
>  	struct sdhci_pxa_platdata *pdata = pdev->dev.platform_data;
>  	struct device *dev = &pdev->dev;
> +	struct device_node *np = pdev->dev.of_node;
>  	struct sdhci_host *host = NULL;
>  	struct sdhci_pxa *pxa = NULL;
>  	const struct of_device_id *match;
> @@ -235,6 +294,14 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>  		kfree(pxa);
>  		return PTR_ERR(host);
>  	}
> +
> +	if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
> +		ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
> +		if (ret < 0)
> +			goto err_mbus_win;
> +	}
> +
> +
>  	pltfm_host = sdhci_priv(host);
>  	pltfm_host->priv = pxa;
>  
> @@ -321,6 +388,7 @@ err_add_host:
>  	clk_disable_unprepare(clk);
>  	clk_put(clk);
>  err_clk_get:
> +err_mbus_win:
>  	sdhci_pltfm_free(pdev);
>  	kfree(pxa);
>  	return ret;



-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
