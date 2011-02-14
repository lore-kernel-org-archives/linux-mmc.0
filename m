From: Shawn Guo <shawn.guo@freescale.com>
Subject: [PATCH v2 4/7] ARM: mxs: dynamically allocate mmc device
Date: Mon, 14 Feb 2011 10:32:23 +0800
Message-ID: <1297650746-12841-5-git-send-email-shawn.guo@freescale.com>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:26125
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754699Ab1BMSbE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 13 Feb 2011 13:31:04 -0500
In-Reply-To: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@freescale.com>

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c                  |   16 +++++
 arch/arm/mach-mxs/clock-mx28.c                  |   18 +++++
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mmc.c        |   80 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   13 ++++
 8 files changed, 139 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mmc.c

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index c19b69a..a1ed5f4 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -445,6 +445,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
 	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
+	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp_clk)
 	_REGISTER_CLOCK(NULL, "usb", usb_clk)
 	_REGISTER_CLOCK(NULL, "audio", audio_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
@@ -515,6 +516,15 @@ static int clk_misc_init(void)
 	__raw_writel(BM_CLKCTRL_CPU_INTERRUPT_WAIT,
 			CLKCTRL_BASE_ADDR + HW_CLKCTRL_CPU_SET);
 
+	/*
+	 * 480 MHz seems too high to be ssp clock source directly,
+	 * so set frac to get a 288 MHz ref_io.
+	 */
+	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC);
+	reg &= ~BM_CLKCTRL_FRAC_IOFRAC;
+	reg |= 30 << BP_CLKCTRL_FRAC_IOFRAC;
+	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC);
+
 	return 0;
 }
 
@@ -522,6 +532,12 @@ int __init mx23_clocks_init(void)
 {
 	clk_misc_init();
 
+	/*
+	 * source ssp clock from ref_io than ref_xtal,
+	 * as ref_xtal only provides 24 MHz as maximum.
+	 */
+	clk_set_parent(&ssp_clk, &ref_io_clk);
+
 	clk_enable(&cpu_clk);
 	clk_enable(&hbus_clk);
 	clk_enable(&xbus_clk);
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 9f4ee36..aeb7b2c 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -619,6 +619,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
 	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
 	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
+	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
+	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
@@ -730,6 +732,15 @@ static int clk_misc_init(void)
 	reg |= BM_CLKCTRL_ENET_CLK_OUT_EN;
 	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_ENET);
 
+	/*
+	 * 480 MHz seems too high to be ssp clock source directly,
+	 * so set frac0 to get a 288 MHz ref_io0.
+	 */
+	reg = __raw_readl(CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
+	reg &= ~BM_CLKCTRL_FRAC0_IO0FRAC;
+	reg |= 30 << BP_CLKCTRL_FRAC0_IO0FRAC;
+	__raw_writel(reg, CLKCTRL_BASE_ADDR + HW_CLKCTRL_FRAC0);
+
 	return 0;
 }
 
