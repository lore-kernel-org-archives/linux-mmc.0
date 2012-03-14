From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4/5] MMC: mmci: Enable Device Tree support for ux500 variants
Date: Wed, 14 Mar 2012 14:20:02 +0000
Message-ID: <1331734803-17954-5-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51832 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030524Ab2CNOUP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 10:20:15 -0400
Received: by mail-we0-f174.google.com with SMTP id x9so1729015wej.19
        for <linux-mmc@vger.kernel.org>; Wed, 14 Mar 2012 07:20:14 -0700 (PDT)
In-Reply-To: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

Provide a means to collect attributes specific to ST-Ericsson's
ux500 variant series. This patch registers itself as the AMBA
driver to be called during the probe process. Once all
attributes and ux500 specifics are are collected the normal
mmci core probe is called.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi      |    6 +-
 arch/arm/boot/dts/snowball.dts     |   30 ++++++-
 arch/arm/mach-ux500/board-mop500.c |    3 +-
 drivers/mmc/host/mmci-ux500.c      |  171 +++++++++++++++++++++++++++++++++++-
 4 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index a9866a3..fd3d818 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -238,13 +238,13 @@
 		sdi@80126000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80126000 0x1000>;
-			interrupts = <60>;
+			interrupts = <0 60 0x4>;
 			status = "disabled";
 		};
 		sdi@80118000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80118000 0x1000>;
-			interrupts = <50>;
+			interrupts = <0 50 0x4>;
 			status = "disabled";
 		};
 		sdi@80005000 {
@@ -262,7 +262,7 @@
 		sdi@80114000 {
 			compatible = "arm,pl18x", "arm,primecell";
 			reg = <0x80114000 0x1000>;
-			interrupts = <99>;
+			interrupts = <0 99 0x4>;
 			status = "disabled";
 		};
 		sdi@80008000 {
diff --git a/arch/arm/boot/dts/snowball.dts b/arch/arm/boot/dts/snowball.dts
index 359c6d6..164200d 100644
--- a/arch/arm/boot/dts/snowball.dts
+++ b/arch/arm/boot/dts/snowball.dts
@@ -87,13 +87,37 @@
 			};
 		};
 
+		// External Micro SD slot
 		sdi@80126000 {
-			status = "enabled";
-			cd-gpios = <&gpio6 26>;
+			arm,primecell-periphid = <0x10480180>;
+			#gpio-cells = <1>;
+			gpio-en   = <217>; // <&gpio6 25>;
+			gpio-vsel = <228>; // <&gpio7 4>;
+			cd-gpios  = <218>; // <&gpio6 26>;
+			cd-invert;
+
+			ocr_mask = <0x00020000>;
+			clock_frequency = <50000000>;
+			rx_src_dev_type = <29>;
+			tx_dst_dev_type = <29>;
+			mmc_cap_4_bit_data;
+			mmc_cap_mmc_highspeed;
+
+			status = "okay";
 		};
 
+		// On-board eMMC
 		sdi@80114000 {
-			status = "enabled";
+			arm,primecell-periphid = <0x10480180>;
+			ocr_mask = <0x00020000>;
+		        clock_frequency = <50000000>;
+			mmc_cap_4_bit_data;
+			mmc_cap_8_bit_data;
+			mmc_cap_mmc_highspeed;
+			rx_src_dev_type = <42>;
+			tx_dst_dev_type = <42>;
+
+			status = "okay";
 		};
 
 		uart@80120000 {
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index d0799d5..60c23c5 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -750,6 +750,8 @@ struct of_dev_auxdata u8500_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("arm,pl011", 0x80121000, "uart1", &uart1_plat),
 	OF_DEV_AUXDATA("arm,pl011", 0x80007000, "uart2", &uart2_plat),
 	OF_DEV_AUXDATA("arm,pl022", 0x80002000, "ssp0",  &ssp0_plat),
+	OF_DEV_AUXDATA("arm,pl18x", 0x80126000, "sdi0", NULL),
+	OF_DEV_AUXDATA("arm,pl18x", 0x80114000, "sdi4", NULL),
 	{},
 };
 
