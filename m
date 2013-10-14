From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: add dw-mmc-k3
Date: Mon, 14 Oct 2013 18:27:39 +0900
Message-ID: <525BB90B.9060105@samsung.com>
References: <1381415813-9395-1-git-send-email-zhangfei.gao@linaro.org>
 <1381415813-9395-3-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:60006 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754485Ab3JNJ1l (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 05:27:41 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MUN00BNXJM1Z5M0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Oct 2013 18:27:39 +0900 (KST)
In-reply-to: <1381415813-9395-3-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Hi,

If you will send the patch, plz, add the prefix "mmc: dw_mmc: xxx" at subject.
And i think good that device-tree and mmc patch is separated.

On 10/10/2013 11:36 PM, Zhangfei Gao wrote:
> Add dw_mmc-k3.c for k3v2, support sd/emmc
> 
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Zhigang Wang <brooke.wangzhigang@huawei.com>
> ---
>  .../devicetree/bindings/mmc/k3-dw-mshc.txt         |   66 ++++
>  drivers/mmc/host/Kconfig                           |   10 +
>  drivers/mmc/host/Makefile                          |    1 +
>  drivers/mmc/host/dw_mmc-k3.c                       |  392 ++++++++++++++++++++
>  4 files changed, 469 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
>  create mode 100644 drivers/mmc/host/dw_mmc-k3.c
> 
> diff --git a/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> new file mode 100644
> index 0000000..54a9d8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> @@ -0,0 +1,66 @@
> +* Hisilicon specific extensions to the Synopsis Designware Mobile
> +  Storage Host Controller
Maybe fixed the Synopsys instead of Synopsis.
> +
> +Read synopsis-dw-mshc.txt for more details
> +The Synopsis designware mobile storage host controller is used to interface
> +a SoC with storage medium such as eMMC or SD/MMC cards. This file documents
> +differences between the core Synopsis dw mshc controller properties described
> +by synopsis-dw-mshc.txt and the properties used by the Hisilicon specific
> +extensions to the Synopsis Designware Mobile Storage Host Controller.
> +
> +Required Properties:
> +
> +* compatible: should be
> +	- "hisilicon,hi4511-dw-mshc": for controllers with hi4511
> +	  specific extentions.
> +* vmmc-supply: should be vmmc used in dwmmc
> +* fifo-depth: should be provided if register can not provide correct value
> +* clken-reg: should be clock enable register and offset
> +* drv-sel-reg: should be driver delay select register and offset
> +* sam-sel-reg: should be sample delay select register and offset
> +* div-reg: should be divider register and offset
> +
> +Example:
> +
> +  The MSHC controller node can be split into two portions, SoC specific and
> +  board specific portions as listed below.
> +
> +	dwmmc_0: dwmmc0@fcd03000 {
> +		compatible = "hisilicon,hi4511-dw-mshc";
> +		reg = <0xfcd03000 0x1000>;
> +		interrupts = <0 16 4>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		clocks = <&clk_sd>, <&clk_ddrc_per>;
> +		clock-names = "ciu", "biu";
> +		clken-reg = <0x1f8 0>;
> +		drv-sel-reg = <0x1f8 4>;
> +		sam-sel-reg = <0x1f8 8>;
> +		div-reg = <0x1f8 1>;
> +	};
> +	dwmmc0@fcd03000 {
> +		num-slots = <1>;
> +		vmmc-supply = <&ldo12>;
> +		fifo-depth = <0x100>;
> +		supports-highspeed;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&sd_pmx_pins &sd_cfg_func1 &sd_cfg_func2>;
> +		cd-gpio = <&gpio10 3 0>;
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <4>;
> +		};
> +	};
> +
> +PCTRL:
> +
> +Required Properties:
> +* compatible: should be
> +	- "hisilicon,pctrl": Peripheral control
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
> index 0000000..f46453f
> --- /dev/null
> +++ b/drivers/mmc/host/dw_mmc-k3.c
> @@ -0,0 +1,392 @@
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
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/of_address.h>
> +
> +#include "dw_mmc.h"
> +#include "dw_mmc-pltfm.h"
> +
> +#define DRIVER_NAME "dwmmc_k3"
> +
> +enum dw_mci_k3_type {
> +	DW_MCI_TYPE_HI4511,
> +};
> +
> +static struct dw_mci_k3_compatible {
> +	char				*compatible;
> +	enum dw_mci_k3_type		type;
> +} k3_compat[] = {
> +	{
> +		.compatible	= "hisilicon,hi4511-dw-mshc",
> +		.type		= DW_MCI_TYPE_HI4511,
> +	},
> +};
> +
> +struct dw_mci_k3_priv_data {
> +	enum dw_mci_k3_type	type;
> +	int			old_timing;
> +	u32			id;
You're using "id" as the "int" type at the below code. which type is exactly?
> +	u32			gpio_cd;
> +	u32			clken_reg;
> +	u32			clken_bit;
> +	u32			sam_sel_reg;
> +	u32			sam_sel_bit;
> +	u32			drv_sel_reg;
> +	u32			drv_sel_bit;
> +	u32			div_reg;
> +	u32			div_bit;
> +};
clken_reg/sam_sel_reg/drv_sel_reg can be changed? Otherwise, it's not host register?
If it's host register, then you can use the mci_writeX().
> +
> +static void __iomem *pctrl;
> +static DEFINE_SPINLOCK(mmc_tuning_lock);
> +static int k3_tuning_config[][8][6] = {
> +	/* bus_clk, div, drv_sel, sam_sel_max, sam_sel_min, input_clk */
> +	{
> +		{180000000, 6, 6, 13, 13, 25000000},	/* 0: LEGACY 400k */
> +		{0},					/* 1: MMC_HS */
> +		{360000000, 6, 4, 2, 0, 50000000  },	/* 2: SD_HS */
> +		{180000000, 6, 4, 13, 13, 25000000},	/* 3: SDR12 */
> +		{360000000, 6, 4, 2, 0, 50000000  },	/* 4: SDR25 */
> +		{720000000, 6, 1, 9, 4, 100000000 },	/* 5: SDR50 */
> +		{0},					/* 6: SDR104 */
> +		{360000000, 7, 1, 3, 0, 50000000  },	/* 7: DDR50 */
> +	}, {
> +		{26000000, 1, 1, 3, 3, 13000000  },	/* 0: LEGACY 400k */
> +		{360000000, 6, 3, 3, 1, 50000000 },	/* 1: MMC_HS*/
> +		{0},					/* 2: SD_HS */
> +		{0},					/* 3: SDR12 */
> +		{26000000, 1, 1, 3, 3, 13000000	 },     /* 4: SDR25 */
> +		{360000000, 6, 3, 3, 1, 50000000 },	/* 5: SDR50 */
> +		{0},					/* 6: SDR104 */
> +		{720000000, 6, 4, 8, 4, 100000000},	/* 7: DDR50 */
> +	},
> +};
Can't this config be included the dt-file?
> +
> +static void dw_mci_k3_set_timing(struct dw_mci_k3_priv_data *priv,
> +				int idx, int sam, int drv, int div)
Where is "idx" used?

