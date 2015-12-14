From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v4, 1/6] soc: fsl: add GUTS driver for QorIQ platforms
Date: Mon, 14 Dec 2015 16:07:54 -0600
Message-ID: <1450130874.15946.385.camel@freescale.com>
References: <1450067067-44869-1-git-send-email-yangbo.lu@freescale.com>
	 <1450067067-44869-2-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0123.outbound.protection.outlook.com ([65.55.169.123]:47601
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753575AbbLNWXu (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 14 Dec 2015 17:23:50 -0500
In-Reply-To: <1450067067-44869-2-git-send-email-yangbo.lu@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yangbo Lu <yangbo.lu@freescale.com>, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: X.Xie@freescale.com, LeoLi@freescale.com

On Mon, 2015-12-14 at 12:24 +0800, Yangbo Lu wrote:
> The global utilities block controls power management, I/O device
> enabling, power-onreset(POR) configuration monitoring, alternate
> function selection for multiplexed signals,and clock control.
> 
> This patch adds GUTS driver to manage and access global utilities
> block.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> ---
> Changes for v2:
> 	- None
> Changes for v3:
> 	- None
> Changes for v4:
> 	- Added this patch
> ---
>  drivers/soc/Kconfig      |   1 +
>  drivers/soc/Makefile     |   1 +
>  drivers/soc/fsl/Kconfig  |  19 ++++++++
>  drivers/soc/fsl/Makefile |   4 ++
>  drivers/soc/fsl/guts.c   | 112
> +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fsl/guts.h | 103 +++++++++++++++++++++++--------------------
>  6 files changed, 192 insertions(+), 48 deletions(-)
>  create mode 100644 drivers/soc/fsl/Kconfig
>  create mode 100644 drivers/soc/fsl/Makefile
>  create mode 100644 drivers/soc/fsl/guts.c
> 
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 4e853ed..68b5b90 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -7,5 +7,6 @@ source "drivers/soc/rockchip/Kconfig"
>  source "drivers/soc/sunxi/Kconfig"
>  source "drivers/soc/ti/Kconfig"
>  source "drivers/soc/versatile/Kconfig"
> +source "drivers/soc/fsl/Kconfig"
>  
>  endmenu
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index f2ba2e9..2747e58 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
>  obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
>  obj-$(CONFIG_SOC_TI)		+= ti/
>  obj-$(CONFIG_PLAT_VERSATILE)	+= versatile/
> +obj-$(CONFIG_SOC_FSL)		+= fsl/
> diff --git a/drivers/soc/fsl/Kconfig b/drivers/soc/fsl/Kconfig
> new file mode 100644
> index 0000000..09966f0
> --- /dev/null
> +++ b/drivers/soc/fsl/Kconfig
> @@ -0,0 +1,19 @@
> +#
> +# FSL SOC drivers
> +#
> +menuconfig SOC_FSL
> +	bool "Freescale SOC drivers support"
> +
> +if SOC_FSL
> +
> +config FSL_GUTS
> +	tristate "QorIQ Platforms GUTS Driver"
> +	help
> +	  Say y here to enable Freescale QorIQ platforms GUTS driver
> support.
> +	  The global utilities block controls power management, I/O device
> +	  enabling, power-onreset(POR) configuration monitoring, alternate
> +	  function selection for multiplexed signals,and clock control.
> +
> +	  If unsure, say N.

This doesn't do anything user-visible (so far, at least) so it should just be
selected by the drivers that need it.

> +/*
> + * Table for matching compatible strings, for device tree
> + * guts node, for Freescale QorIQ SOCs.
> + * "fsl,qoriq-device-config-2.0" corresponds to T4 & B4
> + * SOCs. For the older SOCs "fsl,qoriq-device-config-1.0"
> + * string would be used.
> + */
> +static const struct of_device_id guts_device_ids[] = {
> +	{ .compatible = "fsl,qoriq-device-config-1.0", },
> +	{ .compatible = "fsl,qoriq-device-config-2.0", },
> +	{}
> +};

What about pre-corenet chips, with compatibles such as "fsl,p2020-guts"?  What
compatible gets used on Layerscape chips?

> +
> +struct ccsr_guts __iomem *guts_regmap(void)
> +{
> +	struct device_node *guts_node;
> +	struct ccsr_guts __iomem *guts;
> +
> +	guts_node = of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts_node)
> +		return NULL;
> +
> +	guts = of_iomap(guts_node, 0);
> +	if (!guts)
> +		return NULL;
> +
> +	of_node_put(guts_node);
> +	return guts;
> +}
> +EXPORT_SYMBOL_GPL(guts_regmap);

This should not be exported.  This should be a normal driver that gets probed
and does its own init.  Callers to this driver should -EPROBE_DEFER if it's
not available yet, and this driver should probably register itself in a
subsys_initcall() or even arch_initcall() to reduce the likelihood of that
(especially if -EPROBE_DEFER would have resulted in deferring another driver
to a phase later than it wanted to init in).


> +
> +u8 guts_get_reg8(void __iomem *reg)
> +{
> +	u8 val;
> +
> +	val = ioread8(reg);
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(guts_get_reg8);
> +
> +void guts_set_reg8(void __iomem *reg, u8 value)
> +{
> +	iowrite8(value, reg);
> +}
> +EXPORT_SYMBOL_GPL(guts_set_reg8);
> +
> +u32 guts_get_reg32(void __iomem *reg)
> +{
> +	struct device_node *guts_node;
> +	u32 val;
> +
> +	guts_node = of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts_node)
> +		return 0;
> +
> +	if (of_property_read_bool(guts_node, "little-endian"))
> +		val = ioread32(reg);
> +	else
> +		val = ioread32be(reg);
> +
> +	return val;
> +}
> +EXPORT_SYMBOL_GPL(guts_get_reg32);
> +
> +void guts_set_reg32(void __iomem *reg, u32 value)
> +{
> +	struct device_node *guts_node;
> +
> +	guts_node = of_find_matching_node(NULL, guts_device_ids);
> +	if (!guts_node)
> +		return;
> +
> +	if (of_property_read_bool(guts_node, "little-endian"))
> +		iowrite32(value, reg);
> +	else
> +		iowrite32be(value, reg);
> +}
> +EXPORT_SYMBOL_GPL(guts_set_reg32);

No.  Export fsl_guts_get_svr().

Also, read the little-endian property once at driver init, not on each access.

> +static int __init guts_drv_init(void)
> +{
> +	pr_info("guts: Freescale QorIQ Platforms GUTS Driver\n");
> +	return 0;
> +}
> +module_init(guts_drv_init);
> +
> +static void __exit guts_drv_exit(void)
> +{
> +}
> +module_exit(guts_drv_exit);

Get rid of the print, especially since it prints regardless of whether the
hardware is present.

> +
> +MODULE_AUTHOR("Yangbo Lu <yangbo.lu@freescale.com>");
> +MODULE_DESCRIPTION("Freescale QorIQ Platforms GUTS Driver");
> +MODULE_LICENSE("GPL v2");

The copyright header says "v2 or later" so MODULE_LICENSE should be just
"GPL".

-Scott

