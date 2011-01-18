From: Sahitya Tummala <stummala@codeaurora.org>
Subject: [PATCH 2/2] msm: 8x50: Add initial support for SDCC
Date: Tue, 18 Jan 2011 11:22:50 +0530
Message-ID: <1295329970-26814-2-git-send-email-stummala@codeaurora.org>
References: <1295329970-26814-1-git-send-email-stummala@codeaurora.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:58210 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750838Ab1ARFx3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Jan 2011 00:53:29 -0500
In-Reply-To: <1295329970-26814-1-git-send-email-stummala@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: davidb@codeaurora.org
Cc: dwalker@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org, san@google.com, Sahitya Tummala <stummala@codeaurora.org>

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
 arch/arm/mach-msm/board-qsd8x50.c               |   81 +++++++++-
 arch/arm/mach-msm/devices-qsd8x50.c             |  196 +++++++++++++++++++++++
 arch/arm/mach-msm/gpiomux-8x50.c                |   23 +++
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |    8 +-
 4 files changed, 303 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 6dde818..29ef683 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -1,4 +1,4 @@
-/* Copyright (c) 2008-2009, Code Aurora Forum. All rights reserved.
+/* Copyright (c) 2009-2011, Code Aurora Forum. All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 and
@@ -21,6 +21,7 @@
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/usb/msm_hsusb.h>
+#include <linux/err.h>
 
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -31,6 +32,8 @@
 #include <mach/irqs.h>
 #include <mach/sirc.h>
 #include <mach/gpio.h>
+#include <mach/vreg.h>
+#include <mach/mmc.h>
 
 #include "devices.h"
 
@@ -95,6 +98,81 @@ static struct platform_device *devices[] __initdata = {
 	&msm_device_hsusb_host,
 };
 
+static struct msm_mmc_gpio sdc1_gpio_cfg[] = {
+	{51, "sdc1_dat_3"},
+	{52, "sdc1_dat_2"},
+	{53, "sdc1_dat_1"},
+	{54, "sdc1_dat_0"},
+	{55, "sdc1_cmd"},
+	{56, "sdc1_clk"}
+};
+
+static struct vreg *vreg_mmc;
+static unsigned long vreg_sts;
+
+static uint32_t msm_sdcc_setup_power(struct device *dv, unsigned int vdd)
+{
+	int rc = 0;
+	struct platform_device *pdev;
+
+	pdev = container_of(dv, struct platform_device, dev);
+
+	if (vdd == 0) {
+		if (!vreg_sts)
+			return 0;
+
+		clear_bit(pdev->id, &vreg_sts);
+
+		if (!vreg_sts) {
+			rc = vreg_disable(vreg_mmc);
+			if (rc)
+				pr_err("vreg_mmc disable failed for slot "
+						"%d: %d\n", pdev->id, rc);
+		}
+		return 0;
+	}
+
+	if (!vreg_sts) {
+		rc = vreg_set_level(vreg_mmc, 2900);
+		if (rc)
+			pr_err("vreg_mmc set level failed for slot %d: %d\n",
+					pdev->id, rc);
+		rc = vreg_enable(vreg_mmc);
+		if (rc)
+			pr_err("vreg_mmc enable failed for slot %d: %d\n",
+					pdev->id, rc);
+	}
+	set_bit(pdev->id, &vreg_sts);
+	return 0;
+}
+
+static struct msm_mmc_gpio_data sdc1_gpio = {
+	.gpio = sdc1_gpio_cfg,
+	.size = ARRAY_SIZE(sdc1_gpio_cfg),
+};
+
+static struct msm_mmc_platform_data qsd8x50_sdc1_data = {
+	.ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
+	.translate_vdd	= msm_sdcc_setup_power,
+	.gpio_data = &sdc1_gpio,
+};
+
+static void __init qsd8x50_init_mmc(void)
+{
+	if (machine_is_qsd8x50_ffa() || machine_is_qsd8x50a_ffa())
+		vreg_mmc = vreg_get(NULL, "gp6");
+	else
+		vreg_mmc = vreg_get(NULL, "gp5");
+
+	if (IS_ERR(vreg_mmc)) {
+		pr_err("vreg get for vreg_mmc failed (%ld)\n",
+				PTR_ERR(vreg_mmc));
+		return;
+	}
+
+	msm_add_sdcc(1, &qsd8x50_sdc1_data, 0, 0);
+}
+
 static void __init qsd8x50_map_io(void)
 {
 	msm_map_qsd8x50_io();
@@ -113,6 +191,7 @@ static void __init qsd8x50_init(void)
 	msm_device_hsusb.dev.parent = &msm_device_otg.dev;
 	msm_device_hsusb_host.dev.parent = &msm_device_otg.dev;
 	platform_add_devices(devices, ARRAY_SIZE(devices));
+	qsd8x50_init_mmc();
 }
 
 MACHINE_START(QSD8X50_SURF, "QCT QSD8X50 SURF")
diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
index a4b798f..b1a8f0f 100644
--- a/arch/arm/mach-msm/devices-qsd8x50.c
+++ b/arch/arm/mach-msm/devices-qsd8x50.c
@@ -124,6 +124,194 @@ struct platform_device msm_device_hsusb_host = {
 	},
 };
 
+static struct resource resources_sdc1[] = {
+	{
+		.start	= MSM_SDC1_PHYS,
+		.end	= MSM_SDC1_PHYS + MSM_SDC1_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC1_0,
+		.end	= INT_SDC1_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+	{
+		.start	= INT_SDC1_1,
+		.end	= INT_SDC1_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource resources_sdc2[] = {
+	{
+		.start	= MSM_SDC2_PHYS,
+		.end	= MSM_SDC2_PHYS + MSM_SDC2_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC2_0,
+		.end	= INT_SDC2_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+		{
+		.start	= INT_SDC2_1,
+		.end	= INT_SDC2_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource resources_sdc3[] = {
+	{
+		.start	= MSM_SDC3_PHYS,
+		.end	= MSM_SDC3_PHYS + MSM_SDC3_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC3_0,
+		.end	= INT_SDC3_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+		{
+		.start	= INT_SDC3_1,
+		.end	= INT_SDC3_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct resource resources_sdc4[] = {
+	{
+		.start	= MSM_SDC4_PHYS,
+		.end	= MSM_SDC4_PHYS + MSM_SDC4_SIZE - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= INT_SDC4_0,
+		.end	= INT_SDC4_0,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "cmd_irq",
+	},
+		{
+		.start	= INT_SDC4_1,
+		.end	= INT_SDC4_1,
+		.flags	= IORESOURCE_IRQ,
+		.name	= "pio_irq",
+	},
+	{
+		.flags	= IORESOURCE_IRQ | IORESOURCE_DISABLED,
+		.name	= "status_irq"
+	},
+	{
+		.start	= 8,
+		.end	= 8,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+struct platform_device msm_device_sdc1 = {
+	.name		= "msm_sdcc",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(resources_sdc1),
+	.resource	= resources_sdc1,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+struct platform_device msm_device_sdc2 = {
+	.name		= "msm_sdcc",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(resources_sdc2),
+	.resource	= resources_sdc2,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+struct platform_device msm_device_sdc3 = {
+	.name		= "msm_sdcc",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(resources_sdc3),
+	.resource	= resources_sdc3,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+struct platform_device msm_device_sdc4 = {
+	.name		= "msm_sdcc",
+	.id		= 4,
+	.num_resources	= ARRAY_SIZE(resources_sdc4),
+	.resource	= resources_sdc4,
+	.dev		= {
+		.coherent_dma_mask	= 0xffffffff,
+	},
+};
+
+static struct platform_device *msm_sdcc_devices[] __initdata = {
+	&msm_device_sdc1,
+	&msm_device_sdc2,
+	&msm_device_sdc3,
+	&msm_device_sdc4,
+};
+
+int __init msm_add_sdcc(unsigned int controller,
+			struct msm_mmc_platform_data *plat,
+			unsigned int stat_irq, unsigned long stat_irq_flags)
+{
+	struct platform_device	*pdev;
+	struct resource *res;
+
+	if (controller < 1 || controller > 4)
+		return -EINVAL;
+
+	pdev = msm_sdcc_devices[controller-1];
+	pdev->dev.platform_data = plat;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "status_irq");
+	if (!res)
+		return -EINVAL;
+	else if (stat_irq) {
+		res->start = res->end = stat_irq;
+		res->flags &= ~IORESOURCE_DISABLED;
+		res->flags |= stat_irq_flags;
+	}
+
+	return platform_device_register(pdev);
+}
+
 struct clk msm_clocks_8x50[] = {
 	CLK_PCOM("adm_clk",	ADM_CLK,	NULL, 0),
 	CLK_PCOM("ebi1_clk",	EBI1_CLK,	NULL, CLK_MIN),
@@ -144,6 +332,14 @@ struct clk msm_clocks_8x50[] = {
 	CLK_PCOM("pbus_clk",	PBUS_CLK,	NULL, CLK_MIN),
 	CLK_PCOM("pcm_clk",	PCM_CLK,	NULL, 0),
 	CLK_PCOM("sdac_clk",	SDAC_CLK,	NULL, OFF),
+	CLK_PCOM("sdc_clk",	SDC1_CLK,	&msm_device_sdc1.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC1_P_CLK,	&msm_device_sdc1.dev, OFF),
+	CLK_PCOM("sdc_clk",	SDC2_CLK,	&msm_device_sdc2.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC2_P_CLK,	&msm_device_sdc2.dev, OFF),
+	CLK_PCOM("sdc_clk",	SDC3_CLK,	&msm_device_sdc3.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC3_P_CLK,	&msm_device_sdc3.dev, OFF),
+	CLK_PCOM("sdc_clk",	SDC4_CLK,	&msm_device_sdc4.dev, OFF),
+	CLK_PCOM("sdc_pclk",	SDC4_P_CLK,	&msm_device_sdc4.dev, OFF),
 	CLK_PCOM("spi_clk",	SPI_CLK,	NULL, 0),
 	CLK_PCOM("tsif_clk",	TSIF_CLK,	NULL, 0),
 	CLK_PCOM("tsif_ref_clk",	TSIF_REF_CLK,	NULL, 0),
diff --git a/arch/arm/mach-msm/gpiomux-8x50.c b/arch/arm/mach-msm/gpiomux-8x50.c
index 4406e0f..f7a4ea5 100644
--- a/arch/arm/mach-msm/gpiomux-8x50.c
+++ b/arch/arm/mach-msm/gpiomux-8x50.c
@@ -16,6 +16,19 @@
  */
 #include "gpiomux.h"
 
