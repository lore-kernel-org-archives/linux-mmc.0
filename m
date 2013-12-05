From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
Date: Thu, 05 Dec 2013 23:00:57 +0900
Message-ID: <001f01cef1c2$6bd0ab70$43720250$%jun@samsung.com>
References: <1383889128-12540-1-git-send-email-zhangfei.gao@linaro.org>
 <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:56904 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751783Ab3LEOBA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 09:01:00 -0500
In-reply-to: <1383889128-12540-3-git-send-email-zhangfei.gao@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Zhangfei Gao' <zhangfei.gao@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Kumar Gala' <galak@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Fri, November 08, 2013, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
> ---
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   83 +++++++
>  drivers/mmc/host/Kconfig                           |   10 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/dw_mmc-k3.c                       |  247 ++++++++++++++++++++
>  4 files changed, 341 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-k3.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> new file mode 100644
> index 0000000..ea858f4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -0,0 +1,83 @@
> +* Hisilicon specific extensions to the Synopsys Designware Mobile
> +  Storage Host Controller
> +
> +Read synopsis-dw-mshc.txt for more details
> +The Synopsys designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsys dw mshc controller properties described
> +by synopsis-dw-mshc.txt and the properties used by the Hisilicon specific
> +extensions to the Synopsys Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "hisilicon,hi4511-dw-mshc": for controllers with hi4511
> +	  specific extentions.
> +* reg: should be address and size of mmc controller
> +* vmmc-supply: should be vmmc used in dwmmc
> +* fifo-depth: should be provided if register can not provide correct value
> +* tuning-table: should be array to tune mmc controller, including clock rate
> +	to be set and values for setting optional register.
Descriptions for each cell would be required here.
And isn't tuning-table closer to board portion rather than soc portion?