@@ -789,7 +791,6 @@ static void __init u8500_init_machine(void)
 		platform_add_devices(snowball_platform_devs,
 				ARRAY_SIZE(snowball_platform_devs));
 
-		snowball_sdi_init(parent);
 	} else if (of_machine_is_compatible("st-ericsson,hrefv60+")) {
 		/*
 		 * The HREFv60 board removed a GPIO expander and routed
diff --git a/drivers/mmc/host/mmci-ux500.c b/drivers/mmc/host/mmci-ux500.c
index 82e60f9..75435e4 100644
--- a/drivers/mmc/host/mmci-ux500.c
+++ b/drivers/mmc/host/mmci-ux500.c
@@ -1,5 +1,11 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of_gpio.h>
+
+#include <plat/ste_dma40.h>
+
+#include "mmci.h"
 
 /* MMCIPOWER bits */
 #define MCI_DATA2DIREN		(1 << 2)
@@ -37,6 +43,167 @@ static struct variant_data variant_ux500v2 = {
 	.blksz_datactrl16	= true,
 };
 
+struct mmci_ux500_platform_data {
+	struct mmci_platform_data pdata;
+	int gpio_en;
+	int gpio_vsel;
+};
+
+static u32 mmci_ux500_vdd_handler(struct device *dev, unsigned int vdd,
+				   unsigned char power_mode)
+{
+	struct mmci_ux500_platform_data *pdata =
+		container_of(dev->platform_data, struct mmci_ux500_platform_data, pdata);
+
+	switch (power_mode) {
+	case MMC_POWER_UP:
+	case MMC_POWER_ON:
+		/*
+		 * Level shifter voltage should depend on vdd to when deciding
+		 * on either 1.8V or 2.9V. Once the decision has been made the
+		 * level shifter must be disabled and re-enabled with a changed
+		 * select signal in order to switch the voltage. Since there is
+		 * no framework support yet for indicating 1.8V in vdd, use the
+		 * default 2.9V.
+		 */
+		if (pdata->gpio_vsel)
+			gpio_direction_output(pdata->gpio_vsel, 0);
+		if (pdata->gpio_en)
+			gpio_direction_output(pdata->gpio_en, 1);
+		break;
+	case MMC_POWER_OFF:
+		if (pdata->gpio_vsel)
+			gpio_direction_output(pdata->gpio_vsel, 0);
+		if (pdata->gpio_en)
+			gpio_direction_output(pdata->gpio_en, 0);
+		break;
+	}
+
+	return MCI_FBCLKEN | MCI_CMDDIREN | MCI_DATA0DIREN |
+	       MCI_DATA2DIREN | MCI_DATA31DIREN;
+}
+
+static int __devinit mmci_ux500_probe(struct amba_device *dev,
+				const struct amba_id *id)
+{
+	struct mmci_ux500_platform_data *ux500_pdata;
+	struct mmci_platform_data *pdata = dev->dev.platform_data;
+	struct device_node *np = dev->dev.of_node;
+	struct stedma40_chan_cfg *dma_tx_param;
+	struct stedma40_chan_cfg *dma_rx_param;
+	int val, ret = -EINVAL;
+
+	/* Check if we have already been populated by platform code. */
+	if (pdata)
+		return mmci_probe(dev, id);
+
+#ifdef CONFIG_OF
+	if (!np) {
+		pr_warning("No platform data or Device Tree found\n");
+		return -EINVAL;
+	}
+
+	ux500_pdata = kzalloc(sizeof(struct mmci_ux500_platform_data), GFP_KERNEL);
+	if (!ux500_pdata)
+		return -ENOMEM;
+
+	dma_tx_param = kzalloc(sizeof(struct stedma40_chan_cfg), GFP_KERNEL);
+	if (!dma_tx_param) {
+		ret = -ENOMEM;
+		goto out1;
+	}
+
+	dma_rx_param = kzalloc(sizeof(struct stedma40_chan_cfg), GFP_KERNEL);
+	if (!dma_rx_param) {
+		ret = -ENOMEM;
+		goto out2;
+	}
+
+	/* ST-Ericsson/Micro specific DMA attributes. */
+	ux500_pdata->gpio_vsel = 0;
+	ux500_pdata->gpio_en = 0;
+
+	of_property_read_u32(np, "gpio-en", &ux500_pdata->gpio_en);
+	of_property_read_u32(np, "gpio-vsel", &ux500_pdata->gpio_vsel);
+
+	if (ux500_pdata->gpio_vsel && ux500_pdata->gpio_en) {
+		ret  = gpio_request(ux500_pdata->gpio_en, "level shifter enable");
+		if (ret) {
+			pr_warning("GPIO request for level shifter enable failed.\n");
+			goto out3;
+		}
+
+		ret = gpio_request(ux500_pdata->gpio_vsel, "level shifter 1v8-3v select");
+		if (ret) {
+			pr_warning("GPIO request for level shifter select failed.\n");
+			goto out3;
+		}
+
+		/* Select the default 2.9V and enable level shifter */
+		gpio_direction_output(ux500_pdata->gpio_vsel, 0);
+		gpio_direction_output(ux500_pdata->gpio_en, 1);
+
+		ux500_pdata->pdata.vdd_handler = mmci_ux500_vdd_handler;
+	}
+
+	ux500_pdata->pdata.dma_filter  = stedma40_filter;
+
+	/* Mode. */
+	dma_tx_param->mode = STEDMA40_MODE_LOGICAL;
+	dma_rx_param->mode = STEDMA40_MODE_LOGICAL;
+
+	/* Direction. */
+	dma_tx_param->dir = STEDMA40_MEM_TO_PERIPH;
+	dma_rx_param->dir = STEDMA40_PERIPH_TO_MEM;
+
+	/* Device type. */
+	dma_tx_param->src_dev_type = STEDMA40_DEV_DST_MEMORY;
+
+	if (!of_property_read_u32(np, "tx_dst_dev_type", &val))
+		dma_tx_param->dst_dev_type = val;
+
+	dma_rx_param->dst_dev_type = STEDMA40_DEV_DST_MEMORY;
+
+	if (!of_property_read_u32(np, "rx_src_dev_type", &val))
+		dma_rx_param->src_dev_type = val;
+
+	/* Data width. */
+	dma_tx_param->src_info.data_width = STEDMA40_WORD_WIDTH;
+	dma_tx_param->dst_info.data_width = STEDMA40_WORD_WIDTH;
+	dma_rx_param->src_info.data_width = STEDMA40_WORD_WIDTH;
+	dma_rx_param->dst_info.data_width = STEDMA40_WORD_WIDTH;
+
+	ux500_pdata->pdata.dma_tx_param = dma_tx_param;
+	ux500_pdata->pdata.dma_rx_param = dma_rx_param;
+
+	dev->dev.platform_data = &ux500_pdata->pdata;
+
+	return mmci_probe(dev, id);
+
+out3:
+	kfree(dma_rx_param);
+out2:
+	kfree(dma_tx_param);
+out1:
+	kfree(ux500_pdata);
+#endif /* CONFIG_OF */
+
+	return ret;
+}
+
+static int __devexit mmci_ux500_remove(struct amba_device *dev)
+{
+	struct mmci_ux500_platform_data *pdata =
+		container_of(dev->dev.platform_data, struct mmci_ux500_platform_data, pdata);
+
+	kfree(pdata->pdata.dma_tx_param);
+	kfree(pdata->pdata.dma_tx_param);
+
+	mmci_remove(dev);
+
+	return 0;
+}
+
 static struct amba_id mmci_ux500_ids[] = {
 	/* ST Micro variants */
 	{
@@ -68,8 +235,8 @@ static struct amba_driver mmci_ux500_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
 	},
-	.probe		= mmci_probe,
-	.remove		= __devexit_p(mmci_remove),
+	.probe		= mmci_ux500_probe,
+	.remove		= __devexit_p(mmci_ux500_remove),
 	.suspend	= mmci_suspend,
 	.resume		= mmci_resume,
 	.id_table	= mmci_ux500_ids,
-- 
1.7.5.4