+#if defined(CONFIG_MMC_MSM) || defined(CONFIG_MMC_MSM_MODULE)
+	#define SDCC_DAT_0_3_CMD_ACTV_CFG (GPIOMUX_VALID | GPIOMUX_PULL_UP\
+					| GPIOMUX_FUNC_1 | GPIOMUX_DRV_8MA)
+	#define SDCC_CLK_ACTV_CFG (GPIOMUX_VALID | GPIOMUX_PULL_NONE\
+					| GPIOMUX_FUNC_1 | GPIOMUX_DRV_8MA)
+#else
+	#define SDCC_DAT_0_3_CMD_ACTV_CFG 0
+	#define SDCC_CLK_ACTV_CFG 0
+#endif
+
+#define SDC1_SUSPEND_CONFIG (GPIOMUX_VALID | GPIOMUX_PULL_DOWN\
+				| GPIOMUX_FUNC_GPIO | GPIOMUX_DRV_2MA)
+
 struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
 	[86] = { /* UART3 RX */
 		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
@@ -25,4 +38,14 @@ struct msm_gpiomux_config msm_gpiomux_configs[GPIOMUX_NGPIOS] = {
 		.suspended = GPIOMUX_DRV_2MA | GPIOMUX_PULL_DOWN |
 			     GPIOMUX_FUNC_1 | GPIOMUX_VALID,
 	},
+	/* SDC1 data[3:0] & CMD */
+	[51 ... 55] = {
+		.active = SDCC_DAT_0_3_CMD_ACTV_CFG,
+		.suspended = SDC1_SUSPEND_CONFIG
+	},
+	/* SDC1 CLK */
+	[56] = {
+		.active = SDCC_CLK_ACTV_CFG,
+		.suspended = SDC1_SUSPEND_CONFIG
+	},
 };
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
index acc819e..732a965 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-8x50.h
@@ -132,16 +132,16 @@
 #define MSM_UART2DM_PHYS      0xA0900000
 
 
-#define MSM_SDC1_PHYS          0xA0400000
+#define MSM_SDC1_PHYS          0xA0300000
 #define MSM_SDC1_SIZE          SZ_4K
 
-#define MSM_SDC2_PHYS          0xA0500000
+#define MSM_SDC2_PHYS          0xA0400000
 #define MSM_SDC2_SIZE          SZ_4K
 
-#define MSM_SDC3_PHYS          0xA0600000
+#define MSM_SDC3_PHYS          0xA0500000
 #define MSM_SDC3_SIZE           SZ_4K
 
-#define MSM_SDC4_PHYS          0xA0700000
+#define MSM_SDC4_PHYS          0xA0600000
 #define MSM_SDC4_SIZE          SZ_4K
 
 #endif
-- 
1.7.1

--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