> +
> +Optional properties:
> +
> +/* These registers from pctrl node used for tuning mmc controller if required */
> +* clken-reg: should be clock enable register and offset bit
> +* drv-sel-reg: should be driver delay select register, start bit and bits numbers
> +* sam-sel-reg: should be sample delay select register, start bit and bits numbers
> +* div-reg: should be divider register, start bit and bits numbers
> +
> +Example:
> +
> +	/* SoC portion */
> +	dwmmc_0: dwmmc0@fcd03000 {
> +		compatible = "hisilicon,hi4511-dw-mshc";
> +		reg = <0xfcd03000 0x1000>;
> +		interrupts = <0 16 4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&clk_sd>, <&clk_ddrc_per>;
> +		clock-names = "ciu", "biu";
> +		clken-reg = <0x1f8 0>;
> +		drv-sel-reg = <0x1f8 4 4>;
> +		sam-sel-reg = <0x1f8 8 4>;
> +		div-reg = <0x1f8 1 3>;
> +		tuning-table =
> +		<180000000 6 6 13 13 25000000>,
> +		<0 0 0 0 0 0>,
> +		<360000000 6 4 2 0 50000000>,
> +		<180000000 6 4 13 13 25000000>,
> +		<360000000 6 4 2 0 50000000>,
> +		<720000000 6 1 9 4 100000000>,
> +		<0 0 0 0 0 0>,
> +		<360000000 7 1 3 0 50000000>;
> +	};
> +
> +	/* Board portion */
> +	dwmmc0@fcd03000 {
> +		num-slots = <1>;
> +		vmmc-supply = <&ldo12>;
> +		fifo-depth = <0x100>;
> +		supports-highspeed;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <4>;
> +			disable-wp;
> +			cd-gpios = <&gpio10 3 0>;
> +		};
> +	};
> +
> +PCTRL: Peripheral misc control register
> +
> +Required Properties:
> +- compatible: "hisilicon,pctrl"
> +- reg: Address and size of pctrl.
> +
> +Example:
> +
> +	pctrl: pctrl@fca09000 {
> +		compatible = "hisilicon,pctrl";
> +		reg = <0xfca09000 0x1000>;
> +	};
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 7fc5099..45aaa2d 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -575,6 +575,16 @@ config MMC_DW_SOCFPGA
>  	  This selects support for Altera SoCFPGA specific extensions to the
>  	  Synopsys DesignWare Memory Card Interface driver.
> 
> +config MMC_DW_K3
> +	tristate "K3 specific extensions for Synopsys DW Memory Card Interface"
> +	depends on MMC_DW
> +	select MMC_DW_PLTFM
> +	select MMC_DW_IDMAC
> +	help
> +	  This selects support for Hisilicon K3 SoC specific extensions to the
> +	  Synopsys DesignWare Memory Card Interface driver. Select this option
> +	  for platforms based on Hisilicon K3 SoC's.
> +
>  config MMC_DW_PCI
>  	tristate "Synopsys Designware MCI support on PCI bus"
>  	depends on MMC_DW && PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index c41d0c3..64f5f8d 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -43,6 +43,7 @@ obj-$(CONFIG_MMC_DW)		+= dw_mmc.o
>  obj-$(CONFIG_MMC_DW_PLTFM)	+= dw_mmc-pltfm.o
>  obj-$(CONFIG_MMC_DW_EXYNOS)	+= dw_mmc-exynos.o
>  obj-$(CONFIG_MMC_DW_SOCFPGA)	+= dw_mmc-socfpga.o
> +obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
>  obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
>  obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
>  obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> new file mode 100644
> index 0000000..881d2f4
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -0,0 +1,247 @@
> +/*
> + * Copyright (c) 2013 Linaro Ltd.
> + * Copyright (c) 2013 Hisilicon Limited.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/dw_mmc.h>
> +#include <linux/of_address.h>
> +
> +#include "dw_mmc.h"
> +#include "dw_mmc-pltfm.h"
> +
> +#define TABLE_WIDTH 6
> +#define TABLE_HEIGHT 8
> +struct dw_mci_k3_priv_data {
> +	int			old_timing;
> +	u32			table[TABLE_WIDTH * TABLE_HEIGHT];
> +	u32			clken_reg;
> +	u32			clken_bit;
> +	u32			sam_reg;
> +	u32			sam_off;
> +	u32			sam_bits;
> +	u32			drv_reg;
> +	u32			drv_off;
> +	u32			drv_bits;
> +	u32			div_reg;
> +	u32			div_off;
> +	u32			div_bits;
> +};
> +
> +static void __iomem *pctrl;
> +static DEFINE_SPINLOCK(mmc_tuning_lock);
Can the above variables be involved in dw_mci_k3_priv_data instead of global declaration?

> +
> +static u32 dw_mci_k3_delay(u32 val, u32 para, u32 off, u32 len)
> +{
> +	u32 i;
> +
> +	if (para >= 0) {
> +		for (i = 0; i < len; i++) {
> +			if (para % 2)
> +				val |= 1 << (off + i);
> +			else
> +				val &= ~(1 << (off + i));
> +			para = para >> 1;
> +		}
> +	}
> +	return val;
> +}
> +
> +static void dw_mci_k3_set_timing(struct dw_mci_k3_priv_data *priv,
> +					u32 sam, u32 drv, u32 div)
> +{
> +	u32 val;
> +	unsigned long flags;
> +
> +	if (!pctrl || !priv->clken_reg || !priv->sam_reg
> +		|| !priv->drv_reg || !priv->div_reg)
> +		return;
> +
> +	spin_lock_irqsave(&mmc_tuning_lock, flags);
> +
> +	val = readl(pctrl + priv->clken_reg);
> +	val &= ~(1 << priv->clken_bit);
> +	writel(val, pctrl + priv->clken_reg);
> +
> +	val = readl(pctrl + priv->sam_reg);
> +	val = dw_mci_k3_delay(val, sam, priv->sam_off, priv->sam_bits);
> +	writel(val, pctrl + priv->sam_reg);
> +
> +	val = readl(pctrl + priv->drv_reg);
> +	val = dw_mci_k3_delay(val, drv, priv->drv_off, priv->drv_bits);
> +	writel(val, pctrl + priv->drv_reg);
> +
> +	val = readl(pctrl + priv->div_reg);
> +	val = dw_mci_k3_delay(val, div, priv->div_off, priv->div_bits);
> +	writel(val, pctrl + priv->div_reg);
> +
> +	val = readl(pctrl + priv->clken_reg);
> +	val |= 1 << priv->clken_bit;
> +	writel(val, pctrl + priv->clken_reg);
> +
> +	spin_unlock_irqrestore(&mmc_tuning_lock, flags);
> +}
> +
> +static void dw_mci_k3_tun(struct dw_mci *host, int timing)
> +{
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +	u32 *table = &priv->table[TABLE_WIDTH * timing];
Timing value should be less than TABLE_HEIGHT.
It needs to check the range of value.

> +	int ret;
> +
> +	if (priv->old_timing == timing)
> +		return;
> +
> +	ret = clk_set_rate(host->ciu_clk, table[0]);
> +	if (ret) {
> +		dev_err(host->dev, "clk_set_rate failed\n");
> +		return;
> +	}
> +	dw_mci_k3_set_timing(priv, (table[3] + table[4]) / 2,
> +			table[2], table[1]);
> +	host->bus_hz = table[5];
> +	priv->old_timing = timing;
> +}
> +
> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +	dw_mci_k3_tun(host, ios->timing);
> +}
> +
> +static int dw_mci_k3_setup_clock(struct dw_mci *host)
> +{
> +	dw_mci_k3_tun(host, MMC_TIMING_LEGACY);
Is it necessary here?
When card-init, MMC_TIMING_LEGACY will be passed via dw_mci_k3_set_ios().

> +	return 0;
> +}
> +
> +static int dw_mci_k3_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_k3_priv_data *priv;
> +	struct device_node *np = host->dev->of_node, *node;
> +	u32 data[3];
> +	int ret;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(host->dev, "mem alloc failed for private data\n");
> +		return -ENOMEM;
> +	}
> +	priv->old_timing = -1;
> +	host->priv = priv;
> +
> +	ret = of_property_read_u32_array(host->dev->of_node, "tuning-table",
> +			priv->table, TABLE_WIDTH * TABLE_HEIGHT);
> +	if (ret) {
> +		dev_err(host->dev, "not found tuning-table\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!pctrl) {
> +		node = of_find_compatible_node(NULL, NULL, "hisilicon,pctrl");
> +		pctrl = of_iomap(node, 0);
> +	}
> +
> +	ret = of_property_read_u32_array(np, "clken-reg", data, 2);
> +	if (!ret) {
> +		priv->clken_reg = data[0];
> +		priv->clken_bit = data[1];
> +	}
> +
> +	ret = of_property_read_u32_array(np, "drv-sel-reg", data, 3);
> +	if (!ret) {
> +		priv->drv_reg = data[0];
> +		priv->drv_off = data[1];
> +		priv->drv_bits = data[2];
> +	}
> +
> +	ret = of_property_read_u32_array(np, "sam-sel-reg", data, 3);
> +	if (!ret) {
> +		priv->sam_reg = data[0];
> +		priv->sam_off = data[1];
> +		priv->sam_bits = data[2];
> +	}
> +
> +	ret = of_property_read_u32_array(np, "div-reg", data, 3);
> +	if (!ret) {
> +		priv->div_reg = data[0];
> +		priv->div_off = data[1];
> +		priv->div_bits = data[2];
> +	}
All properties seem mandatory.
If right, it should return error in case of failure?

> +
> +	return 0;
> +}
> +
> +static unsigned long k3_dwmmc_caps[4] = {
> +	MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED,
> +	MMC_CAP_8_BIT_DATA | MMC_CAP_MMC_HIGHSPEED,
> +	0,
> +	0,
> +};
> +
> +static const struct dw_mci_drv_data k3_drv_data = {
> +	.caps			= k3_dwmmc_caps,
> +	.set_ios		= dw_mci_k3_set_ios,
> +	.setup_clock		= dw_mci_k3_setup_clock,
> +	.parse_dt		= dw_mci_k3_parse_dt,
> +};
> +
> +static const struct of_device_id dw_mci_k3_match[] = {
> +	{ .compatible = "hisilicon,hi4511-dw-mshc",
> +			.data = &k3_drv_data, },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, dw_mci_k3_match);
> +
> +static int dw_mci_k3_probe(struct platform_device *pdev)
> +{
> +	const struct dw_mci_drv_data *drv_data;
> +	const struct of_device_id *match;
> +
> +	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
> +	drv_data = match->data;
> +
> +	return dw_mci_pltfm_register(pdev, drv_data);
> +}
> +
> +static int dw_mci_k3_suspend(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +
> +	return dw_mci_suspend(host);
> +}
> +
> +static int dw_mci_k3_resume(struct device *dev)
> +{
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +
> +	priv->old_timing = -1;
> +	dw_mci_k3_tun(host, MMC_TIMING_LEGACY);
Same above.
When resuming, MMC_TIMING_LEGACY will be passed via dw_mci_k3_set_ios().

Thanks,
Seungwon Jeon

> +
> +	return dw_mci_resume(host);
> +}
> +
> +SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_k3_resume);
> +
> +static struct platform_driver dw_mci_k3_pltfm_driver = {
> +	.probe		= dw_mci_k3_probe,
> +	.remove		= dw_mci_pltfm_remove,
> +	.driver		= {
> +		.name		= "dwmmc_k3",
> +		.of_match_table	= dw_mci_k3_match,
> +		.pm		= &dw_mci_k3_pmops,
> +	},
> +};
> +
> +module_platform_driver(dw_mci_k3_pltfm_driver);
> +
> +MODULE_DESCRIPTION("K3 Specific DW-MSHC Driver Extension");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("platform:dwmmc-k3");
> --
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