> +{
> +	unsigned int clken_reg = priv->clken_reg;
> +	unsigned int clken_bit = priv->clken_bit;
> +	unsigned int sam_sel_reg = priv->sam_sel_reg;
> +	unsigned int sam_sel_bit = priv->sam_sel_bit;
> +	unsigned int drv_sel_reg = priv->drv_sel_reg;
> +	unsigned int drv_sel_bit = priv->drv_sel_bit;
> +	unsigned int div_reg = priv->div_reg;
> +	unsigned int div_bit = priv->div_bit;
Can't use the priv->xxx?
> +	int i = 0;
> +	unsigned int temp_reg;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mmc_tuning_lock, flags);
> +
> +	/* disable clock */
> +	temp_reg = readl(pctrl + clken_reg);
temp_reg? is it register?
> +	temp_reg &= ~(1<<clken_bit);
> +	writel(temp_reg, pctrl + clken_reg);
> +
> +	temp_reg = readl(pctrl + sam_sel_reg);
> +	if (sam >= 0) {
> +		/* set sam delay */
> +		for (i = 0; i < 4; i++) {
> +			if (sam % 2)
> +				temp_reg |= 1<<(sam_sel_bit + i);
> +			else
> +				temp_reg &= ~(1<<(sam_sel_bit + i));
> +			sam = sam >> 1;
> +		}
> +	}
> +	writel(temp_reg, pctrl + sam_sel_reg);
> +
> +	temp_reg = readl(pctrl + drv_sel_reg);
> +	if (drv >= 0) {
> +		/* set drv delay */
> +		for (i = 0; i < 4; i++) {
> +			if (drv % 2)
> +				temp_reg |= 1<<(drv_sel_bit + i);
> +			else
> +				temp_reg &= ~(1<<(drv_sel_bit + i));
> +			drv = drv >> 1;
> +		}
> +	}
> +	writel(temp_reg, pctrl + drv_sel_reg);
> +
> +	temp_reg = readl(pctrl + div_reg);
> +	if (div >= 0) {
> +		/* set drv delay */
> +		for (i = 0; i < 3; i++) {
> +			if (div % 2)
> +				temp_reg |= 1<<(div_bit + i);
> +			else
> +				temp_reg &= ~(1<<(div_bit + i));
> +			div = div >> 1;
> +		}
> +	}
> +	writel(temp_reg, pctrl + div_reg);
I think these loop can reuse..like dw_mci_k3_set_delay(). It's duplicated.
> +
> +	/* enable clock */
> +	temp_reg = readl(pctrl + clken_reg);
> +	temp_reg |= 1<<clken_bit;
> +	writel(temp_reg, pctrl + clken_reg);
> +
> +	spin_unlock_irqrestore(&mmc_tuning_lock, flags);
> +}
> +
> +static void dw_mci_k3_tun(struct dw_mci *host, int id, int index)
> +{
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +	int ret;
> +
> +	if (!pctrl)
> +		return;
> +
> +	if (priv->old_timing == index)
index? "timing" is more readable?
> +		return;
> +
> +	ret = clk_set_rate(host->ciu_clk, k3_tuning_config[id][index][0]);
> +	if (ret)
> +		dev_err(host->dev, "clk_set_rate failed\n");
not need to control about error? Just print the log?
> +
> +	dw_mci_k3_set_timing(priv, id,
> +			(k3_tuning_config[id][index][3] +
> +			k3_tuning_config[id][index][4]) / 2,
> +			k3_tuning_config[id][index][2],
> +			k3_tuning_config[id][index][1]);
> +
> +	host->bus_hz = k3_tuning_config[id][index][5];
> +	priv->old_timing = index;
> +}
> +
> +static void dw_mci_k3_set_ios(struct dw_mci *host, struct mmc_ios *ios)
> +{
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +	int id = priv->id;
> +
> +	if (priv->type == DW_MCI_TYPE_HI4511)
> +		dw_mci_k3_tun(host, id, ios->timing);
This code is just called the dw_mci_k3_tun()?
Then codes of dw_mci_k3_tun() can place into here?
> +}
> +
> +static int dw_mci_k3_priv_init(struct dw_mci *host)
> +{
> +	struct dw_mci_k3_priv_data *priv;
> +	int i;
> +
> +	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv) {
> +		dev_err(host->dev, "mem alloc failed for private data\n");
> +		return -ENOMEM;
> +	}
> +	priv->id = of_alias_get_id(host->dev->of_node, "mshc");
> +	priv->old_timing = -1;
> +	host->priv = priv;
> +
> +	for (i = 0; i < ARRAY_SIZE(k3_compat); i++) {
> +		if (of_device_is_compatible(host->dev->of_node,
> +					k3_compat[i].compatible))
> +			priv->type = k3_compat[i].type;
> +	}
> +
> +	if (priv->type == DW_MCI_TYPE_HI4511) {
> +		if (!pctrl) {
> +			struct device_node *node;
> +
> +			node = of_find_compatible_node(NULL, NULL,
> +						"hisilicon,pctrl");
> +			pctrl = of_iomap(node, 0);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int dw_mci_k3_setup_clock(struct dw_mci *host)
> +{
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +
> +	if (priv->type == DW_MCI_TYPE_HI4511)
> +		dw_mci_k3_tun(host, priv->id, MMC_TIMING_LEGACY);
> +
> +	return 0;
> +}
> +
> +
remove the white space
> +static irqreturn_t dw_mci_k3_card_detect(int irq, void *data)
> +{
> +	struct dw_mci *host = (struct dw_mci *)data;
> +
> +	queue_work(host->card_workqueue, &host->card_work);
> +	return IRQ_HANDLED;
> +};
> +
> +static int dw_mci_k3_get_cd(struct dw_mci *host, u32 slot_id)
> +{
> +	unsigned int status;
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +
> +	status = !gpio_get_value(priv->gpio_cd);
> +	return status;
> +}
> +
> +static int dw_mci_k3_parse_dt(struct dw_mci *host)
> +{
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +	struct device_node *np = host->dev->of_node;
> +	u32 data[2];
> +	int ret;
> +
> +	if (priv->type == DW_MCI_TYPE_HI4511) {
> +		ret = of_property_read_u32_array(np,
> +				"clken-reg", data, 2);
> +		if (!ret) {
> +			priv->clken_reg = data[0];
> +			priv->clken_bit = data[1];
> +		}
> +
> +		ret = of_property_read_u32_array(np,
> +				"drv-sel-reg", data, 2);
> +		if (!ret) {
> +			priv->drv_sel_reg = data[0];
> +			priv->drv_sel_bit = data[1];
> +		}
> +
> +		ret = of_property_read_u32_array(np,
> +				"sam-sel-reg", data, 2);
> +		if (!ret) {
> +			priv->sam_sel_reg = data[0];
> +			priv->sam_sel_bit = data[1];
> +		}
> +
> +		ret = of_property_read_u32_array(np,
> +				"div-reg", data, 2);
> +		if (!ret) {
> +			priv->div_reg = data[0];
> +			priv->div_bit = data[1];
> +		}
> +	}
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
> +	.init			= dw_mci_k3_priv_init,
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
> +int dw_mci_k3_probe(struct platform_device *pdev)
static?
> +{
> +	const struct dw_mci_drv_data *drv_data;
> +	const struct of_device_id *match;
> +	struct dw_mci *host;
> +	int gpio, err;
> +
> +	match = of_match_node(dw_mci_k3_match, pdev->dev.of_node);
> +	drv_data = match->data;
> +
> +	err = dw_mci_pltfm_register(pdev, drv_data);
> +	if (err)
> +		return err;
> +
> +	host = platform_get_drvdata(pdev);
> +	if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
Why return at here, when Broken card detection is set?
> +		return 0;
> +
> +	gpio = of_get_named_gpio(pdev->dev.of_node, "cd-gpio", 0);
> +	if (gpio_is_valid(gpio)) {
> +		if (devm_gpio_request(host->dev, gpio, "dw-mci-cd")) {
> +			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
> +		} else {
> +			struct dw_mci_k3_priv_data *priv = host->priv;
> +			priv->gpio_cd = gpio;
> +			host->pdata->get_cd = dw_mci_k3_get_cd;
> +			err = devm_request_irq(host->dev, gpio_to_irq(gpio),
> +				dw_mci_k3_card_detect,
> +				IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
> +				DRIVER_NAME, host);
> +			if (err)
> +				dev_warn(mmc_dev(host->dev), "request gpio irq error\n");
> +		}
> +
> +	} else {
> +		dev_info(host->dev, "cd gpio not available");
> +	}
I think it can use the slot-gpio.c.
> +	return 0;
> +}
> +
> +static int dw_mci_k3_suspend(struct device *dev)
> +{
> +	int ret;
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +
> +	ret = dw_mci_suspend(host);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
ret = dw_mci_suspend(host); then
Just return ret;
> +}
> +
> +static int dw_mci_k3_resume(struct device *dev)
> +{
> +	int ret;
> +	struct dw_mci *host = dev_get_drvdata(dev);
> +	struct dw_mci_k3_priv_data *priv = host->priv;
> +
> +	if (priv->type == DW_MCI_TYPE_HI4511) {
> +		int id = priv->id;
> +
> +		priv->old_timing = -1;
> +		dw_mci_k3_tun(host, id, MMC_TIMING_LEGACY);
> +	}
> +
> +	ret = dw_mci_resume(host);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
Ditto
> +}
> +
> +SIMPLE_DEV_PM_OPS(dw_mci_k3_pmops, dw_mci_k3_suspend, dw_mci_k3_resume);
> +
> +static struct platform_driver dw_mci_k3_pltfm_driver = {
> +	.probe		= dw_mci_k3_probe,
> +	.remove		= dw_mci_pltfm_remove,
> +	.driver		= {
> +		.name		= DRIVER_NAME,
Just use the "dwmmc_k3" at here. not use the DRIVER_NAME.
> +		.of_match_table	= dw_mci_k3_match,
> +		.pm		= &dw_mci_k3_pmops,
> +	},
> +};
> +
> +module_platform_driver(dw_mci_k3_pltfm_driver);
> +
> +MODULE_DESCRIPTION("K3 Specific DW-MSHC Driver Extension");
> +MODULE_LICENSE("GPL v2");
> 