@@ -737,6 +748,13 @@ int __init mx28_clocks_init(void)
 {
 	clk_misc_init();
 
+	/*
+	 * source ssp clock from ref_io0 than ref_xtal,
+	 * as ref_xtal only provides 24 MHz as maximum.
+	 */
+	clk_set_parent(&ssp0_clk, &ref_io0_clk);
+	clk_set_parent(&ssp1_clk, &ref_io0_clk);
+
 	clk_enable(&cpu_clk);
 	clk_enable(&hbus_clk);
 	clk_enable(&xbus_clk);
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index 1256788..4419390 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -14,3 +14,7 @@
 extern const struct amba_device mx23_duart_device __initconst;
 #define mx23_add_duart() \
 	mxs_add_duart(&mx23_duart_device)
+
+extern const struct mxs_mmc_data mx23_mmc_data[] __initconst;
+#define mx23_add_mmc(id, pdata) \
+	mxs_add_mmc(&mx23_mmc_data[id], pdata)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 3b18304..540639d 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -32,3 +32,7 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 	mxs_add_flexcan(&mx28_flexcan_data[id], pdata)
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
+
+extern const struct mxs_mmc_data mx28_mmc_data[] __initconst;
+#define mx28_add_mmc(id, pdata) \
+	mxs_add_mmc(&mx28_mmc_data[id], pdata)
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 6c65b67..49307f8 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -11,3 +11,6 @@ config MXS_HAVE_PLATFORM_FEC
 config MXS_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
 	bool
+
+config MXS_HAVE_PLATFORM_MMC
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index ca7acc4..c0dacfd 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -3,3 +3,4 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-y += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MMC) += platform-mmc.o
diff --git a/arch/arm/mach-mxs/devices/platform-mmc.c b/arch/arm/mach-mxs/devices/platform-mmc.c
new file mode 100644
index 0000000..9065afa
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mmc.c
@@ -0,0 +1,80 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+/*
+ * mx23 reference manual is indexing all ssp resources, iomux, clock,
+ * dma channel etc from 1 than 0, while mx28 starts from 0 as normal.
+ */
+#define mx23_mmc_data_entry_single(_id)					\
+	{								\
+		.id = _id - 1,						\
+		.iobase = MX23_SSP ## _id ## _BASE_ADDR,		\
+		.dma = MX23_DMA_SSP ## _id,				\
+		.irq_err = MX23_INT_SSP ## _id ## _ERROR,		\
+		.irq_dma = MX23_INT_SSP ## _id ## _DMA,			\
+	}
+
+#define mx28_mmc_data_entry_single(_id)					\
+	{								\
+		.id = _id,						\
+		.iobase = MX28_SSP ## _id ## _BASE_ADDR,		\
+		.dma = MX28_DMA_SSP ## _id,				\
+		.irq_err = MX28_INT_SSP ## _id ## _ERROR,		\
+		.irq_dma = MX28_INT_SSP ## _id ## _DMA,			\
+	}
+
+#ifdef CONFIG_SOC_IMX23
+const struct mxs_mmc_data mx23_mmc_data[] __initconst = {
+	mx23_mmc_data_entry_single(1),
+	mx23_mmc_data_entry_single(2),
+};
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+const struct mxs_mmc_data mx28_mmc_data[] __initconst = {
+	mx28_mmc_data_entry_single(0),
+	mx28_mmc_data_entry_single(1),
+};
+#endif
+
+struct platform_device *__init mxs_add_mmc(
+		const struct mxs_mmc_data *data,
+		const struct mxs_mmc_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start	= data->iobase,
+			.end	= data->iobase + SZ_8K - 1,
+			.flags	= IORESOURCE_MEM,
+		}, {
+			.start	= data->dma,
+			.end	= data->dma,
+			.flags	= IORESOURCE_DMA,
+		}, {
+			.start	= data->irq_err,
+			.end	= data->irq_err,
+			.flags	= IORESOURCE_IRQ,
+		}, {
+			.start	= data->irq_dma,
+			.end	= data->irq_dma,
+			.flags	= IORESOURCE_IRQ,
+		},
+	};
+
+	return mxs_add_platform_device("mxs-mmc", data->id,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata));
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index e7aefb4..54710c5 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -63,3 +63,16 @@ struct mxs_flexcan_data {
 struct platform_device *__init mxs_add_flexcan(
 		const struct mxs_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
+
+/* mmc */
+#include <mach/mmc.h>
+struct mxs_mmc_data {
+	int id;
+	resource_size_t iobase;
+	resource_size_t dma;
+	resource_size_t irq_err;
+	resource_size_t irq_dma;
+};
+struct platform_device *__init mxs_add_mmc(
+		const struct mxs_mmc_data *data,
+		const struct mxs_mmc_platform_data *pdata);
-- 
1.7.1


